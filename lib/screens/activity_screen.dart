import 'dart:async';

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../utils/format.dart';
import '../widgets/common.dart';
import '../widgets/txn_tile.dart';
import 'txn_detail.dart';

class ActivityScreen extends StatefulWidget {
  final AppState state;

  const ActivityScreen({super.key, required this.state});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final _scroll = ScrollController();
  final _searchCtrl = TextEditingController();
  String _query = '';
  String _direction = 'all';
  int _days = 30;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    widget.state.addListener(_onAppStateChange);
    _scroll.addListener(() {
      final state = widget.state;
      if (_scroll.position.pixels > _scroll.position.maxScrollExtent - 300 &&
          state.txnCursor != null) {
        state.loadOlder();
      }
    });
  }

  void _onAppStateChange() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    _debounce?.cancel();
    widget.state.removeListener(_onAppStateChange);
    _scroll.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  void _setQuery(String v) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () {
      if (!mounted) return;
      setState(() => _query = _searchCtrl.text.trim());
    });
  }

  DateTime _cutoff() => DateTime.now().subtract(Duration(days: _days));

  List<Transaction> get _filtered {
    final cut = _cutoff();
    return widget.state.transactions.where((tx) {
      if (_direction == 'in' && tx.amount <= 0) return false;
      if (_direction == 'out' && tx.amount >= 0) return false;
      final d = parseDate(tx.date);
      if (d != null && d.isBefore(cut)) return false;
      if (_query.isNotEmpty) {
        final q = _query.toLowerCase();
        final searchHay = [
          tx.description,
          tx.merchant?.name ?? '',
          tx.category?.name ?? '',
          tx.category?.groupName ?? '',
          txTypeLabel(tx.type),
        ].join(' ').toLowerCase();
        if (!searchHay.contains(q)) return false;
      }
      return true;
    }).toList();
  }

  Map<String, List<Transaction>> get _grouped {
    final map = <String, List<Transaction>>{};
    for (final tx in _filtered) {
      final d = parseDate(tx.date);
      final key = d == null ? 'Unknown' : isoDay(d);
      map.putIfAbsent(key, () => []).add(tx);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity'),
        actions: [if (widget.state.refreshing) const AppBarSpinner()],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              controller: _searchCtrl,
              onChanged: _setQuery,
              decoration: InputDecoration(
                hintText: 'Search merchants, categories…',
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _searchCtrl,
                  builder: (_, value, _) {
                    if (value.text.isEmpty) return const SizedBox.shrink();
                    return IconButton(
                      icon: const Icon(Icons.close, size: 18),
                      onPressed: () {
                        _searchCtrl.clear();
                        _debounce?.cancel();
                        setState(() => _query = '');
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _chip(
                  'All',
                  _direction == 'all',
                  () => setState(() => _direction = 'all'),
                ),
                _chip(
                  'Money in',
                  _direction == 'in',
                  () => setState(() => _direction = 'in'),
                ),
                _chip(
                  'Money out',
                  _direction == 'out',
                  () => setState(() => _direction = 'out'),
                ),
                const SizedBox(width: 8),
                _chip('30 days', _days == 30, () => setState(() => _days = 30)),
                _chip('90 days', _days == 90, () => setState(() => _days = 90)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(child: _body()),
        ],
      ),
    );
  }

  Widget _chip(String label, bool selected, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        checkmarkColor: selected ? Colors.white : context.fern.ink,
        labelStyle: TextStyle(
          color: selected ? Colors.white : context.fern.ink,
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _body() {
    final state = widget.state;
    final cold = state.accounts.isEmpty && state.transactions.isEmpty;
    if (cold) {
      if (state.error != null) {
        return ErrorState(error: state.error!, onRetry: () => state.load());
      }
      return const Center(child: CircularProgressIndicator());
    }
    final grouped = _grouped;
    if (grouped.isEmpty) {
      final txns = state.transactions;
      if (txns.isEmpty && state.refreshing) {
        return const Center(child: CircularProgressIndicator());
      }
      return const EmptyState(
        icon: Icons.receipt_long_outlined,
        title: 'No transactions',
        message: 'Try widening your filters or date range.',
      );
    }
    final keys = grouped.keys.toList()..sort((a, b) => b.compareTo(a));
    return RefreshIndicator(
      onRefresh: () => state.load(force: true),
      child: ListView.builder(
        controller: _scroll,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        itemCount: keys.length + 1,
        itemBuilder: (context, i) {
          if (i == keys.length) {
            return state.txnCursor != null
                ? const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : const SizedBox(height: 40);
          }
          final fern = context.fern;
          final key = keys[i];
          final dayTxns = grouped[key]!;
          final net = dayTxns.fold<num>(0, (s, t) => s + t.amount);
          final masked = state.settings.hideBalances;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 14, 4, 6),
                child: Row(
                  children: [
                    Text(
                      relativeDate(key),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: fern.slate,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      masked ? '••••' : money(net, sign: true),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: net >= 0 ? fern.green : fern.slate,
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      for (final tx in dayTxns)
                        TxnTile(
                          tx: tx,
                          accountName: state.accountById(tx.account)?.name,
                          categoryGroupOverride: state.categoryGroupFor(tx),
                          masked: masked,
                          onTap: () => showTxnDetail(context, state, tx),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
