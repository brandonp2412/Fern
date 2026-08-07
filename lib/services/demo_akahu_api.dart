import '../models/account.dart';
import '../models/page.dart';
import '../models/transaction.dart';
import '../models/user.dart';
import 'akahu_api.dart';

/// Local sample data for store reviewers and people evaluating Fern.
/// No credentials are used and no network requests are made.
class DemoAkahuApi implements AkahuClient {
  static final List<Account> _accounts = [
    Account.fromJson({
      '_id': 'demo_everyday',
      '_authorisation': 'demo',
      'name': 'Everyday',
      'status': 'ACTIVE',
      'type': 'CHECKING',
      'attributes': ['TRANSACTIONS'],
      'formatted_account': '00-0000-0000000-00',
      'connection': {'_id': 'demo_bank', 'name': 'Fern Demo Bank', 'logo': ''},
      'balance': {'currency': 'NZD', 'current': 2847.63, 'available': 2847.63},
    }),
    Account.fromJson({
      '_id': 'demo_savings',
      '_authorisation': 'demo',
      'name': 'Rainy Day Savings',
      'status': 'ACTIVE',
      'type': 'SAVINGS',
      'attributes': ['TRANSACTIONS'],
      'formatted_account': '00-0000-0000001-00',
      'connection': {'_id': 'demo_bank', 'name': 'Fern Demo Bank', 'logo': ''},
      'balance': {
        'currency': 'NZD',
        'current': 12450.00,
        'available': 12450.00,
      },
    }),
    Account.fromJson({
      '_id': 'demo_credit',
      '_authorisation': 'demo',
      'name': 'Rewards Card',
      'status': 'ACTIVE',
      'type': 'CREDITCARD',
      'attributes': ['TRANSACTIONS'],
      'formatted_account': '0000 0000 0000 0000',
      'connection': {'_id': 'demo_bank', 'name': 'Fern Demo Bank', 'logo': ''},
      'balance': {
        'currency': 'NZD',
        'current': 386.42,
        'available': 4613.58,
        'limit': 5000.00,
      },
    }),
  ];

  static String _date(int daysAgo) => DateTime.now()
      .subtract(Duration(days: daysAgo))
      .toUtc()
      .toIso8601String();

  static Transaction _transaction({
    required String id,
    required String account,
    required int daysAgo,
    required String description,
    required num amount,
    required String merchant,
    required String category,
    required String group,
    String type = 'EFTPOS',
  }) {
    final date = _date(daysAgo);
    return Transaction.fromJson({
      '_id': id,
      '_account': account,
      '_connection': 'demo_bank',
      '_user': 'demo_user',
      'date': date,
      'description': description,
      'amount': amount,
      'type': type,
      'created_at': date,
      'updated_at': date,
      'merchant': {'_id': 'merchant_$id', 'name': merchant},
      'category': {
        '_id': 'category_$id',
        'name': category,
        'groups': {
          'personal_finance': {'_id': 'group_$id', 'name': group},
        },
      },
    });
  }

  static List<Transaction> get _transactions => [
    _transaction(
      id: 'demo_groceries',
      account: 'demo_everyday',
      daysAgo: 1,
      description: 'FRESH MARKET',
      amount: -84.70,
      merchant: 'Fresh Market',
      category: 'Groceries',
      group: 'Food and drink',
    ),
    _transaction(
      id: 'demo_salary',
      account: 'demo_everyday',
      daysAgo: 3,
      description: 'FERN DEMO PAYROLL',
      amount: 3250.00,
      merchant: 'Fern Demo Ltd',
      category: 'Salary and wages',
      group: 'Income',
      type: 'DIRECT CREDIT',
    ),
    _transaction(
      id: 'demo_cafe',
      account: 'demo_credit',
      daysAgo: 4,
      description: 'HARBOUR CAFE',
      amount: -18.50,
      merchant: 'Harbour Cafe',
      category: 'Cafes and restaurants',
      group: 'Food and drink',
    ),
    _transaction(
      id: 'demo_power',
      account: 'demo_everyday',
      daysAgo: 7,
      description: 'POWER COMPANY',
      amount: -132.45,
      merchant: 'Power Company',
      category: 'Electricity',
      group: 'Housing and utilities',
      type: 'DIRECT DEBIT',
    ),
    _transaction(
      id: 'demo_transport',
      account: 'demo_credit',
      daysAgo: 11,
      description: 'CITY TRANSPORT',
      amount: -42.00,
      merchant: 'City Transport',
      category: 'Public transport',
      group: 'Transport',
    ),
    _transaction(
      id: 'demo_savings_transfer',
      account: 'demo_savings',
      daysAgo: 15,
      description: 'SAVINGS TRANSFER',
      amount: 500.00,
      merchant: 'Savings Transfer',
      category: 'Transfers',
      group: 'Transfers',
      type: 'TRANSFER',
    ),
    _transaction(
      id: 'demo_pharmacy',
      account: 'demo_everyday',
      daysAgo: 24,
      description: 'CENTRAL PHARMACY',
      amount: -36.80,
      merchant: 'Central Pharmacy',
      category: 'Pharmacies',
      group: 'Health',
    ),
  ];

  @override
  Future<User> getMe() async => User(
    id: 'demo_user',
    email: 'reviewer@example.com',
    accessGrantedAt: DateTime.now().toUtc().toIso8601String(),
  );

  @override
  Future<List<Account>> getAccounts() async => _accounts;

  @override
  Future<Account> getAccount(String id) async =>
      _accounts.firstWhere((account) => account.id == id);

  @override
  Future<Page<Transaction>> getTransactions({
    String? start,
    String? end,
    String? cursor,
  }) async => Page(items: _transactions, nextCursor: null);

  @override
  Future<Page<Transaction>> getAccountTransactions(
    String accountId, {
    String? start,
    String? end,
    String? cursor,
  }) async => Page(
    items: _transactions.where((item) => item.account == accountId).toList(),
    nextCursor: null,
  );

  @override
  Future<List<PendingTransaction>> getAccountPendingTransactions(
    String accountId,
  ) async => [];

  @override
  Future<void> deleteAuthorisation(String id) async {}

  @override
  Future<Transaction> getTransaction(String id) async =>
      _transactions.firstWhere((item) => item.id == id);

  @override
  Future<List<PendingTransaction>> getPendingTransactions() async => [];

  @override
  Future<List<Transaction>> getTransactionsByIds(List<String> ids) async =>
      _transactions.where((item) => ids.contains(item.id)).toList();

  @override
  Future<void> refreshAll() async {}

  @override
  Future<void> refresh(String id) async {}

  @override
  Future<void> revokeToken() async {}

  @override
  Future<void> reportTransaction(
    String transactionId, {
    required String type,
    String? otherId,
    List<String>? fields,
    String? comment,
  }) async {}

  @override
  void close() {}
}
