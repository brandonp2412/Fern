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
  await tester.pumpWidget(MaterialApp(
    theme: Fern.buildTheme(brightness: Brightness.light, seed: Fern.green),
    home: ActivityScreen(state: state),
  ));
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
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
    );
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
  });

  testWidgets('switches between 30 and 90 day ranges', (tester) async {
    final now = DateTime.now();
    final oldTx = bpFuel(
      date: now.subtract(const Duration(days: 60)).toUtc().toIso8601String(),
    );
    final recentTx = mcdonaldsBurger(
      date: now.toUtc().toIso8601String(),
    );

    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      transactions: [oldTx, recentTx],
    );
    await _pump(tester, state);

    await tester.tap(find.text('90 days'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('BP'), findsOneWidget);
    expect(find.text("McDonald's"), findsOneWidget);

    await tester.tap(find.text('30 days'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text("McDonald's"), findsOneWidget);
    expect(find.text('BP'), findsNothing);
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
