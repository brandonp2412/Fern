class AccountConnection {
  final String id;
  final String name;
  final String logo;
  final String? connectionType;

  AccountConnection({
    required this.id,
    required this.name,
    required this.logo,
    this.connectionType,
  });

  factory AccountConnection.fromJson(Map<String, dynamic> json) {
    return AccountConnection(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
      connectionType: json['connection_type'],
    );
  }
}

class AccountBalance {
  final String currency;
  final num? current;
  final num? available;
  final num? limit;
  final bool overdrawn;

  AccountBalance({
    this.currency = 'NZD',
    this.current,
    this.available,
    this.limit,
    this.overdrawn = false,
  });

  factory AccountBalance.fromJson(Map<String, dynamic> json) {
    return AccountBalance(
      currency: json['currency'] ?? 'NZD',
      current: json['current'] is num ? json['current'] : null,
      available: json['available'] is num ? json['available'] : null,
      limit: json['limit'] is num ? json['limit'] : null,
      overdrawn: json['overdrawn'] == true,
    );
  }
}

class AccountRefreshed {
  final String? balance;
  final String? meta;
  final String? transactions;

  AccountRefreshed({this.balance, this.meta, this.transactions});

  factory AccountRefreshed.fromJson(Map<String, dynamic> json) {
    return AccountRefreshed(
      balance: json['balance'],
      meta: json['meta'],
      transactions: json['transactions'],
    );
  }
}

class Account {
  final String id;
  final String name;
  final String status;
  final String type;
  final List<String> attributes;
  final String? formattedAccount;
  final AccountConnection? connection;
  final AccountBalance? balance;
  final String? holder;
  final AccountRefreshed? refreshed;
  final String authorisation;
  final String? migrated;

  Account({
    required this.id,
    required this.name,
    this.status = 'ACTIVE',
    required this.type,
    required this.attributes,
    this.formattedAccount,
    this.connection,
    this.balance,
    this.holder,
    this.refreshed,
    this.authorisation = '',
    this.migrated,
  });

  bool get isActive => status == 'ACTIVE';
  bool get canPayFrom => attributes.contains('PAYMENT_FROM');
  bool get canPayTo => attributes.contains('PAYMENT_TO');
  bool get hasTransactions => attributes.contains('TRANSACTIONS');

  bool get isDebt =>
      const {'CREDITCARD', 'LOAN'}.contains(type.toUpperCase());

  num? get displayBalance {
    final b = balance;
    if (b == null) return null;
    final v = b.current ?? b.available;
    if (v == null) return null;
    return isDebt && v > 0 ? -v : v;
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'status': status,
      'type': type,
      'attributes': attributes,
      'formatted_account': formattedAccount,
      '_authorisation': authorisation,
      '_migrated': migrated,
      'connection': connection == null
          ? null
          : {
              '_id': connection!.id,
              'name': connection!.name,
              'logo': connection!.logo,
              'connection_type': connection!.connectionType,
            },
      'balance': balance == null
          ? null
          : {
              'currency': balance!.currency,
              'current': balance!.current,
              'available': balance!.available,
              'limit': balance!.limit,
              'overdrawn': balance!.overdrawn,
            },
      'meta': holder == null ? null : {'holder': holder},
      'refreshed': refreshed == null
          ? null
          : {
              'balance': refreshed!.balance,
              'meta': refreshed!.meta,
              'transactions': refreshed!.transactions,
            },
    };
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    final meta = json['meta'];
    return Account(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      status: json['status'] ?? 'ACTIVE',
      type: json['type'] ?? '',
      attributes: (json['attributes'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      formattedAccount: json['formatted_account'],
      connection: json['connection'] != null
          ? AccountConnection.fromJson(json['connection'])
          : null,
      balance: json['balance'] != null
          ? AccountBalance.fromJson(json['balance'])
          : null,
      holder: meta is Map<String, dynamic> ? meta['holder'] : null,
      refreshed: json['refreshed'] != null
          ? AccountRefreshed.fromJson(json['refreshed'])
          : null,
      authorisation: json['_authorisation'] ?? '',
      migrated: json['_migrated'],
    );
  }
}
