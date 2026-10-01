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

Future<AppState> pumpDemo(WidgetTester tester, Size size) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetPhysicalSize);

  SharedPreferences.setMockInitialValues({});
  final settings = AppSettings();
  await settings.load();
  final state = AppState(
    DemoAkahuApi(),
    settings,
    db: AppDatabase.forTesting(NativeDatabase.memory()),
  );
  addTearDown(state.dispose);

  await tester.pumpWidget(
    MaterialApp(
      theme: Fern.buildTheme(
        brightness: Brightness.light,
        seed: settings.seedColor,
      ),
      home: HomeShell(state: state, onDisconnected: () async {}),
    ),
  );
  await tester.pumpAndSettle();
  return state;
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  for (final size in const [
    Size(320, 568),
    Size(360, 640),
    Size(412, 915),
    Size(600, 960),
    Size(1024, 600),
  ]) {
    testWidgets('demo survives navigation at $size', (tester) async {
      await pumpDemo(tester, size);
      expect(tester.takeException(), isNull);

      for (final tab in ['Activity', 'Stats', 'Settings', 'Overview']) {
        final finder = find.text(tab);
        expect(finder, findsWidgets);
        await tester.tap(finder.last);
        await tester.pumpAndSettle();
        final error = tester.takeException();
        expect(error, isNull, reason: '$tab at $size');
      }
    });
  }
}
