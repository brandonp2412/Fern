class TransactionMerchant {
  final String? id;
  final String? name;
  final String? website;

  TransactionMerchant({this.id, this.name, this.website});

  factory TransactionMerchant.fromJson(Map<String, dynamic> json) {
    return TransactionMerchant(
      id: json['_id'],
      name: json['name'],
      website: json['website'],
    );
  }
}

class CategoryGroup {
  final String id;
  final String name;

  CategoryGroup({required this.id, required this.name});

  factory CategoryGroup.fromJson(Map<String, dynamic> json) {
    return CategoryGroup(id: json['_id'] ?? '', name: json['name'] ?? '');
  }
}

class TransactionCategory {
  final String id;
  final String name;
  final Map<String, CategoryGroup> groups;

  TransactionCategory({required this.id, required this.name, this.groups = const {}});

  String? get groupName => groups['personal_finance']?.name ??
      (groups.isNotEmpty ? groups.values.first.name : null);

  factory TransactionCategory.fromJson(Map<String, dynamic> json) {
    final rawGroups = json['groups'];
    final groups = <String, CategoryGroup>{};
    if (rawGroups is Map<String, dynamic>) {
      for (final e in rawGroups.entries) {
        if (e.value is Map<String, dynamic>) {
          groups[e.key] = CategoryGroup.fromJson(e.value);
        }
      }
    }
    return TransactionCategory(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      groups: groups,
    );
  }
}

class CurrencyConversion {
  final num? amount;
  final String? currency;
  final num? rate;

  CurrencyConversion({this.amount, this.currency, this.rate});

  factory CurrencyConversion.fromJson(Map<String, dynamic> json) {
    return CurrencyConversion(
      amount: json['amount'] is num ? json['amount'] : null,
      currency: json['currency'],
      rate: json['rate'] is num ? json['rate'] : null,
    );
  }
}

class TransactionMeta {
  final String? particulars;
  final String? code;
  final String? reference;
  final String? otherAccount;
  final CurrencyConversion? conversion;
  final String? cardSuffix;
  final String? logo;

  TransactionMeta({
    this.particulars,
    this.code,
    this.reference,
    this.otherAccount,
    this.conversion,
    this.cardSuffix,
    this.logo,
  });

  factory TransactionMeta.fromJson(Map<String, dynamic> json) {
    return TransactionMeta(
      particulars: json['particulars'],
      code: json['code'],
      reference: json['reference'],
      otherAccount: json['other_account'],
      conversion: json['conversion'] != null
          ? CurrencyConversion.fromJson(json['conversion'])
          : null,
      cardSuffix: json['card_suffix']?.toString(),
      logo: json['logo'],
    );
  }
}

class Transaction {
  final String id;
  final String account;
  final String connection;
  final String date;
  final String description;
  final num amount;
  final num? balance;
  final String type;
  final String? createdAt;
  final String? updatedAt;
  final TransactionMerchant? merchant;
  final TransactionCategory? category;
  final TransactionMeta? meta;
  final String? autoCategoryName;
  final String? autoCategoryGroup;

  Transaction({
    required this.id,
    required this.account,
    this.connection = '',
    required this.date,
    required this.description,
    required this.amount,
    this.balance,
    required this.type,
    this.createdAt,
    this.updatedAt,
    this.merchant,
    this.category,
    this.meta,
    this.autoCategoryName,
    this.autoCategoryGroup,
  });

  String get title => merchant?.name ?? (description.isNotEmpty ? description : type);

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      '_account': account,
      '_connection': connection,
      'date': date,
      'description': description,
      'amount': amount,
      'balance': balance,
      'type': type,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'merchant': merchant == null
          ? null
          : {
              '_id': merchant!.id,
              'name': merchant!.name,
              'website': merchant!.website,
            },
      'category': category == null
          ? null
          : {
              '_id': category!.id,
              'name': category!.name,
              'groups': {
                for (final e in category!.groups.entries)
                  e.key: {'_id': e.value.id, 'name': e.value.name},
              },
            },
      'meta': meta == null
          ? null
          : {
              'particulars': meta!.particulars,
              'code': meta!.code,
              'reference': meta!.reference,
              'other_account': meta!.otherAccount,
              'conversion': meta!.conversion == null
                  ? null
                  : {
                      'amount': meta!.conversion!.amount,
                      'currency': meta!.conversion!.currency,
                      'rate': meta!.conversion!.rate,
                    },
              'card_suffix': meta!.cardSuffix,
              'logo': meta!.logo,
            },
    };
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['_id'] ?? '',
      account: json['_account'] ?? '',
      connection: json['_connection'] ?? '',
      date: json['date'] ?? '',
      description: json['description'] ?? '',
      amount: json['amount'] is num ? json['amount'] : 0,
      balance: json['balance'] is num ? json['balance'] : null,
      type: json['type'] ?? '',
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      merchant: json['merchant'] != null
          ? TransactionMerchant.fromJson(json['merchant'])
          : null,
      category: json['category'] != null
          ? TransactionCategory.fromJson(json['category'])
          : null,
      meta: json['meta'] != null ? TransactionMeta.fromJson(json['meta']) : null,
    );
  }
}

class PendingTransaction {
  final String account;
  final String connection;
  final String date;
  final String description;
  final num amount;
  final String type;
  final TransactionMeta? meta;

  PendingTransaction({
    required this.account,
    this.connection = '',
    required this.date,
    required this.description,
    required this.amount,
    required this.type,
    this.meta,
  });

  factory PendingTransaction.fromJson(Map<String, dynamic> json) {
    return PendingTransaction(
      account: json['_account'] ?? '',
      connection: json['_connection'] ?? '',
      date: json['date'] ?? '',
      description: json['description'] ?? '',
      amount: json['amount'] is num ? json['amount'] : 0,
      type: json['type'] ?? '',
      meta: json['meta'] != null ? TransactionMeta.fromJson(json['meta']) : null,
    );
  }
}
