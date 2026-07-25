import 'package:flutter/material.dart';
import '../models/account.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../utils/format.dart';
import '../widgets/common.dart';
import 'account_detail_screen.dart';

class AccountsScreen extends StatefulWidget {
  final AppState state;

  const AccountsScreen({super.key, required this.state});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  bool _refreshing = false;

  @override
  void initState() {
    super.initState();
    widget.state.addListener(_onState);
  }

  @override
  void dispose() {
    widget.state.removeListener(_onState);
    super.dispose();
  }

  void _onState() {
    if (mounted) setState(() {});
  }

  Future<void> _refreshData() async {
    setState(() => _refreshing = true);
    try {
      await widget.state.requestRefresh();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
    if (mounted) setState(() => _refreshing = false);
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
        actions: [
          if (_refreshing)
            const Padding(
              padding: EdgeInsets.all(14),
              child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2)),
            )
          else
            IconButton(
              tooltip: 'Refresh bank data',
              icon: const Icon(Icons.sync),
              onPressed: _refreshData,
            ),
        ],
      ),
      body: state.loading
          ? const Center(child: CircularProgressIndicator())
          : state.accounts.isEmpty
              ? const EmptyState(
                  icon: Icons.account_balance_outlined,
                  title: 'No accounts',
                  message: 'Connect an account through Akahu to see it here.')
              : RefreshIndicator(
                  onRefresh: () => state.reloadAccounts(),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.accounts.length,
                    itemBuilder: (context, i) =>
                        _AccountCard(account: state.accounts[i], state: state),
                  ),
                ),
    );
  }
}

class _AccountCard extends StatelessWidget {
  final Account account;
  final AppState state;

  const _AccountCard({required this.account, required this.state});

  @override
  Widget build(BuildContext context) {
    final a = account;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AccountDetailScreen(state: state, account: a),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    LogoAvatar(
                      url: a.connection?.logo,
                      fallback: accountTypeIcon(a.type),
                      size: 42,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            a.name,
                            style: const TextStyle(
                                fontSize: 15.5, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            [
                              a.connection?.name ?? '',
                              accountTypeLabel(a.type),
                              if (a.formattedAccount != null)
                                a.formattedAccount!,
                            ].where((e) => e.isNotEmpty).join(' · '),
                            style: const TextStyle(
                                fontSize: 12, color: Fern.slate),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        MoneyText(
                          a.displayBalance,
                          currency: a.balance?.currency ?? 'NZD',
                          size: 17,
                          color: (a.displayBalance ?? 0) < 0
                              ? Fern.clay
                              : Fern.ink,
                        ),
                        if (a.balance?.available != null &&
                            a.balance!.available != a.balance!.current)
                          Text(
                            '${money(a.balance!.available)} available',
                            style: const TextStyle(
                                fontSize: 11, color: Fern.slate),
                          ),
                      ],
                    ),
                  ],
                ),
                if (!a.isActive || a.balance?.overdrawn == true) ...[
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      if (!a.isActive)
                        const StatusChip('Connection inactive', Fern.clay),
                      if (a.balance?.overdrawn == true) ...[
                        const SizedBox(width: 6),
                        const StatusChip('Overdrawn', Fern.clay),
                      ],
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
