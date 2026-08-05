import 'package:fern/screens/stats_screen.dart';
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
      home: StatsScreen(state: state),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
}

void main() {
  setUpAll(mockNetworkImages);

  testWidgets('shows empty state when no transactions', (tester) async {
    final state = await seededState(tester: tester, accounts: [anzEveryday()]);
    await _pump(tester, state);

    expect(find.text('Nothing to show yet'), findsOneWidget);
  });

  testWidgets('shows summary row and section headers', (tester) async {
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      transactions: sampleTransactions(),
    );
    await _pump(tester, state);

    expect(find.text('Stats'), findsOneWidget);
    expect(find.text('Avg monthly income'), findsOneWidget);
    expect(find.text('Avg monthly spending'), findsOneWidget);
    expect(find.text('Income vs spending'), findsOneWidget);
    expect(find.text('Spending trend'), findsOneWidget);
    expect(find.text('Spending by category'), findsOneWidget);
    expect(find.text('Top merchants'), findsOneWidget);
  });

  testWidgets('shows range selector options', (tester) async {
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      transactions: sampleTransactions(),
    );
    await _pump(tester, state);

    expect(find.text('6 months'), findsOneWidget);
    expect(find.text('1 year'), findsOneWidget);
    expect(find.text('All time'), findsOneWidget);
    expect(find.text('Custom'), findsOneWidget);
    expect(
      tester
          .widget<ChoiceChip>(find.widgetWithText(ChoiceChip, '6 months'))
          .selected,
      isTrue,
    );
  });

  testWidgets('shows category breakdown from sample data', (tester) async {
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      transactions: sampleTransactions(),
    );
    await _pump(tester, state);

    expect(find.text('Lifestyle'), findsOneWidget);
    expect(find.text('Transport'), findsOneWidget);
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

  testWidgets('switches to 1 year range', (tester) async {
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      transactions: sampleTransactions(),
    );
    await _pump(tester, state);

    await tester.tap(find.text('1 year'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Stats'), findsOneWidget);
  });
}
