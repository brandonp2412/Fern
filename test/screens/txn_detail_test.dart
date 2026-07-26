import 'package:fern/screens/overview_screen.dart';
import 'package:fern/screens/txn_detail.dart';
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
    home: OverviewScreen(state: state),
  ));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
}

void main() {
  setUpAll(mockNetworkImages);

  testWidgets('tapping a transaction tile opens the detail sheet', (tester) async {
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      transactions: [mcdonaldsBurger()],
    );
    await _pump(tester, state);

    await tester.tap(find.text("McDonald's"));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byType(TxnDetailSheet), findsOneWidget);
  });

  testWidgets('shows transaction amount and date', (tester) async {
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      transactions: [mcdonaldsBurger()],
    );
    await _pump(tester, state);

    await tester.tap(find.text("McDonald's"));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byType(TxnDetailSheet), findsOneWidget);
    expect(find.text("McDonald's"), findsWidgets);
  });

  testWidgets('shows merchant and statement description', (tester) async {
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      transactions: [mcdonaldsBurger()],
    );
    await _pump(tester, state);

    await tester.tap(find.text("McDonald's"));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Merchant'), findsOneWidget);
    expect(find.text('Statement description'), findsOneWidget);
    expect(find.text('Transaction ID'), findsOneWidget);
  });

  testWidgets('shows report an issue button', (tester) async {
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      transactions: [mcdonaldsBurger()],
    );
    await _pump(tester, state);

    await tester.tap(find.text("McDonald's"));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Report an issue'), findsOneWidget);
  });

  testWidgets('tapping report opens the report dialog', (tester) async {
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      transactions: [mcdonaldsBurger()],
    );
    await _pump(tester, state);

    await tester.tap(find.text("McDonald's"));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    await tester.tap(find.text('Report an issue'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Report an issue'), findsNWidgets(2));
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('Send'), findsOneWidget);
    expect(find.text('Issue type'), findsOneWidget);
  });

  testWidgets('cancel button closes the report dialog', (tester) async {
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      transactions: [mcdonaldsBurger()],
    );
    await _pump(tester, state);

    await tester.tap(find.text("McDonald's"));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    await tester.tap(find.text('Report an issue'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    await tester.tap(find.text('Cancel'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Cancel'), findsNothing);
  });
}
