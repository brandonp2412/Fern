class AccountConnection {
  final String id;
  final String name;
  final String logo;

  AccountConnection({
    required this.id,
    required this.name,
    required this.logo,
  });

  factory AccountConnection.fromJson(Map<String, dynamic> json) {
    return AccountConnection(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
    );
  }
}

class AccountBalance {
  final num? current;
  final num? available;
  final num? limit;

  AccountBalance({this.current, this.available, this.limit});

  factory AccountBalance.fromJson(Map<String, dynamic> json) {
    return AccountBalance(
      current: json['current'] is num ? json['current'] : null,
      available: json['available'] is num ? json['available'] : null,
      limit: json['limit'] is num ? json['limit'] : null,
    );
  }
}

class Account {
  final String id;
  final String name;
  final String? status;
  final String type;
  final List<String> attributes;
  final String? formattedAccount;
  final AccountConnection? connection;
  final AccountBalance? balance;

  Account({
    required this.id,
    required this.name,
    this.status,
    required this.type,
    required this.attributes,
    this.formattedAccount,
    this.connection,
    this.balance,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      status: json['status'],
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
    );
  }
}
