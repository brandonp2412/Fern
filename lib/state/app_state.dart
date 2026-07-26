import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import '../db/app_database.dart';
import '../models/account.dart';
import '../models/transaction.dart';
import '../models/user.dart';
import '../services/akahu_api.dart';
import '../services/auto_categorizer.dart';
import '../utils/format.dart';
import 'app_settings.dart';

class MonthTotal {
  final String label;
  final double income;
  final double expense;
  const MonthTotal({required this.label, required this.income, required this.expense});
}

class CategoryTotal {
  final String name;
  final double amount;
  const CategoryTotal({required this.name, required this.amount});
}

class WeekTotal {
  final String label;
  final double total;
  const WeekTotal({required this.label, required this.total});
}

class MerchantTotal {
  final String name;
  final double amount;
  const MerchantTotal({required this.name, required this.amount});
}

class AppState extends ChangeNotifier {
  final AkahuApi api;
  final AppSettings settings;
  final AppDatabase db = AppDatabase();

  User? user;
  List<Account> accounts = [];
  bool loading = true;
  bool refreshing = false;
  bool offline = false;
  String? error;

  List<Transaction> transactions = [];
  DateTime? lastSync;
  String? txnCursor;
  Future<void>? _inFlight;
  bool _loadingOlder = false;

  static const _windowDays = 182;
  static const _maxPages = 5;
  static const _staleAfter = Duration(minutes: 2);
  static const _monthCount = 6;

  Map<String, CategoryOverride> _categoryOverrides = {};
  Map<String, AutoCategory?> _catCache = {};

  Map<String, double> _spendByGroupMemo = {};
  List<Transaction>? _spendByGroupSrc;

  List<MonthTotal> aggMonthly = [];
  List<CategoryTotal> aggCategories = [];
  List<WeekTotal> aggWeekly = [];
  List<MerchantTotal> aggMerchants = [];

  AppState(this.api, this.settings) {
    settings.addListener(notifyListeners);
    _loadCategoryOverrides();
  }

  Future<void> _loadCategoryOverrides() async {
    _categoryOverrides = await db.loadCategoryOverrides();
    _recomputeSpendByGroup();
    _recomputeStats();
    notifyListeners();
  }

  List<Account> get visibleAccounts =>
      settings.showDebt ? accounts : accounts.where((a) => !a.isDebt).toList();

  num get totalBalance {
    num sum = 0;
    for (final a in visibleAccounts) {
      sum += a.displayBalance ?? 0;
    }
    return sum;
  }

  Future<void> load({bool force = false}) async {
    if (_inFlight != null) return _inFlight;

    if (!force && lastSync != null && DateTime.now().difference(lastSync!) < _staleAfter) {
      return;
    }

    _inFlight = _run();
    try {
      await _inFlight!;
    } finally {
      _inFlight = null;
    }
  }

  Future<void> _run() async {
    if (accounts.isEmpty && transactions.isEmpty) {
      final cachedAccounts = await db.loadAccountsJson();
      if (cachedAccounts.isNotEmpty) {
        accounts = cachedAccounts
            .map((s) => Account.fromJson(json.decode(s) as Map<String, dynamic>))
            .toList();
        loading = false;
        notifyListeners();
      }
      final cachedTxns = await loadCachedTransactions(limit: 1000);
      if (cachedTxns.isNotEmpty && transactions.isEmpty) {
        _setTransactions(cachedTxns);
        notifyListeners();
      }
    }

    refreshing = true;
    notifyListeners();
    try {
      final results = await Future.wait([api.getMe(), api.getAccounts()]);
      user = results[0] as User;
      accounts = results[1] as List<Account>;
      loading = false;
      refreshing = false;
      offline = false;
      error = null;
      lastSync = DateTime.now();
      unawaited(db.saveAccounts({for (final a in accounts) a.id: json.encode(a.toJson())}));
      notifyListeners();
    } catch (e) {
      refreshing = false;
      offline = true;
      loading = false;
      if (transactions.isEmpty) {
        error = e.toString();
      }
      notifyListeners();
      return;
    }

    try {
      final txns = await _fetchTransactions();
      _setTransactions(txns);
      cacheTransactions(transactions);
    } catch (e) {
      debugPrint('AppState.load: transaction fetch failed: $e');
      offline = true;
      if (transactions.isEmpty) error = e.toString();
    }
    notifyListeners();
  }

  Future<List<Transaction>> _fetchTransactions() async {
    final now = DateTime.now();
    final start = isoDay(DateTime(now.year, now.month, now.day).subtract(const Duration(days: _windowDays)));
    final all = <Transaction>[];
    String? cursor;
    for (var i = 0; i < _maxPages; i++) {
      final page = await api.getTransactions(start: start, cursor: cursor);
      all.addAll(page.items);
      cursor = page.nextCursor;
      _setTransactions([...all]);
      notifyListeners();
      if (cursor == null) break;
    }
    txnCursor = cursor;
    return all;
  }

  Future<void> loadOlder() async {
    if (_loadingOlder || txnCursor == null) return;
    _loadingOlder = true;
    notifyListeners();
    try {
      final now = DateTime.now();
      final start = isoDay(DateTime(now.year, now.month, now.day).subtract(const Duration(days: _windowDays)));
      final page = await api.getTransactions(start: start, cursor: txnCursor);
      transactions = [...transactions, ...page.items];
      _recomputeAll();
      cacheTransactions(page.items);
      txnCursor = page.nextCursor;
    } catch (e) {
      debugPrint('AppState.loadOlder: failed: $e');
    } finally {
      _loadingOlder = false;
      notifyListeners();
    }
  }

  void _setTransactions(List<Transaction> v) {
    transactions = v;
    _recomputeAll();
  }

  void _recomputeAll() {
    _fillCatCache();
    _recomputeSpendByGroup();
    _recomputeStats();
  }

  void _fillCatCache() {
    _catCache = {for (final t in transactions) t.id: AutoCategorizer.categorize(t)};
  }

  void _recomputeSpendByGroup() {
    final totals = <String, double>{};
    for (final tx in transactions) {
      if (tx.amount >= 0) continue;
      final group = categoryGroupFor(tx) ?? 'Uncategorised';
      totals[group] = (totals[group] ?? 0) + tx.amount.abs().toDouble();
    }
    final entries = totals.entries.toList()
      ..sort((a, b) {
        final byValue = b.value.compareTo(a.value);
        return byValue != 0 ? byValue : a.key.compareTo(b.key);
      });
    _spendByGroupMemo = Map.fromEntries(entries.take(6));
    _spendByGroupSrc = transactions;
  }

  Map<String, double> get spendByGroup {
    if (!identical(_spendByGroupSrc, transactions)) _recomputeSpendByGroup();
    return _spendByGroupMemo;
  }

  void _recomputeStats() {
    final months = _lastMonths(_monthCount);
    aggMonthly = _computeMonthlyTotals(transactions, months);
    aggCategories = _computeCategoryTotals(transactions);
    aggWeekly = _computeWeeklyTrend(transactions, _windowDays);
    aggMerchants = _computeTopMerchants(transactions, 5);
  }

  List<_MonthKey> _lastMonths(int count) {
    final now = DateTime.now();
    return [
      for (var i = count - 1; i >= 0; i--)
        _MonthKey.from(DateTime(now.year, now.month - i, 1)),
    ];
  }

  List<MonthTotal> _computeMonthlyTotals(List<Transaction> txns, List<_MonthKey> months) {
    final byKey = {for (final m in months) m.key: (income: 0.0, expense: 0.0)};
    for (final tx in txns) {
      final d = parseDate(tx.date);
      if (d == null) continue;
      final key = _MonthKey.from(DateTime(d.year, d.month, 1)).key;
      final cur = byKey[key];
      if (cur == null) continue;
      if (tx.amount >= 0) {
        byKey[key] = (income: cur.income + tx.amount, expense: cur.expense);
      } else {
        byKey[key] = (income: cur.income, expense: cur.expense + tx.amount.abs());
      }
    }
    return [
      for (final m in months)
        MonthTotal(label: m.label, income: byKey[m.key]!.income, expense: byKey[m.key]!.expense),
    ];
  }

  List<CategoryTotal> _computeCategoryTotals(List<Transaction> txns) {
    final totals = <String, double>{};
    for (final tx in txns) {
      if (tx.amount >= 0) continue;
      final group = categoryGroupFor(tx) ?? 'Uncategorised';
      totals[group] = (totals[group] ?? 0) + tx.amount.abs().toDouble();
    }
    final entries = totals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return [for (final e in entries) CategoryTotal(name: e.key, amount: e.value)];
  }

  List<WeekTotal> _computeWeeklyTrend(List<Transaction> txns, int rangeDays) {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day).subtract(Duration(days: rangeDays));
    final byWeek = <DateTime, double>{};
    for (final tx in txns) {
      if (tx.amount >= 0) continue;
      final d = parseDate(tx.date);
      if (d == null) continue;
      final day = DateTime(d.year, d.month, d.day);
      if (day.isBefore(start)) continue;
      final weekStart = day.subtract(Duration(days: day.weekday - 1));
      byWeek[weekStart] = (byWeek[weekStart] ?? 0) + tx.amount.abs().toDouble();
    }
    final keys = byWeek.keys.toList()..sort();
    return [
      for (final k in keys) WeekTotal(label: DateFormat('d MMM').format(k), total: byWeek[k]!),
    ];
  }

  List<MerchantTotal> _computeTopMerchants(List<Transaction> txns, int count) {
    final totals = <String, double>{};
    for (final tx in txns) {
      if (tx.amount >= 0) continue;
      final name = tx.merchant?.name ?? tx.description;
      if (name.isEmpty) continue;
      totals[name] = (totals[name] ?? 0) + tx.amount.abs().toDouble();
    }
    final entries = totals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return [
      for (final e in entries.take(count)) MerchantTotal(name: e.key, amount: e.value),
    ];
  }

  Account? accountById(String id) {
    for (final a in accounts) {
      if (a.id == id) return a;
    }
    return null;
  }

  Future<void> reloadAccounts() async {
    refreshing = true;
    notifyListeners();
    try {
      accounts = await api.getAccounts();
      error = null;
      refreshing = false;
      offline = false;
      unawaited(db.saveAccounts({for (final a in accounts) a.id: json.encode(a.toJson())}));
    } catch (e) {
      refreshing = false;
      error = e.toString();
    }
    notifyListeners();
  }

  void cacheTransactions(List<Transaction> txns) {
    unawaited(db.saveTransactions([
      for (final t in txns)
        (id: t.id, accountId: t.account, json: json.encode(t.toJson())),
    ]));
  }

  Future<List<Transaction>> loadCachedTransactions({String? accountId, int limit = 200}) async {
    final rows = await db.loadTransactionsJson(accountId: accountId, limit: limit);
    final result = rows
        .map((s) => Transaction.fromJson(json.decode(s) as Map<String, dynamic>))
        .toList();
    result.sort((a, b) => (parseDate(b.date) ?? DateTime(0)).compareTo(parseDate(a.date) ?? DateTime(0)));
    return result;
  }

  String? categoryNameFor(Transaction t) =>
      _categoryOverrides[t.id]?.categoryName ??
      t.category?.name ??
      _catCache[t.id]?.name;

  String? categoryGroupFor(Transaction t) {
    final override = _categoryOverrides[t.id];
    if (override != null) {
      return AutoCategorizer.lookupGroup(override.categoryName);
    }
    return t.category?.groupName ?? _catCache[t.id]?.group;
  }

  bool isAutoCategory(Transaction t) =>
      !_categoryOverrides.containsKey(t.id) &&
      t.category == null &&
      _catCache[t.id] != null;

  bool hasOverride(String transactionId) => _categoryOverrides.containsKey(transactionId);

  Future<void> saveCategoryOverride(String txnId, String catName) async {
    await db.saveCategoryOverride(txnId, catName);
    await _loadCategoryOverrides();
  }

  Future<void> clearCategoryOverride(String transactionId) async {
    await db.clearCategoryOverride(transactionId);
    await _loadCategoryOverrides();
  }

  @override
  void dispose() {
    settings.removeListener(notifyListeners);
    api.close();
    db.close();
    super.dispose();
  }
}

class _MonthKey {
  final String key;
  final String label;
  _MonthKey(this.key, this.label);
  factory _MonthKey.from(DateTime d) {
    final key = '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}';
    return _MonthKey(key, DateFormat('MMM').format(d));
  }
}
