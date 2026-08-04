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
      home: CategorizeSpendingScreen(state: state),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
}

void main() {
  setUpAll(mockNetworkImages);

  testWidgets('shows transactions grouped by category', (tester) async {
    final now = DateTime.now().toUtc().toIso8601String();
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      transactions: [
        mcdonaldsBurger(date: now),
        uberTrip(date: now),
        bpFuel(date: now),
      ],
    );
    await _pump(tester, state);

    expect(find.text('Lifestyle'), findsOneWidget);
    expect(find.text('Transport'), findsOneWidget);
    expect(find.text("McDonald's"), findsOneWidget);
    expect(find.text('Uber'), findsOneWidget);
    expect(find.text('BP'), findsOneWidget);
  });

  testWidgets('shows empty state when no spending transactions', (
    tester,
  ) async {
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      transactions: [payday()],
    );
    await _pump(tester, state);

    expect(find.text('Nothing to categorize'), findsOneWidget);
  });

  testWidgets('filters transactions by search query', (tester) async {
    final now = DateTime.now().toUtc().toIso8601String();
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      transactions: [
        mcdonaldsBurger(date: now),
        uberTrip(date: now),
        bpFuel(date: now),
      ],
    );
    await _pump(tester, state);

    await tester.enterText(find.byType(TextField).first, 'uber');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Uber'), findsOneWidget);
    expect(find.text("McDonald's"), findsNothing);
    expect(find.text('BP'), findsNothing);
  });

  testWidgets('shows no matches for empty search', (tester) async {
    final now = DateTime.now().toUtc().toIso8601String();
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      transactions: [mcdonaldsBurger(date: now)],
    );
    await _pump(tester, state);

    await tester.enterText(find.byType(TextField).first, 'zzznotfound');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('No matches'), findsOneWidget);
  });

  testWidgets('excludes income transactions', (tester) async {
    final now = DateTime.now().toUtc().toIso8601String();
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      transactions: [
        payday(date: now),
        mcdonaldsBurger(date: now),
      ],
    );
    await _pump(tester, state);

    expect(find.text("McDonald's"), findsOneWidget);
    expect(find.textContaining('\$3,200'), findsNothing);
  });
}
