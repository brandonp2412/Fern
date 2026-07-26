import 'dart:convert';

import 'package:fern/state/app_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import '../support/fixtures.dart';

void main() {
  group('reactive accounts/transactions', () {
    test('seeded accounts populate visibleAccounts and totalBalance', () async {
      final state = await seededState(accounts: [anzEveryday(balance: 2450.32), asbStreamline(balance: 8120.11)]);

      expect(state.accounts.map((a) => a.name), containsAll(['ANZ Everyday', 'ASB Streamline']));
      expect(state.visibleAccounts.map((a) => a.name), containsAll(['ANZ Everyday', 'ASB Streamline']));
      expect(state.totalBalance, closeTo(2450.32 + 8120.11, 0.001));
    });

    test('an Amex credit card debt account is excluded from visibleAccounts when showDebt is off', () async {
      final settings = await testSettings();
      await settings.setShowDebt(false);
      final state = await seededState(
        accounts: [anzEveryday(balance: 2450.32), amexCreditCard(owing: 512.40)],
        settings: settings,
      );

      expect(state.accounts, hasLength(2));
      expect(state.visibleAccounts.map((a) => a.name), ['ANZ Everyday']);
      expect(state.totalBalance, closeTo(2450.32, 0.001));
    });

    test('transactions are ordered by date, newest first', () async {
      final state = await seededState(transactions: [
        mcdonaldsBurger(date: '2026-07-01T00:00:00.000Z'),
        uberTrip(date: '2026-07-20T00:00:00.000Z'),
        bpFuel(date: '2026-07-10T00:00:00.000Z'),
      ]);

      expect(state.transactions.map((t) => t.merchant?.name), ['Uber', 'BP', "McDonald's"]);
    });
  });

  group('spendByGroup', () {
    test('sums this month\'s spend by category group, largest first', () async {
      final now = DateTime.now();
      final thisMonth = DateTime(now.year, now.month, 15).toUtc().toIso8601String();
      final state = await seededState(transactions: [
        mcdonaldsBurger(date: thisMonth),
        bpFuel(date: thisMonth),
        uberTrip(date: thisMonth),
      ]);

      final spend = state.spendByGroup;
      expect(spend['Transport'], closeTo(23.50 + 87.20, 0.001));
      expect(spend['Lifestyle'], closeTo(14.90, 0.001));
      expect(spend.keys.first, 'Transport');
    });

    test('recomputes when transactions list identity changes', () async {
      final db = testDb();
      final state = await seededState(db: db);
      expect(state.spendByGroup, isEmpty);

      final now = DateTime.now();
      final thisMonth = DateTime(now.year, now.month, 15).toUtc().toIso8601String();
      final mcdonalds = mcdonaldsBurger(date: thisMonth);
      await db.saveTransactions([mcdonalds]);
      await Future.delayed(Duration.zero);
      await Future.delayed(Duration.zero);

      expect(state.spendByGroup['Lifestyle'], closeTo(14.90, 0.001));
    });
  });

  group('aggregations', () {
    test('aggMonthly buckets income and expense into the current month', () async {
      final now = DateTime.now();
      final thisMonth = DateTime(now.year, now.month, 15).toUtc().toIso8601String();
      final state = await seededState(transactions: [
        payday(date: thisMonth, amount: 3200.00),
        mcdonaldsBurger(date: thisMonth),
      ]);

      final current = state.aggMonthly.last;
      expect(current.income, closeTo(3200.00, 0.001));
      expect(current.expense, closeTo(14.90, 0.001));
    });

    test('aggCategories sums spend per group, largest first', () async {
      final state = await seededState(transactions: [bpFuel(), uberTrip(), mcdonaldsBurger()]);

      expect(state.aggCategories.first.name, 'Transport');
      expect(state.aggCategories.first.amount, closeTo(23.50 + 87.20, 0.001));
    });

    test('aggMerchants ranks real merchant names by spend', () async {
      final state = await seededState(transactions: [
        mcdonaldsBurger(),
        uberTrip(),
        bpFuel(),
      ]);

      expect(state.aggMerchants.map((m) => m.name), contains('BP'));
      expect(state.aggMerchants.first.name, 'BP');
      expect(state.aggMerchants.first.amount, closeTo(87.20, 0.001));
    });

    test('aggWeekly groups spend within the trailing window by week start', () async {
      final state = await seededState(transactions: [bpFuel(), uberTrip(), mcdonaldsBurger()]);
      expect(state.aggWeekly, isNotEmpty);
      expect(state.aggWeekly.fold(0.0, (sum, w) => sum + w.total), closeTo(87.20 + 23.50 + 14.90, 0.001));
    });
  });

  group('categorisation', () {
    test('categoryNameFor/categoryGroupFor fall back to AutoCategorizer for an uncategorised McDonald\'s purchase', () async {
      final fixtureTx = mcdonaldsBurger();
      final state = await seededState(transactions: [fixtureTx]);
      final tx = state.transactions.first;

      expect(state.categoryNameFor(tx), 'Fast food stores');
      expect(state.categoryGroupFor(tx), 'Lifestyle');
      expect(state.isAutoCategory(tx), isTrue);
      expect(state.hasOverride(tx.id), isFalse);
    });

    test('saveCategoryOverride overrides the McDonald\'s category to "Cafes and restaurants"', () async {
      final fixtureTx = mcdonaldsBurger();
      final state = await seededState(transactions: [fixtureTx]);

      await state.saveCategoryOverride(fixtureTx.id, 'Cafes and restaurants');
      final tx = state.transactions.first;

      expect(state.categoryNameFor(tx), 'Cafes and restaurants');
      expect(state.categoryGroupFor(tx), 'Lifestyle');
      expect(state.hasOverride(tx.id), isTrue);
      expect(state.isAutoCategory(tx), isFalse);
    });

    test('clearCategoryOverride reverts back to the auto category', () async {
      final fixtureTx = mcdonaldsBurger();
      final state = await seededState(transactions: [fixtureTx]);
      await state.saveCategoryOverride(fixtureTx.id, 'Cafes and restaurants');

      await state.clearCategoryOverride(fixtureTx.id);

      final tx = state.transactions.first;
      expect(state.hasOverride(tx.id), isFalse);
      expect(state.categoryNameFor(tx), 'Fast food stores');
    });
  });

  group('load / loadOlder', () {
    test('load() fetches the user, accounts and transactions from a fake Akahu API and caches them', () async {
      final client = MockClient((req) async {
        if (req.url.path == '/v1/me') {
          return http.Response(
              json.encode({
                'success': true,
                'item': {'_id': 'user_2n2crlefk9enq9dp8dv3f', 'email': 'test@example.com'},
              }),
              200);
        }
        if (req.url.path == '/v1/accounts') {
          return http.Response(
              json.encode({
                'success': true,
                'items': [anzEveryday().toJson()],
              }),
              200);
        }
        if (req.url.path == '/v1/transactions') {
          return http.Response(
              json.encode({
                'success': true,
                'items': [mcdonaldsBurger().toJson(), uberTrip().toJson()],
                'cursor': {'next': null},
              }),
              200);
        }
        return http.Response(json.encode({'success': false}), 404);
      });
      final state = await seededState(api: fakeApi(client: client));

      await state.load();
      await Future.delayed(Duration.zero);
      await Future.delayed(Duration.zero);

      expect(state.user?.email, 'test@example.com');
      expect(state.accounts.map((a) => a.name), contains('ANZ Everyday'));
      expect(state.transactions.map((t) => t.merchant?.name), containsAll(['Uber', "McDonald's"]));
      expect(state.offline, isFalse);
      expect(state.lastSync, isNotNull);
    });

    test('load() marks offline and keeps an error message when the fake API fails', () async {
      final client = MockClient((req) async => http.Response(json.encode({'success': false, 'message': 'boom'}), 500));
      final state = await seededState(api: fakeApi(client: client));

      await state.load();

      expect(state.offline, isTrue);
      expect(state.error, isNotNull);
    });

    test('loadOlder() fetches the next page using the cursor from a prior load()', () async {
      var page = 0;
      final client = MockClient((req) async {
        if (req.url.path == '/v1/me') {
          return http.Response(
              json.encode({
                'success': true,
                'item': {'_id': 'user_2n2crlefk9enq9dp8dv3f', 'email': 'test@example.com'},
              }),
              200);
        }
        if (req.url.path == '/v1/accounts') {
          return http.Response(json.encode({'success': true, 'items': [anzEveryday().toJson()]}), 200);
        }
        if (req.url.path == '/v1/transactions') {
          page++;
          if (page <= 5) {
            return http.Response(
                json.encode({
                  'success': true,
                  'items': [mcdonaldsBurger().toJson()],
                  'cursor': {'next': 'cursor_page_$page'},
                }),
                200);
          }
          return http.Response(
              json.encode({
                'success': true,
                'items': [uberTrip().toJson()],
                'cursor': {'next': null},
              }),
              200);
        }
        return http.Response(json.encode({'success': false}), 404);
      });
      final state = await seededState(api: fakeApi(client: client));
      await state.load();
      await Future.delayed(Duration.zero);
      await Future.delayed(Duration.zero);
      expect(state.transactions.map((t) => t.merchant?.name), ["McDonald's"]);
      expect(state.txnCursor, isNotNull);

      await state.loadOlder();
      await Future.delayed(Duration.zero);
      await Future.delayed(Duration.zero);

      expect(state.transactions.map((t) => t.merchant?.name), containsAll(['Uber', "McDonald's"]));
      expect(state.txnCursor, isNull);
    });
  });

  group('accountById', () {
    test('finds a seeded ASB Streamline account by its real id', () async {
      final asb = asbStreamline();
      final state = await seededState(accounts: [anzEveryday(), asb]);

      expect(state.accountById(asb.id)?.name, 'ASB Streamline');
      expect(state.accountById('acc_does_not_exist'), isNull);
    });
  });
}
