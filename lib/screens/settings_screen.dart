import 'package:flutter/material.dart';
import '../state/app_settings.dart';
import '../theme.dart';
import '../widgets/common.dart';

class SettingsScreen extends StatelessWidget {
  final AppSettings settings;

  const SettingsScreen({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settings,
      builder: (context, _) {
        final fern = context.fern;
        return Scaffold(
          appBar: AppBar(title: const Text('Settings')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const SectionHeader('Privacy'),
              Card(
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text('Hide account balances',
                          style: TextStyle(
                              fontSize: 14.5, fontWeight: FontWeight.w600)),
                      subtitle: Text('Mask totals and balances on screen',
                          style: TextStyle(fontSize: 12, color: fern.slate)),
                      value: settings.hideBalances,
                      onChanged: settings.setHideBalances,
                    ),
                    const Divider(height: 1),
                    SwitchListTile(
                      title: const Text('Show debt accounts',
                          style: TextStyle(
                              fontSize: 14.5, fontWeight: FontWeight.w600)),
                      subtitle: Text(
                          'Include credit cards & loans in totals and lists',
                          style: TextStyle(fontSize: 12, color: fern.slate)),
                      value: settings.showDebt,
                      onChanged: settings.setShowDebt,
                    ),
                  ],
                ),
              ),
              const SectionHeader('Navigation'),
              Card(
                child: SwitchListTile(
                  title: const Text('Swipe between tabs',
                      style: TextStyle(
                          fontSize: 14.5, fontWeight: FontWeight.w600)),
                  subtitle: Text(
                      'Swipe left/right to switch tabs, not just tap',
                      style: TextStyle(fontSize: 12, color: fern.slate)),
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
                          selected: settings.seedColor.toARGB32() ==
                              seed.color.toARGB32(),
                          onTap: () => settings.setSeedColor(seed.color),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
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
