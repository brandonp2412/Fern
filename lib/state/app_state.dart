import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import '../db/app_database.dart';
import '../models/account.dart';
import '../models/category.dart';
import '../models/transaction.dart';
import '../models/user.dart';
import '../services/akahu_api.dart';
import '../services/auto_categorizer.dart';
import 'app_settings.dart';

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

  Map<String, CategoryOverride> _categoryOverrides = {};

  AppState(this.api, this.settings) {
    settings.addListener(notifyListeners);
    _loadCategoryOverrides();
  }

  Future<void> _loadCategoryOverrides() async {
    _categoryOverrides = await db.loadCategoryOverrides();
    notifyListeners();
  }

  /// Accounts respecting the "show/hide debt" setting.
  List<Account> get visibleAccounts =>
      settings.showDebt ? accounts : accounts.where((a) => !a.isDebt).toList();

  num get totalBalance {
    num sum = 0;
    for (final a in visibleAccounts) {
      sum += a.displayBalance ?? 0;
    }
    return sum;
  }

  Future<void> bootstrap() async {
    loading = true;
    error = null;
    notifyListeners();

    if (accounts.isEmpty) {
      final cached = await db.loadAccountsJson();
      if (cached.isNotEmpty) {
        accounts = cached
            .map((s) => Account.fromJson(json.decode(s) as Map<String, dynamic>))
            .toList();
        loading = false;
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
      unawaited(db.saveAccounts({for (final a in accounts) a.id: json.encode(a.toJson())}));
    } catch (e) {
      refreshing = false;
      if (accounts.isEmpty) {
        error = e.toString();
        loading = false;
      }
    }
    notifyListeners();
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

  Future<void> requestRefresh() async {
    await api.refreshAll();
    await Future.delayed(const Duration(seconds: 6));
    await reloadAccounts();
  }

  Account? accountById(String id) {
    for (final a in accounts) {
      if (a.id == id) return a;
    }
    return null;
  }

  /// Persists a batch of freshly-fetched transactions to the offline cache.
  void cacheTransactions(List<Transaction> transactions) {
    unawaited(db.saveTransactions([
      for (final t in transactions)
        (id: t.id, accountId: t.account, json: json.encode(t.toJson())),
    ]));
  }

  Future<List<Transaction>> loadCachedTransactions({String? accountId, int limit = 200}) async {
    final rows = await db.loadTransactionsJson(accountId: accountId, limit: limit);
    return rows
        .map((s) => Transaction.fromJson(json.decode(s) as Map<String, dynamic>))
        .toList();
  }

  /// The category name to display for a transaction, applying any manual
  /// override the user has set (since Akahu has no direct write endpoint),
  /// then falling back to a local heuristic guess if Akahu left it blank.
  String? categoryNameFor(Transaction t) =>
      _categoryOverrides[t.id]?.categoryName ??
      t.category?.name ??
      AutoCategorizer.categorize(t)?.name;

  String? categoryGroupFor(Transaction t) {
    if (_categoryOverrides.containsKey(t.id)) return null;
    return t.category?.groupName ?? AutoCategorizer.categorize(t)?.group;
  }

  /// True when the displayed category is fern's own guess rather than one
  /// sourced from Akahu or confirmed by the user.
  bool isAutoCategory(Transaction t) =>
      !_categoryOverrides.containsKey(t.id) &&
      t.category == null &&
      AutoCategorizer.categorize(t) != null;

  bool hasOverride(String transactionId) => _categoryOverrides.containsKey(transactionId);

  Future<void> setCategoryOverride(String transactionId, NzfccCategory category) async {
    await db.setCategoryOverride(transactionId, category.id, category.name);
    await _loadCategoryOverrides();
  }

  Future<void> clearCategoryOverride(String transactionId) async {
    await db.clearCategoryOverride(transactionId);
    await _loadCategoryOverrides();
  }

  @override
  void dispose() {
    settings.removeListener(notifyListeners);
    db.close();
    super.dispose();
  }
}
