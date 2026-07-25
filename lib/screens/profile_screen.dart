import 'package:flutter/material.dart';
import '../main.dart';
import '../models/party.dart';
import '../services/secure_store.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../utils/format.dart';
import '../widgets/common.dart';
import 'categories_screen.dart';
import 'connections_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  final AppState state;

  const ProfileScreen({super.key, required this.state});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Party>? _parties;

  @override
  void initState() {
    super.initState();
    _loadParties();
  }

  Future<void> _loadParties() async {
    try {
      final parties = await widget.state.api.getParties();
      if (mounted) setState(() => _parties = parties);
    } catch (_) {
      if (mounted) setState(() => _parties = []);
    }
  }

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
          if (_parties != null && _parties!.isNotEmpty) ...[
            const SectionHeader('Bank profile details'),
            Card(
              child: Column(
                children: [
                  for (final p in _parties!) _partyTile(p),
                ],
              ),
            ),
          ],
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
                const Divider(indent: 56),
                _menuTile(
                  Icons.verified_outlined,
                  'Verify a name',
                  'Match a name against your bank records',
                  () => _verifyName(),
                ),
                if (widget.state.api.hasAppSecret) ...[
                  const Divider(indent: 56),
                  _menuTile(
                    Icons.category_outlined,
                    'Categories',
                    'Browse the NZFCC category tree',
                    () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) =>
                            CategoriesScreen(api: widget.state.api))),
                  ),
                  const Divider(indent: 56),
                  _menuTile(
                    Icons.account_balance_outlined,
                    'Connections',
                    'Institutions available through Akahu',
                    () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) =>
                            ConnectionsScreen(api: widget.state.api))),
                  ),
                ],
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

  Widget _partyTile(Party p) {
    final fern = context.fern;
    return ExpansionTile(
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: fern.mist,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(Icons.badge_outlined, color: fern.green, size: 19),
      ),
      title: Text(p.name ?? 'Party',
          style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600)),
      subtitle: Text(
        [if (p.dob != null) 'Born ${p.dob}', if (p.taxNumber != null) 'IRD ${p.taxNumber}']
            .join(' · '),
        style: TextStyle(fontSize: 12, color: fern.slate),
      ),
      childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
      children: [
        for (final e in p.emails)
          _partyRow(Icons.email_outlined, e.value,
              [if (e.subtype != null) e.subtype!, if (e.verified) 'verified']),
        for (final ph in p.phones)
          _partyRow(Icons.phone_outlined, ph.value,
              [if (ph.subtype != null) ph.subtype!, if (ph.verified) 'verified']),
        for (final a in p.addresses)
          _partyRow(Icons.home_outlined, a.formatted ?? a.value,
              [if (a.subtype != null) a.subtype!, if (a.verified) 'verified']),
      ],
    );
  }

  Widget _partyRow(IconData icon, String value, List<String> tags) {
    final fern = context.fern;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, size: 16, color: fern.moss),
          const SizedBox(width: 10),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 13)),
          ),
          Text(tags.join(' · '),
              style: TextStyle(fontSize: 11, color: fern.slate)),
        ],
      ),
    );
  }

  void _verifyName() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => VerifyNameSheet(state: widget.state),
    );
  }
}

class VerifyNameSheet extends StatefulWidget {
  final AppState state;

  const VerifyNameSheet({super.key, required this.state});

  @override
  State<VerifyNameSheet> createState() => _VerifyNameSheetState();
}

class _VerifyNameSheetState extends State<VerifyNameSheet> {
  final _givenCtrl = TextEditingController();
  final _middleCtrl = TextEditingController();
  final _familyCtrl = TextEditingController();
  String? _accountId;
  bool _checking = false;
  Map<String, dynamic>? _result;
  String? _error;

  @override
  void dispose() {
    _givenCtrl.dispose();
    _middleCtrl.dispose();
    _familyCtrl.dispose();
    super.dispose();
  }

  Future<void> _check() async {
    if (_familyCtrl.text.trim().isEmpty) return;
    setState(() {
      _checking = true;
      _result = null;
      _error = null;
    });
    try {
      final api = widget.state.api;
      final res = _accountId == null
          ? await api.verifyName(
              givenName: _givenCtrl.text.trim(),
              middleName: _middleCtrl.text.trim(),
              familyName: _familyCtrl.text.trim(),
            )
          : await api.verifyNameForAccount(
              _accountId!,
              givenName: _givenCtrl.text.trim(),
              middleName: _middleCtrl.text.trim(),
              familyName: _familyCtrl.text.trim(),
            );
      setState(() {
        _result = res;
        _checking = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _checking = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final fern = context.fern;
    final sources = _result?['item']?['sources'] as List<dynamic>?;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: fern.slate.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Verify a name',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            Text(
              'Check a name against the records your bank holds.',
              style: TextStyle(color: fern.slate, fontSize: 13),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _givenCtrl,
                    decoration:
                        const InputDecoration(labelText: 'First name'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _middleCtrl,
                    decoration:
                        const InputDecoration(labelText: 'Middle name'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _familyCtrl,
              decoration: const InputDecoration(labelText: 'Family name *'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _accountId,
              decoration: const InputDecoration(
                  labelText: 'Scope (optional)',
                  helperText: 'Check against one account\'s holder name'),
              items: [
                const DropdownMenuItem(value: null, child: Text('All records')),
                for (final a in widget.state.accounts)
                  DropdownMenuItem(value: a.id, child: Text(a.name)),
              ],
              onChanged: (v) => setState(() => _accountId = v),
            ),
            const SizedBox(height: 18),
            FilledButton(
              onPressed: _checking ? null : _check,
              child: _checking
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white))
                  : const Text('Check name'),
            ),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!, style: TextStyle(color: fern.clay)),
            ],
            if (sources != null) ...[
              const SizedBox(height: 16),
              for (final s in sources)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              s['match'] == true
                                  ? Icons.check_circle_outline
                                  : Icons.highlight_off,
                              color: s['match'] == true
                                  ? fern.green
                                  : fern.clay,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                s['name'] ?? '',
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${s['type'] == 'PARTY_NAME' ? 'Bank profile name' : 'Account holder name'} · match score ${s['match_score'] ?? '—'}',
                          style: TextStyle(
                              fontSize: 12, color: fern.slate),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
