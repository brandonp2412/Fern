import 'package:fern/screens/account_screen.dart';
import 'package:fern/screens/overview_screen.dart';
import 'package:fern/screens/categorize_spending_screen.dart';
import 'package:fern/state/app_state.dart';
import 'package:fern/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fixtures.dart';

Future<void> _pump(WidgetTester tester, AppState state) async {
  tester.view.physicalSize = const Size(800, 2000);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(() {
    tester.view.physicalSize = const Size(800, 600);
    tester.view.devicePixelRatio = 1.0;
  });
  await tester.pumpWidget(
    MaterialApp(
      theme: Fern.buildTheme(brightness: Brightness.light, seed: Fern.green),
      home: OverviewScreen(state: state),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
}

void main() {
  setUpAll(mockNetworkImages);

  testWidgets(
    'shows the real net position, account names and a recent McDonald\'s tile',
    (tester) async {
      final state = await seededState(
        tester: tester,
        accounts: [
          anzEveryday(balance: 2450.32),
          asbStreamline(balance: 8120.11),
        ],
        transactions: [mcdonaldsBurger()],
      );
      await _pump(tester, state);

      expect(find.text('ANZ Everyday'), findsOneWidget);
      expect(find.text('ASB Streamline'), findsOneWidget);
      expect(find.text("McDonald's"), findsOneWidget);
      expect(find.text('2 accounts'), findsOneWidget);
    },
  );

  testWidgets(
    'tapping the ASB Streamline account card opens its AccountDetailScreen',
    (tester) async {
      final state = await seededState(
        tester: tester,
        accounts: [anzEveryday(), asbStreamline()],
        transactions: [netflixSubscription()],
      );
      await _pump(tester, state);

      await tester.tap(find.text('ASB Streamline'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(AccountScreen), findsOneWidget);
      expect(find.widgetWithText(AppBar, 'ASB Streamline'), findsOneWidget);
    },
  );

  testWidgets(
    'tapping the settings icon on "Spending this month" opens RecategorizeScreen',
    (tester) async {
      final state = await seededState(
        tester: tester,
        accounts: [anzEveryday()],
        transactions: [mcdonaldsBurger()],
      );
      await _pump(tester, state);

      expect(find.text('Spending this month'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.settings_outlined));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(CategorizeSpendingScreen), findsOneWidget);
    },
  );

  testWidgets(
    'a transaction just after local midnight on the 1st still counts as spending this month',
    (tester) async {
      final now = DateTime.now();
      final localFirstOfMonth = DateTime(now.year, now.month, 1, 0, 30);
      final state = await seededState(
        tester: tester,
        accounts: [anzEveryday()],
        transactions: [
          mcdonaldsBurger(date: localFirstOfMonth.toUtc().toIso8601String()),
        ],
      );
      await _pump(tester, state);

      expect(find.text('No spending this month'), findsNothing);
      expect(find.text('Lifestyle'), findsOneWidget);
    },
  );

  testWidgets('the spend card breaks down real category groups', (
    tester,
  ) async {
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      transactions: [
        mcdonaldsBurger(date: DateTime.now().toUtc().toIso8601String()),
        bpFuel(date: DateTime.now().toUtc().toIso8601String()),
      ],
    );
    await _pump(tester, state);

    expect(find.text('Lifestyle'), findsOneWidget);
    expect(find.text('Transport'), findsOneWidget);
  });

  testWidgets('hiding balances masks the net position figure', (tester) async {
    final settings = await testSettings();
    await settings.setHideBalances(true);
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday(balance: 2450.32)],
      settings: settings,
    );
    await _pump(tester, state);

    expect(find.text('••••'), findsWidgets);
    expect(find.textContaining('\$2,450'), findsNothing);
  });
}
