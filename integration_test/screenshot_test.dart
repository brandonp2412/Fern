import 'package:fern/db/app_database.dart';
import 'package:fern/models/account.dart';
import 'package:fern/models/transaction.dart';
import 'package:fern/screens/home_shell.dart';
import 'package:fern/services/akahu_api.dart';
import 'package:fern/state/app_settings.dart';
import 'package:fern/state/app_state.dart';
import 'package:fern/theme.dart';
import 'package:fern/widgets/txn_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:integration_test/integration_test.dart';

// HomeShell.initState() unconditionally calls state.load(), which would
// otherwise hit the real Akahu API with fake tokens and hang waiting for
// network from inside the Waydroid sandbox. Fail instantly instead.
final _offlineClient = MockClient((request) async => throw Exception('offline (screenshot test)'));

const _merchants = <String, String>{
  'New World': 'Groceries',
  'Countdown': 'Groceries',
  'BP Connect': 'Transport',
  'Spotify': 'Entertainment',
  'Netflix': 'Entertainment',
  'Mighty Ape': 'Shopping',
  'Z Energy': 'Transport',
  'The Coffee Club': 'Dining',
  'Uber Eats': 'Dining',
  'Chemist Warehouse': 'Health',
};

List<Account> _fakeAccounts() => [
      Account(
        id: 'acc_checking',
        name: 'Everyday Account',
        type: 'CHECKING',
        attributes: const ['TRANSACTIONS', 'PAYMENT_FROM', 'PAYMENT_TO'],
        formattedAccount: '12-3456-7890123-00',
        connection: AccountConnection(
          id: 'conn_bank',
          name: 'ANZ',
          logo: '',
        ),
        balance: AccountBalance(current: 2431.55, available: 2431.55),
      ),
      Account(
        id: 'acc_savings',
        name: 'Savings',
        type: 'SAVINGS',
        attributes: const ['TRANSACTIONS'],
        formattedAccount: '12-3456-7890123-01',
        connection: AccountConnection(
          id: 'conn_bank',
          name: 'ANZ',
          logo: '',
        ),
        balance: AccountBalance(current: 8760.12, available: 8760.12),
      ),
      Account(
        id: 'acc_credit',
        name: 'Credit Card',
        type: 'CREDITCARD',
        attributes: const ['TRANSACTIONS', 'PAYMENT_FROM'],
        formattedAccount: '4835 xxxx xxxx 1123',
        connection: AccountConnection(
          id: 'conn_bank',
          name: 'ANZ',
          logo: '',
        ),
        balance: AccountBalance(current: -412.30, available: 1587.70, limit: 2000),
      ),
    ];

Transaction _fakeTransaction(int i, DateTime date, List<String> names, {bool forceSpend = false}) {
  final merchant = names[i % names.length];
  final category = _merchants[merchant]!;
  final isIncome = !forceSpend && i % 11 == 0;
  final amount = isIncome ? 1850.0 : -(12.5 + (i % 9) * 8.35);

  return Transaction(
    id: 'trans_$i',
    account: i % 5 == 0 ? 'acc_savings' : 'acc_checking',
    date: date.toUtc().toIso8601String(),
    description: isIncome ? 'Salary' : merchant,
    amount: amount,
    type: isIncome ? 'CREDIT' : 'DEBIT',
    merchant: isIncome ? null : TransactionMerchant(id: 'merch_$i', name: merchant),
    category: isIncome
        ? null
        : TransactionCategory(
            id: 'cat_$i',
            name: category,
            groups: {
              'personal_finance': CategoryGroup(id: 'grp_$category', name: category),
            },
          ),
  );
}

List<Transaction> _fakeTransactions() {
  final txns = <Transaction>[];
  final now = DateTime.now();
  final startOfMonth = DateTime(now.year, now.month, 1);
  final names = _merchants.keys.toList();
  var index = 0;

  // Guarantee one forced-spend transaction per merchant lands within the
  // *current* calendar month, spread evenly across however much of the
  // month has elapsed so far (even if that's only a few hours), so the
  // Overview "Spending this month" card always shows a realistic
  // multi-category breakdown regardless of what day of the month the
  // screenshot happens to be taken. Spacing every transaction "N days
  // before now" made this flaky: near the start of a month, day 0 is
  // income and every other sample lands in the previous month, leaving
  // nothing (or just one category) for the current-month spend query.
  final monthHours = now.difference(startOfMonth).inHours;
  for (var j = 0; j < names.length; j++) {
    final hoursBack = (j * monthHours) ~/ (names.length - 1);
    final date = now.subtract(Duration(hours: hoursBack));
    txns.add(_fakeTransaction(index, date, names, forceSpend: true));
    index++;
  }

  // Fill out the rest of the history further back, starting before the 1st
  // of this month so these never collide with the guaranteed in-month set.
  var historyStep = 0;
  while (index < 30) {
    final date = startOfMonth.subtract(Duration(days: 1 + historyStep * 2));
    txns.add(_fakeTransaction(index, date, names));
    index++;
    historyStep++;
  }

  return txns;
}

Future<AppState> _seedState() async {
  final db = AppDatabase();
  await db.delete(db.transactions).go();
  await db.delete(db.accounts).go();
  await db.delete(db.categoryOverrides).go();
  await db.saveAccounts(_fakeAccounts());
  await db.saveTransactions(_fakeTransactions());

  final settings = AppSettings()..seedColor = Fern.green;
  final api = AkahuApi(userToken: 'screenshot', appToken: 'screenshot', client: _offlineClient);
  final state = AppState(api, settings, db: db);

  // Wait for the DB watch streams to actually deliver the seeded rows,
  // rather than hoping a fixed delay is long enough.
  final deadline = DateTime.now().add(const Duration(seconds: 10));
  while (state.accounts.length < 3 && DateTime.now().isBefore(deadline)) {
    await Future.delayed(const Duration(milliseconds: 20));
  }
  return state;
}

Future<void> _pumpApp(WidgetTester tester, AppState state) async {
  await tester.pumpWidget(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Fern.buildTheme(brightness: Brightness.light, seed: state.settings.seedColor),
      home: HomeShell(state: state),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _switchTab(WidgetTester tester, String label) async {
  await tester.tap(find.text(label));
  await tester.pumpAndSettle();
}

Future<void> _capture({
  required IntegrationTestWidgetsFlutterBinding binding,
  required WidgetTester tester,
  required String name,
}) async {
  await tester.pumpAndSettle();
  await binding.convertFlutterSurfaceToImage();
  await tester.pump();
  await binding.takeScreenshot(name);
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Generate screenshots', () {
    testWidgets('Overview', (tester) async {
      final state = await _seedState();
      await _pumpApp(tester, state);
      await _capture(binding: binding, tester: tester, name: '1_en-US');
    });

    testWidgets('AccountDetail', (tester) async {
      final state = await _seedState();
      await _pumpApp(tester, state);
      final finder = find.text('Everyday Account');
      // On short/wide viewports the "Accounts" section sits below the
      // initial build+cache extent of the outer ListView, so its widgets
      // don't exist in the tree until scrolled into view. The screen also
      // has a nested horizontal Scrollable (the account strip), so the
      // default `find.byType(Scrollable)` lookup is ambiguous — pin it to
      // the outer vertical one explicitly.
      await tester.scrollUntilVisible(
        finder,
        100,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(finder);
      await tester.pumpAndSettle();
      await _capture(binding: binding, tester: tester, name: '2_en-US');
    });

    testWidgets('Activity', (tester) async {
      final state = await _seedState();
      await _pumpApp(tester, state);
      await _switchTab(tester, 'Activity');
      await _capture(binding: binding, tester: tester, name: '3_en-US');
    });

    testWidgets('TransactionDetail', (tester) async {
      final state = await _seedState();
      await _pumpApp(tester, state);
      await _switchTab(tester, 'Activity');
      await tester.tap(find.byType(TxnTile).first);
      await tester.pumpAndSettle();
      await _capture(binding: binding, tester: tester, name: '4_en-US');
    });

    testWidgets('Stats', (tester) async {
      final state = await _seedState();
      await _pumpApp(tester, state);
      await _switchTab(tester, 'Stats');
      await _capture(binding: binding, tester: tester, name: '5_en-US');
    });

    testWidgets('Settings', (tester) async {
      final state = await _seedState();
      await _pumpApp(tester, state);
      await _switchTab(tester, 'Settings');
      await _capture(binding: binding, tester: tester, name: '6_en-US');
    });
  });
}
