import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../data/export_data.dart';
import '../data/import_data.dart';
import '../main.dart';
import '../services/android_channel.dart';
import '../services/secure_store.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../utils/format.dart';
import '../widgets/common.dart';
import 'category_rules_screen.dart';
import 'home_shell.dart';

class SettingsScreen extends StatefulWidget {
  final AppState state;

  const SettingsScreen({super.key, required this.state});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> _disconnect() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Disconnect?'),
        content: const Text(
          'This revokes your Akahu access token and signs you out of Fern.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Keep connected'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: context.fern.clay,
              minimumSize: const Size(110, 44),
            ),
            child: const Text('Disconnect'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    try {
      await widget.state.api.revokeToken();
    } catch (_) {}
    await SecureStore.clear();
    await widget.state.db.clearAll();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (routeContext) => SetupScreen(
          settings: widget.state.settings,
          onConnected: (newState) => Navigator.of(routeContext).pushReplacement(
            MaterialPageRoute(builder: (_) => HomeShell(state: newState)),
          ),
        ),
      ),
      (_) => false,
    );
  }

  Future<void> _toggleAutomaticBackups(bool value) async {
    final settings = widget.state.settings;
    if (!value) {
      await settings.setAutomaticBackups(false);
      return;
    }
    await Permission.notification.request();
    final dbFolder = await getApplicationDocumentsDirectory();
    final dbPath = p.join(dbFolder.path, 'fern_cache.sqlite');
    await settings.setAutomaticBackups(true);
    await androidChannel.invokeMethod('pick', {'dbPath': dbPath});
  }

  @override
  Widget build(BuildContext context) {
    final fern = context.fern;
    final state = widget.state;
    final user = state.user;
    final settings = state.settings;
    return AnimatedBuilder(
      animation: settings,
      builder: (context, _) => Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [fern.green, fern.moss],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        color: fern.onGreen,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.email ?? 'Akahu user',
                            style: const TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            [
                              if (user?.id != null) user!.id,
                              if (user?.accessGrantedAt != null)
                                'connected ${relativeDate(user!.accessGrantedAt)}',
                            ].join(' · '),
                            style: TextStyle(fontSize: 12, color: fern.slate),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SectionHeader('Privacy'),
            Card(
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text(
                      'Hide account balances',
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      'Mask totals and balances on screen',
                      style: TextStyle(fontSize: 12, color: fern.slate),
                    ),
                    value: settings.hideBalances,
                    onChanged: settings.setHideBalances,
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: const Text(
                      'Show debt accounts',
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      'Include credit cards & loans in totals and lists',
                      style: TextStyle(fontSize: 12, color: fern.slate),
                    ),
                    value: settings.showDebt,
                    onChanged: settings.setShowDebt,
                  ),
                ],
              ),
            ),
            const SectionHeader('Data'),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Expanded(child: ExportData(state: state)),
                    Expanded(child: ImportData(state: state)),
                  ],
                ),
              ),
            ),
            if (!kIsWeb && Platform.isAndroid)
              Card(
                child: SwitchListTile(
                  title: const Text(
                    'Automatic backups',
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    'Back up your database daily to a folder you choose',
                    style: TextStyle(fontSize: 12, color: fern.slate),
                  ),
                  value: settings.automaticBackups,
                  onChanged: _toggleAutomaticBackups,
                ),
              ),
            const SectionHeader('Categorization'),
            Card(
              child: ListTile(
                title: const Text(
                  'Auto-categorize rules',
                  style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'Manage rules that auto-categorize future transactions',
                  style: TextStyle(fontSize: 12, color: fern.slate),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CategoryRulesScreen(state: state),
                  ),
                ),
              ),
            ),
            const SectionHeader('Navigation'),
            Card(
              child: SwitchListTile(
                title: const Text(
                  'Swipe between tabs',
                  style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'Swipe left/right to switch tabs, not just tap',
                  style: TextStyle(fontSize: 12, color: fern.slate),
                ),
                value: settings.swipeTabs,
                onChanged: settings.setSwipeTabs,
              ),
            ),
            const SectionHeader('Appearance'),
            Card(
              child: Column(
                children: [
                  RadioListTile<ThemeMode>(
                    title: const Text('Light'),
                    value: ThemeMode.light,
                    groupValue: settings.themeMode,
                    onChanged: (v) => settings.setThemeMode(v!),
                  ),
                  RadioListTile<ThemeMode>(
                    title: const Text('Dark'),
                    value: ThemeMode.dark,
                    groupValue: settings.themeMode,
                    onChanged: (v) => settings.setThemeMode(v!),
                  ),
                  RadioListTile<ThemeMode>(
                    title: const Text('System'),
                    value: ThemeMode.system,
                    groupValue: settings.themeMode,
                    onChanged: (v) => settings.setThemeMode(v!),
                  ),
                ],
              ),
            ),
            const SectionHeader('Color palette'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  children: [
                    for (final seed in FernSeed.values)
                      _SeedSwatch(
                        seed: seed,
                        selected:
                            settings.seedColor.toARGB32() ==
                            seed.color.toARGB32(),
                        onTap: () => settings.setSeedColor(seed.color),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: _disconnect,
              icon: Icon(Icons.logout, size: 18, color: fern.clay),
              label: Text(
                'Disconnect & revoke access',
                style: TextStyle(color: fern.clay),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: fern.clay),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _SeedSwatch extends StatelessWidget {
  final FernSeed seed;
  final bool selected;
  final VoidCallback onTap;

  const _SeedSwatch({
    required this.seed,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fern = context.fern;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: seed.color,
              shape: BoxShape.circle,
              border: selected
                  ? Border.all(color: fern.ink, width: 2.5)
                  : Border.all(color: Colors.transparent, width: 2.5),
            ),
            child: selected
                ? const Icon(Icons.check, color: Colors.white, size: 20)
                : null,
          ),
          const SizedBox(height: 6),
          Text(seed.label, style: TextStyle(fontSize: 11, color: fern.slate)),
        ],
      ),
    );
  }
}
