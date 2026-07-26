import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/account.dart';
import '../models/transaction.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../utils/format.dart';
import '../widgets/common.dart';
import '../widgets/txn_tile.dart';
import 'txn_detail.dart';

class AccountDetailScreen extends StatefulWidget {
  final AppState state;
  final Account account;

  const AccountDetailScreen(
      {super.key, required this.state, required this.account});

  @override
  State<AccountDetailScreen> createState() => _AccountDetailScreenState();
}

class _AccountDetailScreenState extends State<AccountDetailScreen> {
  final _scroll = ScrollController();
  List<Transaction> _txns = [];
  List<PendingTransaction> _pending = [];
  String? _cursor;
  bool _loading = true;
  bool _refreshing = false;
  bool _loadingMore = false;
  String? _error;
  StreamSubscription<List<String>>? _txnsSub;

  @override
  void initState() {
    super.initState();
    _txnsSub = widget.state.db
        .watchTransactionsJson(accountId: widget.account.id, limit: 500)
        .listen(_onTxnRows);
    _load();
    _scroll.addListener(() {
      if (_scroll.position.pixels >
              _scroll.position.maxScrollExtent - 200 &&
          !_loadingMore &&
          _cursor != null) {
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    _txnsSub?.cancel();
    _scroll.dispose();
    super.dispose();
  }

  void _onTxnRows(List<String> rows) {
    final result = rows
        .map((s) => Transaction.fromJson(json.decode(s) as Map<String, dynamic>))
        .toList();
    result.sort((a, b) =>
        (parseDate(b.date) ?? DateTime(0)).compareTo(parseDate(a.date) ?? DateTime(0)));
    if (!mounted) return;
    setState(() {
      _txns = result;
      _loading = false;
    });
  }

  Future<void> _load() async {
    setState(() {
      _refreshing = true;
      _error = null;
    });
    try {
      final api = widget.state.api;
      final results = await Future.wait([
        api.getAccountTransactions(widget.account.id),
        api.getAccountPendingTransactions(widget.account.id),
      ]);
      final page = results[0] as dynamic;
      final items = page.items as List<Transaction>;
      widget.state.cacheTransactions(items);
      if (mounted) {
        setState(() {
          _cursor = page.nextCursor as String?;
          _pending = results[1] as List<PendingTransaction>;
          _refreshing = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _refreshing = false;
          if (_txns.isEmpty) _error = e.toString();
        });
      }
    }
  }

  Future<void> _loadMore() async {
    setState(() => _loadingMore = true);
    try {
      final page = await widget.state.api
          .getAccountTransactions(widget.account.id, cursor: _cursor);
      widget.state.cacheTransactions(page.items);
      if (mounted) {
        setState(() {
          _cursor = page.nextCursor;
          _loadingMore = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loadingMore = false);
    }
  }

  Future<void> _refreshAccount() async {
    try {
      await widget.state.api.refresh(widget.account.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Refresh requested — check back shortly')));
      }
      await Future.delayed(const Duration(seconds: 5));
      await _load();
      await widget.state.reloadAccounts();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final fern = context.fern;
    final a = widget.account;
    return Scaffold(
      appBar: AppBar(
        title: Text(a.name),
        actions: [
          if (_refreshing) const AppBarSpinner(),
          IconButton(
            tooltip: 'Refresh this account',
            icon: const Icon(Icons.sync),
            onPressed: _refreshAccount,
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null && _txns.isEmpty
              ? ErrorState(error: _error!, onRetry: _load)
              : RefreshIndicator(
                  onRefresh: _load,
                  child: ListView(
                    controller: _scroll,
                    padding: const EdgeInsets.all(16),
                    children: [
                      _balanceHero(a),
                      if (_pending.isNotEmpty) ...[
                        SectionHeader('Pending (${_pending.length})'),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                for (final p in _pending) _pendingRow(p),
                              ],
                            ),
                          ),
                        ),
                      ],
                      SectionHeader('Transactions'),
                      if (_txns.isEmpty)
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text('No transactions found',
                                style: TextStyle(color: fern.slate)),
                          ),
                        )
                      else
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                for (final tx in _txns)
                                  TxnTile(
                                    tx: tx,
                                    masked: widget.state.settings.hideBalances,
                                    categoryGroupOverride: widget.state
                                        .categoryGroupFor(tx),
                                    onTap: () => showTxnDetail(
                                        context, widget.state, tx),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      if (_loadingMore)
                        const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      else if (_cursor == null && _txns.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Center(
                            child: Text('End of history',
                                style: TextStyle(
                                    color: fern.slate, fontSize: 12)),
                          ),
                        ),
                    ],
                  ),
                ),
    );
  }

  Widget _balanceHero(Account a) {
    final fern = context.fern;
    final masked = widget.state.settings.hideBalances;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [fern.deep, fern.green],
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              LogoAvatar(
                url: a.connection?.logo,
                fallback: accountTypeIcon(a.type),
                size: 40,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(a.connection?.name ?? '',
                        style:
                            TextStyle(color: fern.sprout, fontSize: 12.5)),
                    Text(accountTypeLabel(a.type),
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
              if (!a.isActive) StatusChip('Inactive', fern.clay),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            masked
                ? '••••'
                : money(a.displayBalance,
                    currency: a.balance?.currency ?? 'NZD'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 14,
            children: [
              if (a.balance?.available != null)
                Text(
                    masked
                        ? '•••• available'
                        : '${money(a.balance!.available)} available',
                    style: TextStyle(color: fern.sprout, fontSize: 12.5)),
              if (a.balance?.limit != null)
                Text(
                    masked
                        ? '•••• limit'
                        : '${money(a.balance!.limit)} limit',
                    style: TextStyle(color: fern.sprout, fontSize: 12.5)),
              if (a.refreshed?.balance != null)
                Text('Updated ${relativeDate(a.refreshed!.balance)}',
                    style: TextStyle(color: fern.sprout, fontSize: 12.5)),
            ],
          ),
          if (a.formattedAccount != null) ...[
            const SizedBox(height: 8),
            Text(a.formattedAccount!,
                style: const TextStyle(color: Colors.white54, fontSize: 12)),
          ],
        ],
      ),
    );
  }

  Widget _pendingRow(PendingTransaction p) {
    final fern = context.fern;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFFB8860B),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Text(
                  '${relativeDate(p.date)} · pending',
                  style: TextStyle(fontSize: 12, color: fern.slate),
                ),
              ],
            ),
          ),
          AmountText(p.amount,
              masked: widget.state.settings.hideBalances),
        ],
      ),
    );
  }
}
