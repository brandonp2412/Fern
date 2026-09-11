import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:fern/main.dart' as app;

const _uiTimeout = Duration(seconds: 15);

void main() {
  patrolTest('explore demo survives navigation and app resume', ($) async {
    app.main();

    await $('Explore demo').waitUntilVisible(timeout: _uiTimeout).tap();
    await $('Overview').waitUntilVisible(timeout: _uiTimeout);
    await $('Activity').waitUntilVisible(timeout: _uiTimeout).tap();
    await $('Activity').waitUntilVisible(timeout: _uiTimeout);

    await $.platform.mobile.pressHome();
    await $.platform.android.pressDoubleRecentApps();
    await $('Activity').waitUntilVisible(timeout: _uiTimeout);
    expect($('Activity'), findsWidgets);
  });
}
