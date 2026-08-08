import 'package:fern/db/app_database.dart';
import 'package:fern/models/account.dart';
import 'package:fern/models/transaction.dart';
import 'package:fern/screens/home_shell.dart';
import 'package:fern/services/akahu_api.dart';
import 'package:fern/state/app_settings.dart';
import 'package:fern/state/app_state.dart';
import 'package:fern/theme.dart';
import 'package:fern/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:integration_test/integration_test.dart';

// HomeShell.initState() unconditionally calls state.load(), which would
// otherwise hit the real Akahu API with fake tokens. Fail instantly instead.
final _offlineClient = MockClient((request) async => throw Exception('offline (recategorize bug test)'));

List<Account> _fakeAccounts() => [
      Account(
        id: 'acc_checking',
        name: 'Everyday Account',
        type: 'CHECKING',
        attributes: const ['TRANSACTIONS'],
        formattedAccount: '12-3456-7890123-00',
        connection: AccountConnection(id: 'conn_bank', name: 'ANZ', logo: ''),
        balance: AccountBalance(current: 2431.55, available: 2431.55),
      ),
    ];

// Three categories of spend, all dated on the 1st of the *current* month at
// an early local hour. In NZ (UTC+12, no DST in winter), local 01:00/03:00/
// 05:00 on the 1st falls on the 31st in UTC. Transactions are stored as UTC
// ISO8601 strings, which is what exposes the bug: RecategorizeScreen derives
// a transaction's "day" by chopping the UTC date off that string and parsing
// it as if it were already local, instead of converting to local time first.
List<Transaction> _fakeTransactions() {
  final now = DateTime.now();
  final categories = <String>['Groceries', 'Transport', 'Entertainment'];
  final merchants = <String>['New World', 'BP Connect', 'Spotify'];

  return [
    for (var i = 0; i < categories.length; i++)
      Transaction(
        id: 'trans_$i',
        account: 'acc_checking',
        date: DateTime(now.year, now.month, 1, 1 + i * 2)
            .toUtc()
            .toIso8601String(),
        description: merchants[i],
        amount: -(20.0 + i * 5),
        type: 'DEBIT',
        merchant: TransactionMerchant(id: 'merch_$i', name: merchants[i]),
        category: TransactionCategory(
          id: 'cat_$i',
          name: categories[i],
          groups: {
            'personal_finance': CategoryGroup(
              id: 'grp_${categories[i]}',
              name: categories[i],
            ),
          },
        ),
      ),
  ];
}

Future<AppState> _seedState() async {
  final db = AppDatabase();
  await db.delete(db.transactions).go();
  await db.delete(db.accounts).go();
  await db.delete(db.categoryOverrides).go();
  await db.saveAccounts(_fakeAccounts());
  await db.saveTransactions(_fakeTransactions());

  final settings = AppSettings()..seedColor = Fern.green;
  final api = AkahuApi(userToken: 'test', appToken: 'test', client: _offlineClient);
  final state = AppState(api, settings, db: db);

  final deadline = DateTime.now().add(const Duration(seconds: 10));
  while (state.transactions.length < 3 && DateTime.now().isBefore(deadline)) {
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

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Overview spend card categories still show up in Categorize spending',
    (tester) async {
      final state = await _seedState();
      await _pumpApp(tester, state);

      // Overview: "Spending this month" shows all 3 seeded categories.
      expect(find.text('Groceries'), findsOneWidget);
      expect(find.text('Transport'), findsOneWidget);
      expect(find.text('Entertainment'), findsOneWidget);

      // Tap the cog on the "Spending this month" section header (not the
      // bottom-nav Settings tab, which uses the same icon).
      final cog = find.descendant(
        of: find.ancestor(
          of: find.text('Spending this month'),
          matching: find.byType(SectionHeader),
        ),
        matching: find.byIcon(Icons.settings_outlined),
      );
      await tester.tap(cog);
      await tester.pumpAndSettle();

      expect(find.text('Categorize spending'), findsOneWidget);
      expect(find.text('No matches'), findsNothing);
      // Each group name now appears twice per category (section header +
      // per-transaction category label), so just assert presence.
      expect(find.text('Groceries'), findsWidgets);
      expect(find.text('Transport'), findsWidgets);
      expect(find.text('Entertainment'), findsWidgets);
      expect(find.text('New World'), findsOneWidget);
      expect(find.text('BP Connect'), findsOneWidget);
      expect(find.text('Spotify'), findsOneWidget);
    },
  );
}
