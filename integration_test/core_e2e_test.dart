import 'package:drift/native.dart';
import 'package:fern/db/app_database.dart';
import 'package:fern/screens/home_shell.dart';
import 'package:fern/services/demo_akahu_api.dart';
import 'package:fern/state/app_settings.dart';
import 'package:fern/state/app_state.dart';
import 'package:fern/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<AppState> _pumpDemoApp(WidgetTester tester) async {
  SharedPreferences.setMockInitialValues({});
  final settings = AppSettings();
  await settings.load();
  final db = AppDatabase.forTesting(NativeDatabase.memory());
  final state = AppState(DemoAkahuApi(), settings, db: db);
  addTearDown(state.dispose);

  await tester.pumpWidget(
    ListenableBuilder(
      listenable: settings,
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: settings.themeMode,
        theme: Fern.buildTheme(
          brightness: Brightness.light,
          seed: settings.seedColor,
        ),
        darkTheme: Fern.buildTheme(
          brightness: Brightness.dark,
          seed: settings.seedColor,
        ),
        home: HomeShell(state: state),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return state;
}

Future<void> _tab(WidgetTester tester, String label) async {
  await tester.tap(find.text(label).last);
  await tester.pumpAndSettle();
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Core demo journey covers core money-management workflows', (
    tester,
  ) async {
    final state = await _pumpDemoApp(tester);

    expect(find.text('Net position'), findsOneWidget);
    expect(find.text('Everyday'), findsOneWidget);
    expect(find.text('Rainy Day Savings'), findsOneWidget);
    expect(find.text('Rewards Card'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Recent activity'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Recent activity'), findsOneWidget);
    expect(state.accounts, hasLength(3));
    expect(state.transactions, isNotEmpty);

    await tester.scrollUntilVisible(
      find.text('Everyday'),
      -200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Everyday'));
    await tester.pumpAndSettle();
    expect(find.text('Transactions'), findsOneWidget);
    expect(find.text('Fresh Market'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('End of history'),
      250,
      scrollable: find.byType(Scrollable).last,
    );
    expect(find.text('End of history'), findsOneWidget);

    await tester.tap(find.text('Fresh Market'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Report an issue'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    expect(find.text('Transaction ID'), findsOneWidget);
    expect(find.text('Report an issue'), findsOneWidget);
    await tester.tap(find.text('Report an issue'));
    await tester.pumpAndSettle();
    expect(find.text('Issue type'), findsOneWidget);
    expect(find.text('Duplicate transaction ID'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull, reason: 'transaction report dialog');
    await tester.tapAt(const Offset(16, 16));
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();

    await _tab(tester, 'Activity');
    expect(find.text('Activity'), findsWidgets);
    final search = find.byType(TextField).first;
    await tester.enterText(search, 'Fresh Market');
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Fresh Market'), findsWidgets);
    expect(find.text('Harbour Cafe'), findsNothing);

    await tester.enterText(search, '');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.tap(find.text('Money in'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Income ·'), findsOneWidget);
    expect(find.text('Fern Demo Ltd'), findsOneWidget);

    await tester.tap(find.text('Money out'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Spending ·'), findsOneWidget);
    expect(find.text('Fern Demo Ltd'), findsNothing);

    await tester.tap(find.text('Categories'));
    await tester.pumpAndSettle();
    expect(find.text('Select all'), findsOneWidget);
    expect(find.text('Food and drink'), findsOneWidget);
    await tester.tap(find.text('Food and drink'));
    await tester.tap(find.text('Apply'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull, reason: 'activity category sheet');
    expect(find.text('Categories (1)'), findsOneWidget);

    await tester.tap(find.text('Newest'));
    await tester.pumpAndSettle();
    expect(find.text('Order by'), findsOneWidget);
    await tester.tap(find.text('Highest'));
    await tester.tap(find.text('Apply'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull, reason: 'activity sort sheet');
    expect(find.text('Highest'), findsOneWidget);

    await _tab(tester, 'Stats');
    expect(find.text('Income vs spending'), findsOneWidget);
    await tester.tap(find.text('1 year'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('All time'));
    await tester.pumpAndSettle();
    expect(find.text('All time'), findsOneWidget);
    await tester.tap(find.text('Categories'));
    await tester.pumpAndSettle();
    expect(find.text('Select all'), findsOneWidget);
    await tester.tapAt(const Offset(16, 16));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull, reason: 'stats category sheet');

    await _tab(tester, 'Settings');
    expect(find.text('Hide account balances'), findsOneWidget);
    expect(find.text('Show debt accounts'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Export data'),
      250,
      scrollable: find.byType(Scrollable).last,
    );
    expect(find.text('Export data'), findsOneWidget);
    expect(find.text('Import data'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Hide account balances'),
      -250,
      scrollable: find.byType(Scrollable).last,
    );

    await tester.tap(find.text('Hide account balances'));
    await tester.pumpAndSettle();
    expect(state.settings.hideBalances, isTrue);
    await _tab(tester, 'Overview');
    await tester.scrollUntilVisible(
      find.text('Net position'),
      -250,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('••••'), findsWidgets);

    await _tab(tester, 'Settings');
    await tester.tap(find.text('Show debt accounts'));
    await tester.pumpAndSettle();
    expect(state.settings.showDebt, isFalse);
    await _tab(tester, 'Overview');
    await tester.scrollUntilVisible(
      find.text('Net position'),
      -250,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.textContaining('2 accounts'), findsOneWidget);
    expect(find.text('Rewards Card'), findsNothing);
    expect(tester.takeException(), isNull, reason: 'settings privacy toggles');

    final spendingHeader = find.text('Spending this month');
    await tester.scrollUntilVisible(
      spendingHeader,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.byTooltip('Categorize spending'));
    await tester.pumpAndSettle();
    expect(find.text('Categorize spending'), findsOneWidget);
    final categorizeSearch = find.byType(TextField).first;
    await tester.enterText(categorizeSearch, 'Fresh Market');
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Fresh Market'), findsWidgets);
    expect(find.text('Harbour Cafe'), findsNothing);
    await tester.pageBack();
    await tester.pumpAndSettle();

    await _tab(tester, 'Settings');
    final settingsScroll = find.byType(Scrollable).last;
    await tester.scrollUntilVisible(
      find.text('Dark'),
      250,
      scrollable: settingsScroll,
    );
    await tester.drag(settingsScroll, const Offset(0, -180));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Dark'));
    await tester.pumpAndSettle();
    expect(state.settings.themeMode, ThemeMode.dark);
    expect(tester.takeException(), isNull, reason: 'dark theme radio');

    await tester.scrollUntilVisible(
      find.text('Ocean blue'),
      250,
      scrollable: settingsScroll,
    );
    await tester.tap(find.text('Ocean blue'));
    await tester.pumpAndSettle();
    expect(
      state.settings.seedColor.toARGB32(),
      FernSeed.ocean.color.toARGB32(),
    );
    expect(tester.takeException(), isNull, reason: 'palette swatches');

    await tester.scrollUntilVisible(
      find.text('Swipe between tabs'),
      -250,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.text('Swipe between tabs'));
    await tester.pumpAndSettle();
    expect(state.settings.swipeTabs, isTrue);
    await _tab(tester, 'Overview');
    await tester.fling(find.byType(PageView), const Offset(-500, 0), 1000);
    await tester.pumpAndSettle();
    expect(find.text('Activity'), findsWidgets);
    expect(tester.takeException(), isNull, reason: 'swipe navigation');
  });
}
