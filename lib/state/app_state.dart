import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import '../db/app_database.dart';
import '../models/account.dart';
import '../models/category.dart';
import '../models/transaction.dart';
import '../models/user.dart';
import '../services/akahu_api.dart';
import 'app_settings.dart';

class AppState extends ChangeNotifier {
  final AkahuApi api;
  final AppSettings settings;
  final AppDatabase db = AppDatabase();

  User? user;
  List<Account> accounts = [];
  bool loading = true;
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
    try {
      final results = await Future.wait([api.getMe(), api.getAccounts()]);
      user = results[0] as User;
      accounts = results[1] as List<Account>;
      loading = false;
      offline = false;
      unawaited(db.saveAccounts({for (final a in accounts) a.id: json.encode(a.toJson())}));
    } catch (e) {
      final cached = await db.loadAccountsJson();
      if (cached.isNotEmpty) {
        accounts = cached
            .map((s) => Account.fromJson(json.decode(s) as Map<String, dynamic>))
            .toList();
        offline = true;
        error = null;
      } else {
        error = e.toString();
      }
      loading = false;
    }
    notifyListeners();
  }

  Future<void> reloadAccounts() async {
    try {
      accounts = await api.getAccounts();
      error = null;
      offline = false;
      unawaited(db.saveAccounts({for (final a in accounts) a.id: json.encode(a.toJson())}));
    } catch (e) {
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

  /// The category name to display for a transaction, applying any manual
  /// override the user has set (since Akahu has no direct write endpoint).
  String? categoryNameFor(Transaction t) =>
      _categoryOverrides[t.id]?.categoryName ?? t.category?.name;

  String? categoryGroupFor(Transaction t) =>
      _categoryOverrides.containsKey(t.id) ? null : t.category?.groupName;

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
