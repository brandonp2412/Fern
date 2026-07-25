import 'package:flutter/material.dart';
import '../models/account.dart';
import '../models/transaction.dart';
import '../services/akahu_api.dart';

class HomeScreen extends StatefulWidget {
  final AkahuApi api;

  const HomeScreen({super.key, required this.api});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Account> _accounts = [];
  Map<String, List<Transaction>> _transactions = {};
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final accounts = await widget.api.getAccounts();
      final txMap = <String, List<Transaction>>{};
      for (final a in accounts) {
        try {
          txMap[a.id] = await widget.api.getAccountTransactions(a.id, limit: 3);
        } catch (_) {
          txMap[a.id] = [];
        }
      }
      if (mounted) {
        setState(() {
          _accounts = accounts;
          _transactions = txMap;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FernMoney'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() => _loading = true);
              _loadData();
            },
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _loading = true;
                  _error = null;
                });
                _loadData();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
    if (_accounts.isEmpty) {
      return const Center(child: Text('No accounts found'));
    }
    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _accounts.length,
        itemBuilder: (context, index) => _buildAccountCard(_accounts[index]),
      ),
    );
  }

  Widget _buildAccountCard(Account account) {
    final txs = _transactions[account.id] ?? [];
    final isCredit =
        account.type.toUpperCase() == 'CREDITCARD' || account.type.toUpperCase() == 'LOAN';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAccountHeader(account, isCredit),
            if (txs.isNotEmpty) ...[
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 8),
              ...txs.map((tx) => _buildTransactionRow(tx, isCredit)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAccountHeader(Account account, bool isCredit) {
    return Row(
      children: [
        account.connection != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  account.connection!.logo,
                  width: 32,
                  height: 32,
                  errorBuilder: (_, e, s) => Icon(
                    Icons.account_balance,
                    color: Colors.green.shade700,
                    size: 32,
                  ),
                ),
              )
            : Icon(Icons.account_balance, color: Colors.green.shade700, size: 32),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                account.name,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              if (account.formattedAccount != null)
                Text(
                  account.formattedAccount!,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
            ],
          ),
        ),
        _buildBalance(account.balance?.current ?? account.balance?.available, isCredit),
      ],
    );
  }

  Widget _buildBalance(num? bal, bool isCredit) {
    if (bal == null) return const SizedBox.shrink();
    final formatted =
        '\$${bal.abs().toStringAsFixed(2).replaceAllMapped(RegExp(r"(\d)(?=(\d{3})+(?!\d))"), (m) => '${m[1]},')}';
    final sign = isCredit && bal > 0 ? '-' : bal < 0 ? '-' : '';
    return Text(
      '$sign$formatted',
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: bal < 0 ? Colors.red.shade700 : Colors.green.shade700,
      ),
    );
  }

  Widget _buildTransactionRow(Transaction tx, bool isCredit) {
    final isNegative = tx.amount < 0;
    final sign = isNegative ? '-' : '';
    final formatted =
        '\$${tx.amount.abs().toStringAsFixed(2).replaceAllMapped(RegExp(r"(\d)(?=(\d{3})+(?!\d))"), (m) => '${m[1]},')}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              tx.description.isNotEmpty ? tx.description : tx.type,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$sign$formatted',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color:
                  tx.type == 'CREDIT' ? Colors.green.shade700 : Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }
}
