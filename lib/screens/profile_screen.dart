import 'package:flutter/material.dart';
import '../main.dart';
import '../services/secure_store.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../utils/format.dart';
import '../widgets/common.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  final AppState state;

  const ProfileScreen({super.key, required this.state});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _disconnect() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Disconnect?'),
        content: const Text(
            'This revokes your Akahu access token and signs you out of Fern.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Keep connected'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
                backgroundColor: context.fern.clay,
                minimumSize: const Size(110, 44)),
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
      MaterialPageRoute(builder: (_) => SetupScreen(settings: widget.state.settings)),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final fern = context.fern;
    final state = widget.state;
    final user = state.user;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
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
                          colors: [fern.green, fern.moss]),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person,
                        color: Colors.white, size: 26),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.email ?? 'Akahu user',
                          style: const TextStyle(
                              fontSize: 15.5, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          [
                            if (user?.id != null) user!.id,
                            if (user?.accessGrantedAt != null)
                              'connected ${relativeDate(user!.accessGrantedAt)}',
                          ].join(' · '),
                          style: TextStyle(
                              fontSize: 12, color: fern.slate),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SectionHeader('Tools'),
          Card(
            child: Column(
              children: [
                _menuTile(
                  Icons.settings_outlined,
                  'Settings',
                  'Appearance, privacy & tab behaviour',
                  () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => SettingsScreen(settings: state.settings))),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: _disconnect,
            icon: Icon(Icons.logout, size: 18, color: fern.clay),
            label: Text('Disconnect & revoke access',
                style: TextStyle(color: fern.clay)),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: fern.clay),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _menuTile(
      IconData icon, String title, String subtitle, VoidCallback onTap) {
    final fern = context.fern;
    return ListTile(
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: fern.mist,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: fern.green, size: 19),
      ),
      title: Text(title,
          style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle,
          style: TextStyle(fontSize: 12, color: fern.slate)),
      trailing:
          Icon(Icons.chevron_right, color: fern.slate, size: 20),
      onTap: onTap,
    );
  }

}
