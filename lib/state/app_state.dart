import 'dart:async';

import 'package:flutter/foundation.dart';
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
  const MonthTotal({
    required this.label,
    required this.income,
    required this.expense,
  });
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
  final AkahuClient api;
  final AppSettings settings;
  final AppDatabase db;

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
  bool get loadingOlder => _loadingOlder;
  bool _accountsLoaded = false;
  bool _transactionsLoaded = false;
  int _txnLimit = 2000;

  static const _windowDays = 182;
  static const _maxPages = 1;
  static const _staleAfter = Duration(minutes: 2);

  Map<String, CategoryOverride> _categoryOverrides = {};
  List<CategoryRule> categoryRules = [];
  List<ImageRule> imageRules = [];

  StreamSubscription<List<Account>>? _accountsSub;
  StreamSubscription<List<Transaction>>? _txnsSub;

  AppState(this.api, this.settings, {AppDatabase? db})
    : db = db ?? AppDatabase() {
    settings.addListener(notifyListeners);
    _loadCategoryOverrides();
    _loadCategoryRules();
    _loadImageRules();
    _accountsSub = this.db.watchAccounts().listen(_onAccountsRows);
    _subscribeTransactions();
  }

  Future<void> _loadCategoryOverrides() async {
    final rows = await db.loadCategoryOverrides();
    final map = <String, CategoryOverride>{};
    for (final o in rows.values) {
      if (o.categoryGroup == null) {
        final group =
            AutoCategorizer.lookupGroup(o.categoryName) ?? o.categoryName;
        map[o.transactionId] = CategoryOverride(
          transactionId: o.transactionId,
          categoryName: o.categoryName,
          categoryGroup: group,
          updatedAt: o.updatedAt,
        );
      } else {
        map[o.transactionId] = o;
      }
    }
    _categoryOverrides = map;
    notifyListeners();
  }

  Future<void> _loadCategoryRules() async {
    categoryRules = await db.loadCategoryRules();
    notifyListeners();
  }

  Future<void> _loadImageRules() async {
    imageRules = await db.loadImageRules();
    notifyListeners();
  }

  static String _hay(Transaction t) => [
    t.merchant?.name,
    t.description,
  ].where((s) => s != null && s.isNotEmpty).join(' ').toLowerCase();

  String matchTextFor(Transaction t) => _hay(t);

  String? imagePathFor(Transaction t) {
    final hay = _hay(t);
    ImageRule? contains;
    for (final rule in imageRules) {
      final needle = rule.matchText.toLowerCase();
      if (rule.exact) {
        if (hay == needle) return rule.imagePath;
      } else if (contains == null && hay.contains(needle)) {
        contains = rule;
      }
    }
    return contains?.imagePath;
  }

  Future<void> saveTransactionImage(
    Transaction tx,
    String imagePath, {
    required bool exact,
    String? matchText,
  }) async {
    final text = (matchText ?? _hay(tx)).trim();
    if (text.isEmpty) return;
    await db.saveImageRule(text, exact, imagePath);
    await _loadImageRules();
  }

  Future<void> clearTransactionImage(Transaction tx) async {
    final hay = _hay(tx);
    final matches = imageRules.where(
      (r) => r.exact
          ? hay == r.matchText.toLowerCase()
          : hay.contains(r.matchText.toLowerCase()),
    );
    for (final r in matches) {
      await db.deleteImageRule(r.id);
    }
    await _loadImageRules();
  }

  CategoryRule? _matchingRule(Transaction t) {
    if (categoryRules.isEmpty) return null;
    final hay = _hay(t);
    for (final rule in categoryRules) {
      if (hay.contains(rule.matchText.toLowerCase())) return rule;
    }
    return null;
  }

  void _onAccountsRows(List<Account> rows) {
    accounts = rows;
    _accountsLoaded = true;
    if (_transactionsLoaded) loading = false;
    notifyListeners();
  }

  void _subscribeTransactions() {
    unawaited(_txnsSub?.cancel());
    _txnsSub = db
        .watchTransactions(limit: _txnLimit)
        .listen(_onTransactionsRows);
  }

  void _onTransactionsRows(List<Transaction> rows) {
    transactions = rows;
    _transactionsLoaded = true;
    if (_accountsLoaded) loading = false;
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

    if (!force &&
        lastSync != null &&
        DateTime.now().difference(lastSync!) < _staleAfter) {
      return;
    }

    _inFlight = _run(manual: force);
    try {
      await _inFlight!;
    } finally {
      _inFlight = null;
    }
  }

  Future<void> _run({bool manual = false}) async {
    if (manual) refreshing = true;
    notifyListeners();
    try {
      final results = await Future.wait([api.getMe(), api.getAccounts()]);
      user = results[0] as User;
      final fetchedAccounts = results[1] as List<Account>;
      offline = false;
      error = null;
      lastSync = DateTime.now();
      await db.saveAccounts(fetchedAccounts);
    } catch (e) {
      refreshing = false;
      offline = true;
      if (transactions.isEmpty) {
        error = e.toString();
      }
      notifyListeners();
      return;
    }

    try {
      await _fetchTransactions();
    } catch (e) {
      debugPrint('AppState.load: transaction fetch failed: $e');
      offline = true;
      if (transactions.isEmpty) error = e.toString();
    }
    refreshing = false;
    notifyListeners();
  }

  Future<void> _fetchTransactions() async {
    final now = DateTime.now();
    final start = isoDay(
      DateTime(
        now.year,
        now.month,
        now.day,
      ).subtract(const Duration(days: _windowDays)),
    );
    String? cursor;
    for (var i = 0; i < _maxPages; i++) {
      final page = await api.getTransactions(start: start, cursor: cursor);
      await cacheTransactions(page.items);
      _txnLimit += page.items.length;
      cursor = page.nextCursor;
      if (cursor == null) break;
    }
    txnCursor = cursor;
    _subscribeTransactions();
  }

  DateTime? get oldestTxnDate {
    if (transactions.isEmpty) return null;
    return transactions
        .map((t) => DateTime.parse(t.date))
        .reduce((a, b) => a.isBefore(b) ? a : b);
  }

  Future<void> ensureDataSince(DateTime start) async {
    if (_loadingOlder) return;
    final oldest = oldestTxnDate;
    if (oldest != null && oldest.isBefore(start)) return;
    var prevCursor = txnCursor;
    for (var i = 0; i < 20; i++) {
      await loadOlder();
      final cur = oldestTxnDate;
      if (cur != null && cur.isBefore(start)) break;
      if (txnCursor == null || txnCursor == prevCursor) break;
      prevCursor = txnCursor;
    }
  }

  Future<void> loadOlder() async {
    if (_loadingOlder || txnCursor == null) return;
    _loadingOlder = true;
    notifyListeners();
    try {
      final now = DateTime.now();
      final start = isoDay(
        DateTime(
          now.year,
          now.month,
          now.day,
        ).subtract(const Duration(days: _windowDays)),
      );
      final page = await api.getTransactions(start: start, cursor: txnCursor);
      await cacheTransactions(page.items);
      _txnLimit += page.items.length;
      txnCursor = page.nextCursor;
      _subscribeTransactions();
    } catch (e) {
      debugPrint('AppState.loadOlder: failed: $e');
    } finally {
      _loadingOlder = false;
      notifyListeners();
    }
  }

  Future<void> cacheTransactions(List<Transaction> txns) async {
    await db.saveTransactions(txns);
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
      final fetched = await api.getAccounts();
      error = null;
      offline = false;
      await db.saveAccounts(fetched);
    } catch (e) {
      error = e.toString();
    }
    refreshing = false;
    notifyListeners();
  }

  String? categoryNameFor(Transaction t) =>
      _categoryOverrides[t.id]?.categoryName ??
      _matchingRule(t)?.categoryName ??
      t.category?.name ??
      t.autoCategoryName;

  String? categoryGroupFor(Transaction t) {
    final override = _categoryOverrides[t.id];
    if (override != null) {
      return override.categoryGroup ??
          AutoCategorizer.lookupGroup(override.categoryName) ??
          override.categoryName;
    }
    final rule = _matchingRule(t);
    if (rule != null) {
      return rule.categoryGroup ??
          AutoCategorizer.lookupGroup(rule.categoryName) ??
          rule.categoryName;
    }
    return t.category?.groupName ?? t.autoCategoryGroup;
  }

  bool isAutoCategory(Transaction t) =>
      !_categoryOverrides.containsKey(t.id) &&
      _matchingRule(t) == null &&
      t.category == null &&
      t.autoCategoryName != null;

  bool hasOverride(String transactionId) =>
      _categoryOverrides.containsKey(transactionId);

  Future<void> saveCategoryOverride(
    String txnId,
    String catName, {
    bool applyToFuture = false,
    String? matchText,
  }) async {
    final group = AutoCategorizer.lookupGroup(catName) ?? catName;
    await db.saveCategoryOverride(txnId, catName, group);
    await _loadCategoryOverrides();
    if (applyToFuture && matchText != null && matchText.trim().isNotEmpty) {
      await db.saveCategoryRule(matchText.trim(), catName, group);
      await _loadCategoryRules();
    }
  }

  Future<void> saveCategoryOverrides(
    List<String> txnIds,
    String catName,
  ) async {
    final group = AutoCategorizer.lookupGroup(catName) ?? catName;
    await db.saveCategoryOverrides(txnIds, catName, group);
    await _loadCategoryOverrides();
  }

  Future<void> deleteCategoryRule(String id) async {
    await db.deleteCategoryRule(id);
    await _loadCategoryRules();
  }

  Future<void> clearCategoryOverride(String transactionId) async {
    await db.clearCategoryOverride(transactionId);
    await _loadCategoryOverrides();
  }

  @override
  void dispose() {
    settings.removeListener(notifyListeners);
    unawaited(_accountsSub?.cancel());
    unawaited(_txnsSub?.cancel());
    api.close();
    db.close();
    super.dispose();
  }
}
