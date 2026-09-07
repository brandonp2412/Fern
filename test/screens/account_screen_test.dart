import 'dart:convert';

import 'package:fern/models/account.dart';
import 'package:fern/models/transaction.dart';
import 'package:fern/screens/account_screen.dart';
import 'package:fern/state/app_state.dart';
import 'package:fern/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import '../support/fixtures.dart';

Future<void> _pump(WidgetTester tester, AppState state, Account account) async {
  tester.view.physicalSize = const Size(800, 2000);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(() {
    tester.view.physicalSize = const Size(800, 600);
    tester.view.devicePixelRatio = 1.0;
  });
  await tester.pumpWidget(
    MaterialApp(
      theme: Fern.buildTheme(brightness: Brightness.light, seed: Fern.green),
      home: AccountScreen(state: state, account: account),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
}

void main() {
  setUpAll(mockNetworkImages);

  testWidgets('shows account name in app bar and balance hero', (tester) async {
    final a = anzEveryday(balance: 2450.32);

    final state = await seededState(
      tester: tester,
      accounts: [a],
      api: fakeApi(
        client: MockClient((req) async {
          if (req.url.path.contains('/transactions/pending')) {
            return http.Response(
              jsonEncode({'success': true, 'items': []}),
              200,
            );
          }
          return http.Response(
            jsonEncode({'success': true, 'items': [], 'cursor': null}),
            200,
          );
        }),
      ),
      db: testDb(),
    );

    await _pump(tester, state, a);

    expect(find.text('ANZ Everyday'), findsOneWidget);
    expect(find.text("\$2,450.32"), findsOneWidget);
  });

  testWidgets('shows masked balance when hideBalances is on', (tester) async {
    final a = anzEveryday(balance: 2450.32);
    final settings = await testSettings();
    await settings.setHideBalances(true);

    final state = await seededState(
      tester: tester,
      accounts: [a],
      settings: settings,
      api: fakeApi(
        client: MockClient((req) async {
          if (req.url.path.contains('/transactions/pending')) {
            return http.Response(
              jsonEncode({'success': true, 'items': []}),
              200,
            );
          }
          return http.Response(
            jsonEncode({'success': true, 'items': [], 'cursor': null}),
            200,
          );
        }),
      ),
      db: testDb(),
    );

    await _pump(tester, state, a);

    expect(find.text('••••'), findsWidgets);
    expect(find.textContaining('\$2,450'), findsNothing);
  });

  testWidgets('shows pending transactions section', (tester) async {
    final a = anzEveryday();
    final pendingJson = {
      '_account': a.id,
      '_connection': 'conn_anz',
      'date': '2026-07-25T00:00:00.000Z',
      'description': 'ALDI Auckland',
      'amount': -38.50,
      'type': 'EFTPOS',
    };

    final state = await seededState(
      tester: tester,
      accounts: [a],
      api: fakeApi(
        client: MockClient((req) async {
          if (req.url.path.contains('/transactions/pending')) {
            return http.Response(
              jsonEncode({
                'success': true,
                'items': [pendingJson],
              }),
              200,
            );
          }
          return http.Response(
            jsonEncode({'success': true, 'items': [], 'cursor': null}),
            200,
          );
        }),
      ),
      db: testDb(),
    );

    await _pump(tester, state, a);

    expect(find.text('Pending (1)'), findsOneWidget);
    expect(find.text('ALDI Auckland'), findsOneWidget);
    expect(find.textContaining('\$38.50'), findsOneWidget);
  });

  testWidgets('shows transactions from cache', (tester) async {
    final a = anzEveryday();
    final tx = mcdonaldsBurger(account: a.id);

    final state = await seededState(
      tester: tester,
      accounts: [a],
      transactions: [tx],
      api: fakeApi(
        client: MockClient((req) async {
          if (req.url.path.contains('/transactions/pending')) {
            return http.Response(
              jsonEncode({'success': true, 'items': []}),
              200,
            );
          }
          return http.Response(
            jsonEncode({'success': true, 'items': [], 'cursor': null}),
            200,
          );
        }),
      ),
    );

    await _pump(tester, state, a);

    expect(find.text("McDonald's"), findsOneWidget);
  });

  testWidgets('shows empty state when no transactions', (tester) async {
    final a = anzEveryday();

    final state = await seededState(
      tester: tester,
      accounts: [a],
      api: fakeApi(
        client: MockClient((req) async {
          if (req.url.path.contains('/transactions/pending')) {
            return http.Response(
              jsonEncode({'success': true, 'items': []}),
              200,
            );
          }
          return http.Response(
            jsonEncode({'success': true, 'items': [], 'cursor': null}),
            200,
          );
        }),
      ),
    );

    await _pump(tester, state, a);

    expect(find.text('No transactions found'), findsOneWidget);
  });

  testWidgets('shows a large transaction history as it is scrolled', (
    tester,
  ) async {
    final a = anzEveryday();
    final transactions = List.generate(
      500,
      (index) => Transaction(
        id: 'txn_$index',
        account: a.id,
        date: DateTime.utc(
          2026,
          7,
          31,
        ).subtract(Duration(hours: index)).toIso8601String(),
        description: 'Transaction $index',
        amount: -index,
        type: 'EFTPOS',
      ),
    );
    final state = await seededState(
      tester: tester,
      accounts: [a],
      transactions: transactions,
      api: fakeApi(
        client: MockClient((req) async {
          if (req.url.path.contains('/transactions/pending')) {
            return http.Response(
              jsonEncode({'success': true, 'items': []}),
              200,
            );
          }
          return http.Response(
            jsonEncode({'success': true, 'items': [], 'cursor': null}),
            200,
          );
        }),
      ),
    );

    await _pump(tester, state, a);

    expect(find.text('Transaction 0'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Transaction 200'), 300);
    expect(find.text('Transaction 200'), findsOneWidget);
  });

  testWidgets('load more reveals transactions beyond the initial 500 rows', (
    tester,
  ) async {
    final a = anzEveryday();
    final cached = List.generate(
      500,
      (index) => Transaction(
        id: 'cached_$index',
        account: a.id,
        date: DateTime.utc(
          2026,
          8,
          31,
        ).subtract(Duration(hours: index)).toIso8601String(),
        description: 'Cached transaction $index',
        amount: -(index + 1),
        type: 'EFTPOS',
      ),
    );
    final olderDate = DateTime.utc(2026, 7, 1).toIso8601String();
    final older = Transaction(
      id: 'older_501',
      account: a.id,
      connection: 'conn_anz',
      user: 'user_test_token',
      date: olderDate,
      description: 'Older transaction revealed',
      amount: -501,
      type: 'EFTPOS',
      createdAt: olderDate,
      updatedAt: olderDate,
    );
    var transactionCalls = 0;
    final state = await seededState(
      tester: tester,
      accounts: [a],
      transactions: cached,
      api: fakeApi(
        client: MockClient((req) async {
          if (req.url.path.contains('/transactions/pending')) {
            return http.Response(
              jsonEncode({'success': true, 'items': []}),
              200,
            );
          }
          transactionCalls++;
          if (transactionCalls == 1) {
            return http.Response(
              jsonEncode({
                'success': true,
                'items': [],
                'cursor': {'next': 'older-page'},
              }),
              200,
            );
          }
          return http.Response(
            jsonEncode({
              'success': true,
              'items': [older.toJson()],
              'cursor': {'next': null},
            }),
            200,
          );
        }),
      ),
    );

    await _pump(tester, state, a);
    await tester.drag(find.byType(CustomScrollView), const Offset(0, -100000));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.drag(find.byType(CustomScrollView), const Offset(0, -1000));
    await tester.pump(const Duration(milliseconds: 500));

    expect(transactionCalls, greaterThanOrEqualTo(2));
    expect(find.text('Older transaction revealed'), findsOneWidget);
  });
}
