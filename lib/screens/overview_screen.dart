import 'package:flutter/material.dart';
import '../models/account.dart';
import '../models/transaction.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../utils/format.dart';
import '../widgets/common.dart';
import '../widgets/txn_tile.dart';
import 'txn_detail.dart';

class OverviewScreen extends StatefulWidget {
  final AppState state;

  const OverviewScreen({super.key, required this.state});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  List<Transaction>? _txns;

  @override
  void initState() {
    super.initState();
    widget.state.addListener(_onState);
    _load();
  }

  @override
  void dispose() {
    widget.state.removeListener(_onState);
    super.dispose();
  }

  void _onState() {
    if (mounted) setState(() {});
  }

  Future<void> _load() async {
    try {
      final page = await widget.state.api.getTransactions();
      if (mounted) setState(() => _txns = page.items);
    } catch (_) {
      if (mounted) setState(() => _txns = []);
    }
  }

  Future<void> _refresh() async {
    setState(() => _txns = null);
    await Future.wait([widget.state.reloadAccounts(), _load()]);
  }

  Map<String, double> _spendByGroup(List<Transaction> txns) {
    final totals = <String, double>{};
    for (final tx in txns) {
      if (tx.amount >= 0) continue;
      final group = tx.category?.groupName ?? 'Uncategorised';
      totals[group] = (totals[group] ?? 0) + tx.amount.abs().toDouble();
    }
    final entries = totals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return Map.fromEntries(entries.take(6));
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    return Scaffold(
      body: SafeArea(
        child: state.loading
            ? const Center(child: CircularProgressIndicator())
            : state.error != null && state.accounts.isEmpty
                ? ErrorState(
                    error: state.error!, onRetry: () => state.bootstrap())
                : RefreshIndicator(
                    onRefresh: _refresh,
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      children: [
                        _header(state),
                        const SizedBox(height: 20),
                        _balanceCard(state),
                        const SectionHeader('Accounts'),
                        _accountStrip(state.accounts),
                        if (_txns != null && _txns!.isNotEmpty) ...[
                          const SectionHeader('Spending this month'),
                          _spendCard(_spendByGroup(_txns!)),
                          const SectionHeader('Recent activity'),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  for (final tx in _txns!.take(8))
                                    TxnTile(
                                      tx: tx,
                                      accountName: state
                                          .accountById(tx.account)
                                          ?.name,
                                      onTap: () => showTxnDetail(
                                          context, widget.state.api, tx),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ] else if (_txns == null)
                          const Padding(
                            padding: EdgeInsets.all(40),
                            child: Center(child: CircularProgressIndicator()),
                          ),
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget _header(AppState state) {
    final hour = DateTime.now().hour;
    final greeting =
        hour < 12 ? 'Good morning' : hour < 17 ? 'Good afternoon' : 'Good evening';
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(greeting,
                    style: const TextStyle(color: Fern.slate, fontSize: 13)),
                const SizedBox(height: 2),
                const Text(
                  'Fern',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.8,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Fern.mist,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.eco_outlined, color: Fern.green),
          ),
        ],
      ),
    );
  }

  Widget _balanceCard(AppState state) {
    final assets = state.accounts
        .where((a) => !a.isDebt)
        .fold<num>(0, (s, a) => s + (a.displayBalance ?? 0));
    final debt = state.accounts
        .where((a) => a.isDebt)
        .fold<num>(0, (s, a) => s + (a.displayBalance ?? 0));
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Fern.deep, Fern.green, Fern.moss],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Net position',
            style: TextStyle(color: Fern.sprout, fontSize: 13),
          ),
          const SizedBox(height: 6),
          Text(
            money(state.totalBalance),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _miniStat('Assets', assets, Fern.sprout),
              const SizedBox(width: 24),
              _miniStat('Debt', debt.abs(), const Color(0xFFF2B8A0)),
              const Spacer(),
              Text(
                '${state.accounts.length} accounts',
                style: const TextStyle(color: Fern.sprout, fontSize: 12.5),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _miniStat(String label, num value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                color: color.withValues(alpha: 0.8), fontSize: 11.5)),
        Text(
          money(value),
          style: TextStyle(
              color: color, fontSize: 15, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget _accountStrip(List<Account> accounts) {
    return SizedBox(
      height: 128,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: accounts.length,
        separatorBuilder: (_, i) => const SizedBox(width: 10),
        itemBuilder: (context, i) {
          final a = accounts[i];
          return Container(
            width: 190,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFE4EBE0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    LogoAvatar(
                      url: a.connection?.logo,
                      fallback: accountTypeIcon(a.type),
                      size: 30,
                    ),
                    const Spacer(),
                    if (!a.isActive)
                      const StatusChip('Inactive', Fern.clay),
                  ],
                ),
                const Spacer(),
                Text(
                  a.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 12.5,
                      color: Fern.slate,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 2),
                MoneyText(
                  a.displayBalance,
                  currency: a.balance?.currency ?? 'NZD',
                  size: 18,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _spendCard(Map<String, double> groups) {
    if (groups.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text('No spending this month',
              style: TextStyle(color: Fern.slate)),
        ),
      );
    }
    final max = groups.values.first;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            for (final e in groups.entries)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    SizedBox(
                      width: 110,
                      child: Text(
                        e.key,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 12.5, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: max == 0 ? 0 : e.value / max,
                          minHeight: 10,
                          backgroundColor: Fern.mist,
                          valueColor: const AlwaysStoppedAnimation(Fern.fern),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 72,
                      child: Text(
                        money(e.value),
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            fontSize: 12.5, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
