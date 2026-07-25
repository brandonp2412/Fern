import 'package:flutter/foundation.dart';
import '../models/account.dart';
import '../models/user.dart';
import '../services/akahu_api.dart';

class AppState extends ChangeNotifier {
  final AkahuApi api;

  User? user;
  List<Account> accounts = [];
  bool loading = true;
  String? error;

  AppState(this.api);

  num get totalBalance {
    num sum = 0;
    for (final a in accounts) {
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
    } catch (e) {
      error = e.toString();
      loading = false;
    }
    notifyListeners();
  }

  Future<void> reloadAccounts() async {
    try {
      accounts = await api.getAccounts();
      error = null;
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
}
