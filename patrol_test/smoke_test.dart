import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:fern/main.dart' as app;

void main() {
  patrolTest('explore demo survives navigation and app resume', ($) async {
    app.main();
    await $.pumpAndSettle();

    expect($('Explore demo'), findsOneWidget);
    await $('Explore demo').tap();
    await $.pumpAndSettle();

    expect($('Overview'), findsWidgets);
    await $('Activity').tap();
    await $.pumpAndSettle();
    expect($('Activity'), findsWidgets);

    // Exercise Patrol's native lifecycle controls as well as Flutter UI.
    await $.platform.mobile.pressHome();
    await $.platform.android.pressDoubleRecentApps();
    await $.pumpAndSettle();
    expect($('Activity'), findsWidgets);
  });
}
