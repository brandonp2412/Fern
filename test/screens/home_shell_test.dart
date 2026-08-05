import 'package:fern/screens/home_shell.dart';
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
      home: HomeShell(state: state),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
}

void main() {
  setUpAll(mockNetworkImages);

  testWidgets('renders the overview screen by default', (tester) async {
    final state = await seededState(tester: tester, accounts: [anzEveryday()]);
    await _pump(tester, state);

    expect(find.text('Fern'), findsOneWidget);
  });

  testWidgets('navigation bar has four destinations', (tester) async {
    final state = await seededState(tester: tester, accounts: [anzEveryday()]);
    await _pump(tester, state);

    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Activity'), findsOneWidget);
    expect(find.text('Stats'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });

  testWidgets('switches to Activity tab', (tester) async {
    final state = await seededState(tester: tester, accounts: [anzEveryday()]);
    await _pump(tester, state);

    await tester.tap(find.text('Activity'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('No transactions'), findsOneWidget);
  });

  testWidgets('switches to Stats tab', (tester) async {
    final state = await seededState(tester: tester, accounts: [anzEveryday()]);
    await _pump(tester, state);

    await tester.tap(find.text('Stats'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Nothing to show yet'), findsOneWidget);
  });

  testWidgets('switches to Settings tab', (tester) async {
    final state = await seededState(tester: tester, accounts: [anzEveryday()]);
    await _pump(tester, state);

    await tester.tap(find.text('Settings'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Disconnect & revoke access'), findsOneWidget);
  });

  testWidgets('swipe tabs works when enabled', (tester) async {
    final settings = await testSettings();
    await settings.setSwipeTabs(true);
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      settings: settings,
    );
    await _pump(tester, state);

    expect(find.byType(PageView), findsOneWidget);
  });
}
