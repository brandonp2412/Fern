import 'dart:convert';

import 'package:fern/models/user.dart';
import 'package:fern/screens/settings_screen.dart';
import 'package:fern/services/akahu_api.dart';
import 'package:fern/state/app_state.dart';
import 'package:fern/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

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
      home: SettingsScreen(state: state),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
}

void main() {
  setUpAll(() {
    mockNetworkImages();
    mockSecureStorage();
  });

  testWidgets('shows user email when available', (tester) async {
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      api: _userApi(),
      db: testDb(),
    );
    state.user = User(id: 'user_1', email: 'test@example.com');

    await _pump(tester, state);

    expect(find.text('test@example.com'), findsOneWidget);
  });

  testWidgets('shows privacy toggles', (tester) async {
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      api: _userApi(),
      db: testDb(),
    );

    await _pump(tester, state);

    expect(find.text('Hide account balances'), findsOneWidget);
    expect(find.text('Show debt accounts'), findsOneWidget);
  });

  testWidgets('shows source code and donate links', (tester) async {
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      api: _userApi(),
      db: testDb(),
    );

    await _pump(tester, state);

    expect(find.text('About'), findsOneWidget);
    expect(find.text('Source code'), findsOneWidget);
    expect(find.text('Donate'), findsOneWidget);
  });

  testWidgets('shows navigation toggle', (tester) async {
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      api: _userApi(),
      db: testDb(),
    );

    await _pump(tester, state);

    expect(find.text('Swipe between tabs'), findsOneWidget);
  });

  testWidgets('shows theme mode options', (tester) async {
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      api: _userApi(),
      db: testDb(),
    );

    await _pump(tester, state);

    expect(find.text('Light'), findsOneWidget);
    expect(find.text('Dark'), findsOneWidget);
    expect(find.text('System'), findsOneWidget);
  });

  testWidgets('shows color palette section', (tester) async {
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      api: _userApi(),
      db: testDb(),
    );

    await _pump(tester, state);

    expect(find.text('Color palette'), findsOneWidget);
    expect(find.text('Fern green'), findsOneWidget);
  });

  testWidgets('disconnect dialog appears and cancels', (tester) async {
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      api: _userApi(),
      db: testDb(),
    );

    await _pump(tester, state);

    await tester.scrollUntilVisible(find.text('Disconnect'), 200);
    await tester.tap(find.text('Disconnect'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Disconnect?'), findsOneWidget);
    expect(find.text('Keep connected'), findsOneWidget);

    await tester.tap(find.text('Keep connected'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Disconnect?'), findsNothing);
  });
}

AkahuApi _userApi() {
  final user = User(id: 'user_1', email: 'test@example.com');

  return AkahuApi(
    userToken: 'test',
    appToken: 'test',
    client: MockClient((req) async {
      if (req.url.path == '/v1/me') {
        return http.Response(
          jsonEncode({
            'success': true,
            'item': {'_id': user.id, 'email': user.email},
          }),
          200,
        );
      }
      if (req.url.path == '/v1/accounts') {
        return http.Response(jsonEncode({'success': true, 'items': []}), 200);
      }
      return http.Response('{"success":false}', 404);
    }),
  );
}
