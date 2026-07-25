import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final List<Transaction> _txns = [];
  List<PendingTransaction> _pending = [];
  String? _cursor;
  bool _loading = true;
  bool _loadingMore = false;
  String? _error;

  @override
  void initState() {
    super.initState();
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
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final api = widget.state.api;
      final results = await Future.wait([
        api.getAccountTransactions(widget.account.id),
        api.getAccountPendingTransactions(widget.account.id),
      ]);
      if (mounted) {
        setState(() {
          final page = results[0] as dynamic;
          _txns
            ..clear()
            ..addAll(page.items as List<Transaction>);
          _cursor = page.nextCursor as String?;
          _pending = results[1] as List<PendingTransaction>;
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
          .getAccountTransactions(widget.account.id, cursor: _cursor);
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

  Future<void> _verificationToken() async {
    final api = widget.state.api;
    try {
      final token = await api.getVerificationToken(widget.account.id);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Verification token'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Share this token with an app so they can pay this account.',
                style: TextStyle(color: Fern.slate, fontSize: 13),
              ),
              const SizedBox(height: 12),
              SelectableText(token,
                  style: const TextStyle(
                      fontSize: 12, fontFamily: 'monospace')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: token));
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Copied')));
                }
              },
              child: const Text('Copy'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await api.deleteVerificationToken(widget.account.id);
                  if (context.mounted) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Verification token revoked')));
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                }
              },
              child:
                  const Text('Revoke', style: TextStyle(color: Fern.clay)),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              style: FilledButton.styleFrom(minimumSize: const Size(80, 44)),
              child: const Text('Done'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final a = widget.account;
    return Scaffold(
      appBar: AppBar(
        title: Text(a.name),
        actions: [
          IconButton(
            tooltip: 'Refresh this account',
            icon: const Icon(Icons.sync),
            onPressed: _refreshAccount,
          ),
          if (a.canPayTo)
            IconButton(
              tooltip: 'Verification token',
              icon: const Icon(Icons.verified_user_outlined),
              onPressed: _verificationToken,
            ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
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
                        const Card(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text('No transactions found',
                                style: TextStyle(color: Fern.slate)),
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
                                    onTap: () => showTxnDetail(
                                        context, widget.state.api, tx),
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
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: Center(
                            child: Text('End of history',
                                style: TextStyle(
                                    color: Fern.slate, fontSize: 12)),
                          ),
                        ),
                    ],
                  ),
                ),
    );
  }

  Widget _balanceHero(Account a) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Fern.deep, Fern.green],
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
                        style: const TextStyle(
                            color: Fern.sprout, fontSize: 12.5)),
                    Text(accountTypeLabel(a.type),
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
              if (!a.isActive) const StatusChip('Inactive', Fern.clay),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            money(a.displayBalance,
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
                Text('${money(a.balance!.available)} available',
                    style:
                        const TextStyle(color: Fern.sprout, fontSize: 12.5)),
              if (a.balance?.limit != null)
                Text('${money(a.balance!.limit)} limit',
                    style:
                        const TextStyle(color: Fern.sprout, fontSize: 12.5)),
              if (a.refreshed?.balance != null)
                Text('Updated ${relativeDate(a.refreshed!.balance)}',
                    style:
                        const TextStyle(color: Fern.sprout, fontSize: 12.5)),
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
                  style: const TextStyle(fontSize: 12, color: Fern.slate),
                ),
              ],
            ),
          ),
          AmountText(p.amount),
        ],
      ),
    );
  }
}
