import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import '../support/fixtures.dart';

void main() {
  group('reactive accounts/transactions', () {
    test('seeded accounts populate visibleAccounts and totalBalance', () async {
      final state = await seededState(
        accounts: [
          anzEveryday(balance: 2450.32),
          asbStreamline(balance: 8120.11),
        ],
      );

      expect(
        state.accounts.map((a) => a.name),
        containsAll(['ANZ Everyday', 'ASB Streamline']),
      );
      expect(
        state.visibleAccounts.map((a) => a.name),
        containsAll(['ANZ Everyday', 'ASB Streamline']),
      );
      expect(state.totalBalance, closeTo(2450.32 + 8120.11, 0.001));
    });

    test(
      'an Amex credit card debt account is excluded from visibleAccounts when showDebt is off',
      () async {
        final settings = await testSettings();
        await settings.setShowDebt(false);
        final state = await seededState(
          accounts: [
            anzEveryday(balance: 2450.32),
            amexCreditCard(owing: 512.40),
          ],
          settings: settings,
        );

        expect(state.accounts, hasLength(2));
        expect(state.visibleAccounts.map((a) => a.name), ['ANZ Everyday']);
        expect(state.totalBalance, closeTo(2450.32, 0.001));
      },
    );

    test('transactions are ordered by date, newest first', () async {
      final state = await seededState(
        transactions: [
          mcdonaldsBurger(date: '2026-07-01T00:00:00.000Z'),
          uberTrip(date: '2026-07-20T00:00:00.000Z'),
          bpFuel(date: '2026-07-10T00:00:00.000Z'),
        ],
      );

      expect(state.transactions.map((t) => t.merchant?.name), [
        'Uber',
        'BP',
        "McDonald's",
      ]);
    });
  });

  group('categorisation', () {
    test(
      'categoryNameFor/categoryGroupFor fall back to AutoCategorizer for an uncategorised McDonald\'s purchase',
      () async {
        final fixtureTx = mcdonaldsBurger();
        final state = await seededState(transactions: [fixtureTx]);
        final tx = state.transactions.first;

        expect(state.categoryNameFor(tx), 'Fast food stores');
        expect(state.categoryGroupFor(tx), 'Lifestyle');
        expect(state.isAutoCategory(tx), isTrue);
        expect(state.hasOverride(tx.id), isFalse);
      },
    );

    test(
      'saveCategoryOverride overrides the McDonald\'s category to "Cafes and restaurants"',
      () async {
        final fixtureTx = mcdonaldsBurger();
        final state = await seededState(transactions: [fixtureTx]);

        await state.saveCategoryOverride(fixtureTx.id, 'Cafes and restaurants');
        final tx = state.transactions.first;

        expect(state.categoryNameFor(tx), 'Cafes and restaurants');
        expect(state.categoryGroupFor(tx), 'Lifestyle');
        expect(state.hasOverride(tx.id), isTrue);
        expect(state.isAutoCategory(tx), isFalse);
      },
    );

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

  group('image rules (exact reproduction of the txn_detail pick-image flow)', () {
    test(
      'setting an image via matchTextFor+saveTransactionImage shows up on imagePathFor for the same tx',
      () async {
        final fixtureTx = mcdonaldsBurger();
        final state = await seededState(transactions: [fixtureTx]);
        final tx = state.transactions.first;

        expect(state.imagePathFor(tx), isNull);

        final hay = state.matchTextFor(tx);
        await state.saveTransactionImage(
          tx,
          '/tmp/fake_image.png',
          exact: true,
          matchText: hay,
        );

        expect(
          state.imagePathFor(state.transactions.first),
          '/tmp/fake_image.png',
        );
      },
    );

    test(
      'exact match also applies to a different transaction with the identical merchant+description',
      () async {
        final tx1 = mcdonaldsBurger(date: '2026-07-01T00:00:00.000Z');
        final tx2 = mcdonaldsBurger(date: '2026-07-20T00:00:00.000Z');
        final state = await seededState(transactions: [tx1, tx2]);

        final target = state.transactions.firstWhere((t) => t.id == tx1.id);
        final hay = state.matchTextFor(target);
        await state.saveTransactionImage(
          target,
          '/tmp/fake_image.png',
          exact: true,
          matchText: hay,
        );

        for (final t in state.transactions) {
          expect(state.imagePathFor(t), '/tmp/fake_image.png');
        }
      },
    );
  });

  group('load / loadOlder', () {
    test(
      'load() fetches the user, accounts and transactions from a fake Akahu API and caches them',
      () async {
        final client = MockClient((req) async {
          if (req.url.path == '/v1/me') {
            return http.Response(
              json.encode({
                'success': true,
                'item': {
                  '_id': 'user_2n2crlefk9enq9dp8dv3f',
                  'email': 'test@example.com',
                },
              }),
              200,
            );
          }
          if (req.url.path == '/v1/accounts') {
            return http.Response(
              json.encode({
                'success': true,
                'items': [anzEveryday().toJson()],
              }),
              200,
            );
          }
          if (req.url.path == '/v1/transactions') {
            return http.Response(
              json.encode({
                'success': true,
                'items': [mcdonaldsBurger().toJson(), uberTrip().toJson()],
                'cursor': {'next': null},
              }),
              200,
            );
          }
          return http.Response(json.encode({'success': false}), 404);
        });
        final state = await seededState(api: fakeApi(client: client));

        await state.load();
        await Future.delayed(Duration.zero);
        await Future.delayed(Duration.zero);

        expect(state.user?.email, 'test@example.com');
        expect(state.accounts.map((a) => a.name), contains('ANZ Everyday'));
        expect(
          state.transactions.map((t) => t.merchant?.name),
          containsAll(['Uber', "McDonald's"]),
        );
        expect(state.offline, isFalse);
        expect(state.lastSync, isNotNull);
      },
    );

    test(
      'load() marks offline and keeps an error message when the fake API fails',
      () async {
        final client = MockClient(
          (req) async => http.Response(
            json.encode({'success': false, 'message': 'boom'}),
            500,
          ),
        );
        final state = await seededState(api: fakeApi(client: client));

        await state.load();

        expect(state.offline, isTrue);
        expect(state.error, isNotNull);
      },
    );

    test(
      'loadOlder() fetches the next page using the cursor from a prior load()',
      () async {
        var page = 0;
        final client = MockClient((req) async {
          if (req.url.path == '/v1/me') {
            return http.Response(
              json.encode({
                'success': true,
                'item': {
                  '_id': 'user_2n2crlefk9enq9dp8dv3f',
                  'email': 'test@example.com',
                },
              }),
              200,
            );
          }
          if (req.url.path == '/v1/accounts') {
            return http.Response(
              json.encode({
                'success': true,
                'items': [anzEveryday().toJson()],
              }),
              200,
            );
          }
          if (req.url.path == '/v1/transactions') {
            page++;
            if (page <= 1) {
              return http.Response(
                json.encode({
                  'success': true,
                  'items': [mcdonaldsBurger().toJson()],
                  'cursor': {'next': 'cursor_page_$page'},
                }),
                200,
              );
            }
            return http.Response(
              json.encode({
                'success': true,
                'items': [uberTrip().toJson()],
                'cursor': {'next': null},
              }),
              200,
            );
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

        expect(
          state.transactions.map((t) => t.merchant?.name),
          containsAll(['Uber', "McDonald's"]),
        );
        expect(state.txnCursor, isNull);
      },
    );
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
