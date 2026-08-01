import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/backup_settings_file.dart';
import '../theme.dart';

/// Persisted, app-wide user preferences. Follows the same hand-rolled
/// ChangeNotifier pattern as [AppState] rather than pulling in a state
/// management package.
class AppSettings extends ChangeNotifier {
  static const _hideBalancesKey = 'settings_hide_balances';
  static const _swipeTabsKey = 'settings_swipe_tabs';
  static const _showDebtKey = 'settings_show_debt';
  static const _themeModeKey = 'settings_theme_mode';
  static const _seedColorKey = 'settings_seed_color';
  static const _automaticBackupsKey = 'settings_automatic_backups';
  static const _backupUriKey = 'settings_backup_uri';

  bool hideBalances = false;
  bool swipeTabs = false;
  bool showDebt = true;
  ThemeMode themeMode = ThemeMode.system;
  Color seedColor = Fern.green;
  bool automaticBackups = false;
  String? backupUri;

  bool _loaded = false;
  bool get loaded => _loaded;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    hideBalances = prefs.getBool(_hideBalancesKey) ?? false;
    swipeTabs = prefs.getBool(_swipeTabsKey) ?? false;
    showDebt = prefs.getBool(_showDebtKey) ?? true;
    final modeIndex = prefs.getInt(_themeModeKey);
    if (modeIndex != null && modeIndex >= 0 && modeIndex < ThemeMode.values.length) {
      themeMode = ThemeMode.values[modeIndex];
    }
    final seedValue = prefs.getInt(_seedColorKey);
    if (seedValue != null) seedColor = Color(seedValue);
    automaticBackups = prefs.getBool(_automaticBackupsKey) ?? false;
    backupUri = prefs.getString(_backupUriKey);
    _loaded = true;
    notifyListeners();
  }

  Future<void> setHideBalances(bool value) async {
    hideBalances = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hideBalancesKey, value);
  }

  Future<void> setSwipeTabs(bool value) async {
    swipeTabs = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_swipeTabsKey, value);
  }

  Future<void> setShowDebt(bool value) async {
    showDebt = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_showDebtKey, value);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, mode.index);
  }

  Future<void> setSeedColor(Color color) async {
    seedColor = color;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_seedColorKey, color.toARGB32());
  }

  Future<void> setAutomaticBackups(bool value) async {
    automaticBackups = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_automaticBackupsKey, value);
    await writeBackupSettingsFile(
      automaticBackups: automaticBackups,
      backupUri: backupUri,
    );
  }

  Future<void> setBackupUri(String? uri) async {
    backupUri = uri;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    if (uri == null) {
      await prefs.remove(_backupUriKey);
    } else {
      await prefs.setString(_backupUriKey, uri);
    }
    await writeBackupSettingsFile(
      automaticBackups: automaticBackups,
      backupUri: backupUri,
    );
  }
}
