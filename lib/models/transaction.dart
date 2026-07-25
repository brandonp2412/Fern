class TransactionMerchant {
  final String? name;
  final String? website;

  TransactionMerchant({this.name, this.website});

  factory TransactionMerchant.fromJson(Map<String, dynamic> json) {
    return TransactionMerchant(
      name: json['name'],
      website: json['website'],
    );
  }
}

class TransactionCategory {
  final String id;
  final String name;

  TransactionCategory({required this.id, required this.name});

  factory TransactionCategory.fromJson(Map<String, dynamic> json) {
    return TransactionCategory(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class Transaction {
  final String id;
  final String account;
  final String date;
  final String description;
  final num amount;
  final num? balance;
  final String type;
  final TransactionMerchant? merchant;
  final TransactionCategory? category;

  Transaction({
    required this.id,
    required this.account,
    required this.date,
    required this.description,
    required this.amount,
    this.balance,
    required this.type,
    this.merchant,
    this.category,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['_id'] ?? '',
      account: json['_account'] ?? '',
      date: json['date'] ?? '',
      description: json['description'] ?? '',
      amount: json['amount'] is num ? json['amount'] : 0,
      balance: json['balance'] is num ? json['balance'] : null,
      type: json['type'] ?? '',
      merchant: json['merchant'] != null
          ? TransactionMerchant.fromJson(json['merchant'])
          : null,
      category: json['category'] != null
          ? TransactionCategory.fromJson(json['category'])
          : null,
    );
  }
}
