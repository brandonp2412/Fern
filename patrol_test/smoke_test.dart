import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:fern/main.dart' as app;

void main() {
  patrolTest('explore demo survives navigation and app resume', ($) async {
    app.main();
    await $.pumpAndSettle();

    final exploreDemo = await $('Explore demo').waitUntilVisible(
      timeout: const Duration(seconds: 15),
    );
    expect(exploreDemo, findsOneWidget);
    await exploreDemo.tap();
    await $.pumpAndSettle();

    await $('Overview').waitUntilVisible(timeout: const Duration(seconds: 15));
    expect($('Overview'), findsWidgets);
    await $('Activity').tap();
    await $.pumpAndSettle();
    await $('Activity').waitUntilVisible(timeout: const Duration(seconds: 15));
    expect($('Activity'), findsWidgets);

    // Exercise Patrol's native lifecycle controls as well as Flutter UI.
    await $.platform.mobile.pressHome();
    await $.platform.android.pressDoubleRecentApps();
    await $.pumpAndSettle();
    expect($('Activity'), findsWidgets);
  });
}
