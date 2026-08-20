import 'package:fern/screens/activity_screen.dart';
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
      home: ActivityScreen(state: state),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
}

void main() {
  setUpAll(mockNetworkImages);

  testWidgets('shows transactions grouped by date', (tester) async {
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      transactions: [mcdonaldsBurger(), uberTrip(), bpFuel()],
    );
    await _pump(tester, state);

    expect(find.text("McDonald's"), findsOneWidget);
    expect(find.text('Uber'), findsOneWidget);
    expect(find.text('BP'), findsOneWidget);
  });

  testWidgets('shows empty state when no transactions', (tester) async {
    final state = await seededState(tester: tester, accounts: [anzEveryday()]);
    await _pump(tester, state);

    expect(find.text('No transactions'), findsOneWidget);
  });

  testWidgets('filters by Money in direction', (tester) async {
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      transactions: [payday(), mcdonaldsBurger()],
    );
    await _pump(tester, state);

    await tester.tap(find.text('Money in'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.textContaining('+'), findsWidgets);
    expect(find.text("McDonald's"), findsNothing);
    expect(find.text('Income · 1 transaction'), findsOneWidget);
    expect(find.text(r'+$3,200.00'), findsWidgets);
  });

  testWidgets('filters by Money out direction', (tester) async {
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      transactions: [payday(), mcdonaldsBurger()],
    );
    await _pump(tester, state);

    await tester.tap(find.text('Money out'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text("McDonald's"), findsOneWidget);
    expect(find.textContaining('\$3,200'), findsNothing);
    expect(find.text('Spending · 1 transaction'), findsOneWidget);
    expect(find.text('\$14.90'), findsOneWidget);
  });

  testWidgets('shows a net total for all filtered transactions', (
    tester,
  ) async {
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      transactions: [payday(), mcdonaldsBurger()],
    );
    await _pump(tester, state);

    expect(find.text('Net total · 2 transactions'), findsOneWidget);
    expect(find.text(r'+$3,185.10'), findsOneWidget);
  });

  testWidgets('does not limit activity to a preset date range', (tester) async {
    final now = DateTime.now();
    final oldTx = bpFuel(
      date: DateTime(
        now.year - 2,
        now.month,
        now.day,
      ).toUtc().toIso8601String(),
    );

    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      transactions: [oldTx],
    );
    await _pump(tester, state);

    expect(find.text('BP'), findsOneWidget);
    expect(find.text('6 months'), findsNothing);
    expect(find.text('1 year'), findsNothing);
  });

  testWidgets('masks amounts when hideBalances is on', (tester) async {
    final settings = await testSettings();
    await settings.setHideBalances(true);
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      transactions: [mcdonaldsBurger()],
      settings: settings,
    );
    await _pump(tester, state);

    expect(find.text('••••'), findsWidgets);
    expect(find.textContaining('\$14.90'), findsNothing);
  });
}
