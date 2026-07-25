class PartyPhone {
  final String value;
  final String? subtype;
  final bool verified;

  PartyPhone({required this.value, this.subtype, this.verified = false});

  factory PartyPhone.fromJson(Map<String, dynamic> json) {
    return PartyPhone(
      value: json['value'] ?? '',
      subtype: json['subtype'],
      verified: json['verified'] == true,
    );
  }
}

class PartyEmail {
  final String value;
  final String? subtype;
  final bool verified;

  PartyEmail({required this.value, this.subtype, this.verified = false});

  factory PartyEmail.fromJson(Map<String, dynamic> json) {
    return PartyEmail(
      value: json['value'] ?? '',
      subtype: json['subtype'],
      verified: json['verified'] == true,
    );
  }
}

class PartyAddress {
  final String value;
  final String? formatted;
  final String? subtype;
  final bool verified;

  PartyAddress({
    required this.value,
    this.formatted,
    this.subtype,
    this.verified = false,
  });

  factory PartyAddress.fromJson(Map<String, dynamic> json) {
    return PartyAddress(
      value: json['value'] ?? '',
      formatted: json['formatted'],
      subtype: json['subtype'],
      verified: json['verified'] == true,
    );
  }
}

class Party {
  final String id;
  final String connection;
  final String authorisation;
  final String? name;
  final String? dob;
  final String? taxNumber;
  final List<PartyPhone> phones;
  final List<PartyEmail> emails;
  final List<PartyAddress> addresses;

  Party({
    required this.id,
    this.connection = '',
    this.authorisation = '',
    this.name,
    this.dob,
    this.taxNumber,
    this.phones = const [],
    this.emails = const [],
    this.addresses = const [],
  });

  factory Party.fromJson(Map<String, dynamic> json) {
    String? val(dynamic v) =>
        v is Map<String, dynamic> ? v['value']?.toString() : null;
    return Party(
      id: json['_id'] ?? '',
      connection: json['_connection'] ?? '',
      authorisation: json['_authorisation'] ?? '',
      name: val(json['name']),
      dob: val(json['dob']),
      taxNumber: val(json['tax_number']),
      phones: (json['phone_numbers'] as List<dynamic>?)
              ?.map((e) => PartyPhone.fromJson(e))
              .toList() ??
          [],
      emails: (json['email_addresses'] as List<dynamic>?)
              ?.map((e) => PartyEmail.fromJson(e))
              .toList() ??
          [],
      addresses: (json['addresses'] as List<dynamic>?)
              ?.map((e) => PartyAddress.fromJson(e))
              .toList() ??
          [],
    );
  }
}
