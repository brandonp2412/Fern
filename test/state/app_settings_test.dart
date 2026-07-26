import 'package:fern/state/app_settings.dart';
import 'package:fern/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('load defaults', () {
    test('defaults hideBalances/swipeTabs off, showDebt on, Fern green seed', () async {
      final settings = AppSettings();
      expect(settings.loaded, isFalse);
      await settings.load();

      expect(settings.loaded, isTrue);
      expect(settings.hideBalances, isFalse);
      expect(settings.swipeTabs, isFalse);
      expect(settings.showDebt, isTrue);
      expect(settings.themeMode, ThemeMode.system);
      expect(settings.seedColor, Fern.green);
    });
  });

  group('setHideBalances', () {
    test('flips the "Hide account balances" preference and persists it', () async {
      final settings = AppSettings();
      await settings.load();

      var notified = false;
      settings.addListener(() => notified = true);
      await settings.setHideBalances(true);

      expect(settings.hideBalances, isTrue);
      expect(notified, isTrue);

      final reloaded = AppSettings();
      await reloaded.load();
      expect(reloaded.hideBalances, isTrue);
    });
  });

  group('setSwipeTabs', () {
    test('flips the "Swipe between tabs" preference and persists it', () async {
      final settings = AppSettings();
      await settings.load();
      await settings.setSwipeTabs(true);

      expect(settings.swipeTabs, isTrue);

      final reloaded = AppSettings();
      await reloaded.load();
      expect(reloaded.swipeTabs, isTrue);
    });
  });

  group('setShowDebt', () {
    test('flips the "Show debt accounts" preference and persists it', () async {
      final settings = AppSettings();
      await settings.load();
      await settings.setShowDebt(false);

      expect(settings.showDebt, isFalse);

      final reloaded = AppSettings();
      await reloaded.load();
      expect(reloaded.showDebt, isFalse);
    });
  });

  group('setThemeMode', () {
    test('switches to dark mode and persists it', () async {
      final settings = AppSettings();
      await settings.load();
      await settings.setThemeMode(ThemeMode.dark);

      expect(settings.themeMode, ThemeMode.dark);

      final reloaded = AppSettings();
      await reloaded.load();
      expect(reloaded.themeMode, ThemeMode.dark);
    });
  });

  group('setSeedColor', () {
    test('switches to the "Moss" seed color and persists it', () async {
      final settings = AppSettings();
      await settings.load();
      await settings.setSeedColor(FernSeed.moss.color);

      expect(settings.seedColor, Fern.moss);
      expect(FernSeed.fromColor(settings.seedColor), FernSeed.moss);

      final reloaded = AppSettings();
      await reloaded.load();
      expect(reloaded.seedColor, Fern.moss);
    });
  });
}
