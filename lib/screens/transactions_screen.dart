import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../utils/format.dart';
import '../widgets/common.dart';
import '../widgets/txn_tile.dart';
import 'txn_detail.dart';

class TransactionsScreen extends StatefulWidget {
  final AppState state;

  const TransactionsScreen({super.key, required this.state});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final _scroll = ScrollController();
  final _searchCtrl = TextEditingController();
  final List<Transaction> _txns = [];
  String? _cursor;
  bool _loading = true;
  bool _loadingMore = false;
  String? _error;
  String _query = '';
  String _direction = 'all';
  int _days = 30;

  @override
  void initState() {
    super.initState();
    _load();
    _scroll.addListener(() {
      if (_scroll.position.pixels >
              _scroll.position.maxScrollExtent - 300 &&
          !_loading &&
          !_loadingMore &&
          _cursor != null) {
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  String get _start =>
      isoDay(DateTime.now().subtract(Duration(days: _days)));

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final page =
          await widget.state.api.getTransactions(start: _start);
      if (mounted) {
        setState(() {
          _txns
            ..clear()
            ..addAll(page.items);
          _cursor = page.nextCursor;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _loading = false;
        });
      }
    }
  }

  Future<void> _loadMore() async {
    setState(() => _loadingMore = true);
    try {
      final page = await widget.state.api
          .getTransactions(start: _start, cursor: _cursor);
      if (mounted) {
        setState(() {
          _txns.addAll(page.items);
          _cursor = page.nextCursor;
          _loadingMore = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loadingMore = false);
    }
  }

  List<Transaction> get _filtered {
    return _txns.where((tx) {
      if (_direction == 'in' && tx.amount <= 0) return false;
      if (_direction == 'out' && tx.amount >= 0) return false;
      if (_query.isNotEmpty) {
        final q = _query.toLowerCase();
        final hay = [
          tx.description,
          tx.merchant?.name ?? '',
          tx.category?.name ?? '',
          tx.category?.groupName ?? '',
          txTypeLabel(tx.type),
        ].join(' ').toLowerCase();
        if (!hay.contains(q)) return false;
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
      appBar: AppBar(title: const Text('Activity')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              controller: _searchCtrl,
              onChanged: (v) => setState(() => _query = v.trim()),
              decoration: InputDecoration(
                hintText: 'Search merchants, categories…',
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close, size: 18),
                        onPressed: () {
                          _searchCtrl.clear();
                          setState(() => _query = '');
                        },
                      )
                    : null,
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _chip('All', _direction == 'all',
                    () => setState(() => _direction = 'all')),
                _chip('Money in', _direction == 'in',
                    () => setState(() => _direction = 'in')),
                _chip('Money out', _direction == 'out',
                    () => setState(() => _direction = 'out')),
                const SizedBox(width: 8),
                _chip('30 days', _days == 30, () {
                  setState(() => _days = 30);
                  _load();
                }),
                _chip('90 days', _days == 90, () {
                  setState(() => _days = 90);
                  _load();
                }),
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
        labelStyle: TextStyle(
          color: selected ? Colors.white : Fern.ink,
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _body() {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_error != null) return ErrorState(error: _error!, onRetry: _load);
    final grouped = _grouped;
    if (grouped.isEmpty) {
      return const EmptyState(
        icon: Icons.receipt_long_outlined,
        title: 'No transactions',
        message: 'Try widening your filters or date range.',
      );
    }
    final keys = grouped.keys.toList()..sort((a, b) => b.compareTo(a));
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView.builder(
        controller: _scroll,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        itemCount: keys.length + 1,
        itemBuilder: (context, i) {
          if (i == keys.length) {
            return _loadingMore
                ? const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : const SizedBox(height: 40);
          }
          final key = keys[i];
          final dayTxns = grouped[key]!;
          final net = dayTxns.fold<num>(0, (s, t) => s + t.amount);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 14, 4, 6),
                child: Row(
                  children: [
                    Text(
                      relativeDate(key),
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Fern.slate),
                    ),
                    const Spacer(),
                    Text(
                      money(net, sign: true),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: net >= 0 ? Fern.green : Fern.slate,
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
                          accountName:
                              widget.state.accountById(tx.account)?.name,
                          onTap: () =>
                              showTxnDetail(context, widget.state.api, tx),
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
