import 'dart:convert';

import 'package:fern/screens/activity_screen.dart';
import 'package:fern/screens/stats_screen.dart';
import 'package:fern/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'support/fixtures.dart';

Future<void> _pumpActivity(WidgetTester tester, state) async {
  tester.view.physicalSize = const Size(800, 2000);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(() {
    tester.view.physicalSize = const Size(800, 600);
    tester.view.devicePixelRatio = 1.0;
  });
  await tester.pumpWidget(
    MaterialApp(
      theme: Fern.buildTheme(brightness: Brightness.light, seed: Fern.green),
      home: ActivityScreen(state: state),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
}

void main() {
  setUpAll(mockNetworkImages);

  test('stats calendar ranges contain the advertised number of months', () {
    expect(statsRangeStart(DateTime(2026, 9, 30), 6), DateTime(2026, 4, 1));
    expect(statsRangeStart(DateTime(2026, 9, 30), 12), DateTime(2025, 10, 1));
    expect(statsRangeStart(DateTime(2024, 3, 31), 6), DateTime(2023, 10, 1));
  });

  test('a failed transaction sync can be retried immediately', () async {
    var transactionCalls = 0;
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
        transactionCalls++;
        if (transactionCalls == 1) {
          return http.Response(
            json.encode({'success': false, 'message': 'temporary failure'}),
            500,
          );
        }
        return http.Response(
          json.encode({
            'success': true,
            'items': [mcdonaldsBurger().toJson()],
            'cursor': {'next': null},
          }),
          200,
        );
      }
      return http.Response(json.encode({'success': false}), 404);
    });
    final state = await seededState(api: fakeApi(client: client));
    addTearDown(state.dispose);

    await state.load();
    expect(transactionCalls, 1);
    expect(state.offline, isTrue);
    expect(state.error, isNotNull);
    expect(state.lastSync, isNotNull);

    await state.load();

    expect(transactionCalls, 2);
    expect(state.offline, isFalse);
    expect(state.error, isNull);
  });

  test('ensureAllData follows every transaction cursor to the end', () async {
    var transactionCalls = 0;
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
        transactionCalls++;
        final cursor = req.url.queryParameters['cursor'];
        final (item, next) = switch (cursor) {
          null => (mcdonaldsBurger(), 'page-2'),
          'page-2' => (uberTrip(), 'page-3'),
          _ => (bpFuel(), null),
        };
        return http.Response(
          json.encode({
            'success': true,
            'items': [item.toJson()],
            'cursor': {'next': next},
          }),
          200,
        );
      }
      return http.Response(json.encode({'success': false}), 404);
    });
    final state = await seededState(api: fakeApi(client: client));
    addTearDown(state.dispose);

    await state.load();
    expect(state.txnCursor, 'page-2');

    await state.ensureAllData();
    await Future<void>.delayed(Duration.zero);

    expect(transactionCalls, 3);
    expect(state.txnCursor, isNull);
    expect(
      state.transactions.map((tx) => tx.id),
      containsAll([mcdonaldsBurger().id, uberTrip().id, bpFuel().id]),
    );
  });

  test(
    'spending stats exclude internal transfers unless explicitly filtered',
    () async {
      final db = testDb();
      addTearDown(db.close);
      await db.saveTransactions([internalTransfer(), mcdonaldsBurger()]);

      final categories = await db.queryCategoryTotals().first;
      final weekly = await db.queryWeeklyTrend().first;
      final merchants = await db.queryTopMerchants().first;

      expect(categories, isNot(contains('Transfers')));
      expect(categories['Lifestyle'], closeTo(14.90, 0.001));
      expect(
        weekly.values.fold<double>(0, (sum, value) => sum + value),
        closeTo(14.90, 0.001),
      );
      expect(merchants.keys, isNot(contains('TRANSFER TO ASB STREAMLINE')));

      final transfersOnly = await db
          .queryCategoryTotals(categoryFilter: {'Transfers'})
          .first;
      expect(transfersOnly['Transfers'], closeTo(500.00, 0.001));
    },
  );

  test('overview monthly spending excludes internal transfers', () async {
    final db = testDb();
    addTearDown(db.close);
    final today = DateTime.now().toUtc().toIso8601String();
    await db.saveTransactions([
      internalTransfer(date: today),
      mcdonaldsBurger(date: today),
    ]);

    final spending = await db.watchMonthlySpendByGroup().first;

    expect(spending, isNot(contains('Transfers')));
    expect(spending['Lifestyle'], closeTo(14.90, 0.001));
  });

  testWidgets('activity search uses the effective recategorized category', (
    tester,
  ) async {
    final tx = mcdonaldsBurger();
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      transactions: [tx],
    );
    addTearDown(state.dispose);
    await state.saveCategoryOverride(tx.id, 'Cafes and restaurants');
    await tester.pump();
    await _pumpActivity(tester, state);

    await tester.enterText(find.byType(TextField), 'cafes');
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text("McDonald's"), findsOneWidget);
    expect(find.text('No transactions'), findsNothing);
  });
}
