import 'package:fern/screens/account_detail_screen.dart';
import 'package:flutter/material.dart';
import '../models/account.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../utils/format.dart';
import '../widgets/common.dart';
import '../widgets/txn_tile.dart';
import 'recategorize_screen.dart';
import 'txn_detail.dart';

class OverviewScreen extends StatefulWidget {
  final AppState state;

  const OverviewScreen({super.key, required this.state});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final masked = state.settings.hideBalances;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => state.load(force: true),
          child: ListenableBuilder(
            listenable: state,
            builder: (context, _) {
              final txns = state.transactions;

              if (state.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.accounts.isEmpty && txns.isEmpty && state.error != null) {
                return ErrorState(
                  error: state.error!,
                  onRetry: () => state.load(),
                );
              }

              return ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                children: [
                  _header(context, state),
                  const SizedBox(height: 20),
                  _balanceCard(context, state),
                  const SectionHeader('Accounts'),
                  _accountStrip(state.visibleAccounts, masked),
                  if (txns.isNotEmpty) ...[
                    SectionHeader(
                      'Spending this month',
                      trailing: IconButton(
                        icon: Icon(
                          Icons.settings_outlined,
                          size: 18,
                          color: context.fern.slate,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          final now = DateTime.now();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => RecategorizeScreen(
                                state: state,
                                start: DateTime(now.year, now.month, 1),
                                end: DateTime(now.year, now.month + 1, 1)
                                    .subtract(const Duration(seconds: 1)),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    _spendCard(context, state.spendByGroup),
                    const SectionHeader('Recent activity'),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            for (final tx in txns.take(8))
                              TxnTile(
                                tx: tx,
                                categoryGroupOverride: state.categoryGroupFor(
                                  tx,
                                ),
                                imagePath: state.imagePathFor(tx),
                                masked: masked,
                                onTap: () => showTxnDetail(context, state, tx),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context, AppState state) {
    final fern = context.fern;
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? 'Good morning'
        : hour < 17
        ? 'Good afternoon'
        : 'Good evening';
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting,
                  style: TextStyle(color: fern.slate, fontSize: 13),
                ),
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
            decoration: BoxDecoration(color: fern.mist, shape: BoxShape.circle),
            child: state.refreshing
                ? SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: fern.green,
                    ),
                  )
                : Icon(Icons.eco_outlined, color: fern.green),
          ),
        ],
      ),
    );
  }

  Widget _balanceCard(BuildContext context, AppState state) {
    final fern = context.fern;
    final masked = state.settings.hideBalances;
    final visible = state.visibleAccounts;
    final assets = visible
        .where((a) => !a.isDebt)
        .fold<num>(0, (s, a) => s + (a.displayBalance ?? 0));
    final debt = visible
        .where((a) => a.isDebt)
        .fold<num>(0, (s, a) => s + (a.displayBalance ?? 0));
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [fern.deep, fern.green, fern.moss],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Net position',
            style: TextStyle(color: fern.sprout, fontSize: 13),
          ),
          const SizedBox(height: 6),
          Text(
            masked ? '••••' : money(state.totalBalance),
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
              _miniStat('Assets', assets, fern.sprout, masked),
              const SizedBox(width: 24),
              if (state.settings.showDebt)
                _miniStat('Debt', debt.abs(), const Color(0xFFF2B8A0), masked),
              const Spacer(),
              Text(
                '${visible.length} accounts',
                style: TextStyle(color: fern.sprout, fontSize: 12.5),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _miniStat(String label, num value, Color color, bool masked) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: color.withValues(alpha: 0.8), fontSize: 11.5),
        ),
        Text(
          masked ? '••••' : money(value),
          style: TextStyle(
            color: color,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _accountStrip(List<Account> accounts, bool masked) {
    return SizedBox(
      height: 128,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: accounts.length,
        separatorBuilder: (_, i) => const SizedBox(width: 10),
        itemBuilder: (context, i) {
          final fern = context.fern;
          final a = accounts[i];
          return SizedBox(
            width: 190,
            child: Card(
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        AccountDetailScreen(state: widget.state, account: a),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          LogoAvatar(
                            url: a.connection?.logo,
                            fallback: accountTypeIcon(a.type),
                            size: 45,
                          ),
                          const Spacer(),
                          if (!a.isActive) StatusChip('Inactive', fern.clay),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        a.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.5,
                          color: fern.slate,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      MoneyText(
                        a.displayBalance,
                        currency: a.balance?.currency ?? 'NZD',
                        size: 18,
                        masked: masked,
                        color: (a.displayBalance ?? 0) < 0 ? fern.clay : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _spendCard(BuildContext context, Map<String, double> groups) {
    final fern = context.fern;
    if (groups.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'No spending this month',
            style: TextStyle(color: fern.slate),
          ),
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
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: max == 0 ? 0 : e.value / max,
                          minHeight: 10,
                          backgroundColor: fern.mist,
                          valueColor: AlwaysStoppedAnimation(fern.green),
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
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                        ),
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
