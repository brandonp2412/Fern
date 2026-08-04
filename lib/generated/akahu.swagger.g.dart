// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'akahu.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectionInfo _$ConnectionInfoFromJson(Map<String, dynamic> json) =>
    ConnectionInfo(
      id: json['_id'] as String,
      name: json['name'] as String,
      logo: json['logo'] as String,
      connectionType: connectionTypeFromJson(json['connection_type']),
    );

Map<String, dynamic> _$ConnectionInfoToJson(ConnectionInfo instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'connection_type': connectionTypeToJson(instance.connectionType),
    };

Connection _$ConnectionFromJson(Map<String, dynamic> json) => Connection(
  id: json['_id'] as String,
  classic: json['_classic'] as String?,
  name: json['name'] as String,
  logo: json['logo'] as String,
  connectionType: connectionTypeFromJson(json['connection_type']),
  newConnectionsEnabled: json['new_connections_enabled'] as bool,
  mode: connectionModeNullableFromJson(json['mode']),
  deadline: json['deadline'] as String?,
);

Map<String, dynamic> _$ConnectionToJson(Connection instance) =>
    <String, dynamic>{
      '_id': instance.id,
      '_classic': instance.classic,
      'name': instance.name,
      'logo': instance.logo,
      'connection_type': connectionTypeToJson(instance.connectionType),
      'new_connections_enabled': instance.newConnectionsEnabled,
      'mode': connectionModeNullableToJson(instance.mode),
      'deadline': instance.deadline,
    };

PaymentConsentPeriodicLimit _$PaymentConsentPeriodicLimitFromJson(
  Map<String, dynamic> json,
) => PaymentConsentPeriodicLimit(
  amount: (json['amount'] as num).toDouble(),
  frequency: paymentPeriodFrequencyFromJson(json['frequency']),
);

Map<String, dynamic> _$PaymentConsentPeriodicLimitToJson(
  PaymentConsentPeriodicLimit instance,
) => <String, dynamic>{
  'amount': instance.amount,
  'frequency': paymentPeriodFrequencyToJson(instance.frequency),
};

PaymentConsentPayee _$PaymentConsentPayeeFromJson(Map<String, dynamic> json) =>
    PaymentConsentPayee(
      name: json['name'] as String,
      accountNumber: json['account_number'] as String,
    );

Map<String, dynamic> _$PaymentConsentPayeeToJson(
  PaymentConsentPayee instance,
) => <String, dynamic>{
  'name': instance.name,
  'account_number': instance.accountNumber,
};

AccountPaymentConsent _$AccountPaymentConsentFromJson(
  Map<String, dynamic> json,
) => AccountPaymentConsent(
  id: json['_id'] as String,
  singleLimit: (json['single_limit'] as num).toDouble(),
  periodicLimit: PaymentConsentPeriodicLimit.fromJson(
    json['periodic_limit'] as Map<String, dynamic>,
  ),
  payees:
      (json['payees'] as List<dynamic>?)
          ?.map((e) => PaymentConsentPayee.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$AccountPaymentConsentToJson(
  AccountPaymentConsent instance,
) => <String, dynamic>{
  '_id': instance.id,
  'single_limit': instance.singleLimit,
  'periodic_limit': instance.periodicLimit.toJson(),
  'payees': instance.payees.map((e) => e.toJson()).toList(),
};

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
  id: json['_id'] as String,
  migrated: json['_migrated'] as String?,
  authorisation: json['_authorisation'] as String,
  credentials: json['_credentials'] as String?,
  connection: ConnectionInfo.fromJson(
    json['connection'] as Map<String, dynamic>,
  ),
  name: json['name'] as String,
  status: accountStatusFromJson(json['status']),
  balance: json['balance'] == null
      ? null
      : Account$Balance.fromJson(json['balance'] as Map<String, dynamic>),
  type: accountTypeFromJson(json['type']),
  attributes: accountAttributesListFromJson(json['attributes'] as List?),
  formattedAccount: json['formatted_account'] as String?,
  paymentConsents:
      (json['payment_consents'] as List<dynamic>?)
          ?.map(
            (e) => AccountPaymentConsent.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  meta: json['meta'] as Map<String, dynamic>?,
  refreshed: json['refreshed'] == null
      ? null
      : Account$Refreshed.fromJson(json['refreshed'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
  '_id': instance.id,
  '_migrated': instance.migrated,
  '_authorisation': instance.authorisation,
  '_credentials': instance.credentials,
  'connection': instance.connection.toJson(),
  'name': instance.name,
  'status': accountStatusToJson(instance.status),
  'balance': instance.balance?.toJson(),
  'type': accountTypeToJson(instance.type),
  'attributes': accountAttributesListToJson(instance.attributes),
  'formatted_account': instance.formattedAccount,
  'payment_consents': instance.paymentConsents?.map((e) => e.toJson()).toList(),
  'meta': instance.meta,
  'refreshed': instance.refreshed?.toJson(),
};

Token _$TokenFromJson(Map<String, dynamic> json) => Token(
  success: json['success'] as bool?,
  accessToken: json['access_token'] as String?,
  tokenType: json['token_type'] as String?,
  scope: json['scope'] as String?,
);

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
  'success': instance.success,
  'access_token': instance.accessToken,
  'token_type': instance.tokenType,
  'scope': instance.scope,
};

OneOffIdentityAccount _$OneOffIdentityAccountFromJson(
  Map<String, dynamic> json,
) => OneOffIdentityAccount(
  bank: json['bank'] as String?,
  accountNumber: json['account_number'] as String?,
  holder: json['holder'] as String?,
  hasUnlistedHolders: json['has_unlisted_holders'] as bool?,
);

Map<String, dynamic> _$OneOffIdentityAccountToJson(
  OneOffIdentityAccount instance,
) => <String, dynamic>{
  'bank': instance.bank,
  'account_number': instance.accountNumber,
  'holder': instance.holder,
  'has_unlisted_holders': instance.hasUnlistedHolders,
};

Identities _$IdentitiesFromJson(Map<String, dynamic> json) => Identities(
  name: json['name'] as String?,
  formattedAccount: json['formatted_account'] as String?,
  meta: json['meta'],
);

Map<String, dynamic> _$IdentitiesToJson(Identities instance) =>
    <String, dynamic>{
      'name': instance.name,
      'formatted_account': instance.formattedAccount,
      'meta': instance.meta,
    };

AddressComponents _$AddressComponentsFromJson(Map<String, dynamic> json) =>
    AddressComponents(
      street: json['street'] as String?,
      suburb: json['suburb'] as String?,
      city: json['city'] as String?,
      region: json['region'] as String?,
      postalCode: json['postal_code'] as String?,
      country: json['country'] as String?,
    );

Map<String, dynamic> _$AddressComponentsToJson(AddressComponents instance) =>
    <String, dynamic>{
      'street': instance.street,
      'suburb': instance.suburb,
      'city': instance.city,
      'region': instance.region,
      'postal_code': instance.postalCode,
      'country': instance.country,
    };

Addresses _$AddressesFromJson(Map<String, dynamic> json) => Addresses(
  type: addressTypeNullableFromJson(json['type']),
  value: json['value'] as String?,
  formattedAddress: json['formatted_address'] as String?,
  placeId: json['place_id'] as String?,
  components: json['components'] == null
      ? null
      : AddressComponents.fromJson(json['components'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AddressesToJson(Addresses instance) => <String, dynamic>{
  'type': addressTypeNullableToJson(instance.type),
  'value': instance.value,
  'formatted_address': instance.formattedAddress,
  'place_id': instance.placeId,
  'components': instance.components?.toJson(),
};

OneOffIdentity _$OneOffIdentityFromJson(Map<String, dynamic> json) =>
    OneOffIdentity(
      id: json['_id'] as String?,
      status: oneOffIdentityStatusNullableFromJson(json['status']),
      source: json['source'] == null
          ? null
          : ConnectionInfo.fromJson(json['source'] as Map<String, dynamic>),
      accounts:
          (json['accounts'] as List<dynamic>?)
              ?.map(
                (e) =>
                    OneOffIdentityAccount.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      identities:
          (json['identities'] as List<dynamic>?)
              ?.map((e) => Identities.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      addresses:
          (json['addresses'] as List<dynamic>?)
              ?.map((e) => Addresses.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$OneOffIdentityToJson(OneOffIdentity instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'status': oneOffIdentityStatusNullableToJson(instance.status),
      'source': instance.source?.toJson(),
      'accounts': instance.accounts?.map((e) => e.toJson()).toList(),
      'identities': instance.identities?.map((e) => e.toJson()).toList(),
      'addresses': instance.addresses?.map((e) => e.toJson()).toList(),
    };

VerifyNameData _$VerifyNameDataFromJson(Map<String, dynamic> json) =>
    VerifyNameData(
      givenName: json['given_name'] as String?,
      middleName: json['middle_name'] as String?,
      familyName: json['family_name'] as String,
      initials:
          (json['initials'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$VerifyNameDataToJson(VerifyNameData instance) =>
    <String, dynamic>{
      'given_name': instance.givenName,
      'middle_name': instance.middleName,
      'family_name': instance.familyName,
      'initials': instance.initials,
    };

VerifyNameMatchedComponents _$VerifyNameMatchedComponentsFromJson(
  Map<String, dynamic> json,
) => VerifyNameMatchedComponents(
  givenName: json['given_name'] as bool,
  middleName: json['middle_name'] as bool,
  familyName: json['family_name'] as bool,
  middleInitial: json['middle_initial'] as bool,
  givenInitial: json['given_initial'] as bool,
);

Map<String, dynamic> _$VerifyNameMatchedComponentsToJson(
  VerifyNameMatchedComponents instance,
) => <String, dynamic>{
  'given_name': instance.givenName,
  'middle_name': instance.middleName,
  'family_name': instance.familyName,
  'middle_initial': instance.middleInitial,
  'given_initial': instance.givenInitial,
};

VerifyNamePartySource _$VerifyNamePartySourceFromJson(
  Map<String, dynamic> json,
) => VerifyNamePartySource(
  type: verifyNamePartySourceTypeFromJson(json['type']),
  meta: VerifyNamePartySource$Meta.fromJson(
    json['meta'] as Map<String, dynamic>,
  ),
  matchResult: verifyNameMatchTypeFromJson(json['match_result']),
  verification: VerifyNameMatchedComponents.fromJson(
    json['verification'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$VerifyNamePartySourceToJson(
  VerifyNamePartySource instance,
) => <String, dynamic>{
  'type': verifyNamePartySourceTypeToJson(instance.type),
  'meta': instance.meta.toJson(),
  'match_result': verifyNameMatchTypeToJson(instance.matchResult),
  'verification': instance.verification.toJson(),
};

VerifyNameHolderSource _$VerifyNameHolderSourceFromJson(
  Map<String, dynamic> json,
) => VerifyNameHolderSource(
  type: verifyNameHolderSourceTypeFromJson(json['type']),
  meta: VerifyNameHolderSource$Meta.fromJson(
    json['meta'] as Map<String, dynamic>,
  ),
  matchResult: verifyNameMatchTypeFromJson(json['match_result']),
  verification: VerifyNameMatchedComponents.fromJson(
    json['verification'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$VerifyNameHolderSourceToJson(
  VerifyNameHolderSource instance,
) => <String, dynamic>{
  'type': verifyNameHolderSourceTypeToJson(instance.type),
  'meta': instance.meta.toJson(),
  'match_result': verifyNameMatchTypeToJson(instance.matchResult),
  'verification': instance.verification.toJson(),
};

VerifyNameSource _$VerifyNameSourceFromJson(Map<String, dynamic> json) =>
    VerifyNameSource();

Map<String, dynamic> _$VerifyNameSourceToJson(VerifyNameSource instance) =>
    <String, dynamic>{};

VerifyNameResult _$VerifyNameResultFromJson(Map<String, dynamic> json) =>
    VerifyNameResult();

Map<String, dynamic> _$VerifyNameResultToJson(VerifyNameResult instance) =>
    <String, dynamic>{};

OneOffIdentityParty _$OneOffIdentityPartyFromJson(Map<String, dynamic> json) =>
    OneOffIdentityParty(
      givenName: json['given_name'] as String?,
      middleName: json['middle_name'] as String?,
      familyName: json['family_name'] as String?,
      initials:
          (json['initials'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      prefix: json['prefix'] as String?,
      gender: oneOffIdentityPartyGenderNullableFromJson(json['gender']),
    );

Map<String, dynamic> _$OneOffIdentityPartyToJson(
  OneOffIdentityParty instance,
) => <String, dynamic>{
  'given_name': instance.givenName,
  'middle_name': instance.middleName,
  'family_name': instance.familyName,
  'initials': instance.initials,
  'prefix': instance.prefix,
  'gender': oneOffIdentityPartyGenderNullableToJson(instance.gender),
};

OneOffVerifyNamePartySource _$OneOffVerifyNamePartySourceFromJson(
  Map<String, dynamic> json,
) => OneOffVerifyNamePartySource(
  type: oneOffVerifyNamePartySourceTypeFromJson(json['type']),
  meta: OneOffIdentityParty.fromJson(json['meta'] as Map<String, dynamic>),
  matchResult: verifyNameMatchTypeFromJson(json['match_result']),
  verification: VerifyNameMatchedComponents.fromJson(
    json['verification'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$OneOffVerifyNamePartySourceToJson(
  OneOffVerifyNamePartySource instance,
) => <String, dynamic>{
  'type': oneOffVerifyNamePartySourceTypeToJson(instance.type),
  'meta': instance.meta.toJson(),
  'match_result': verifyNameMatchTypeToJson(instance.matchResult),
  'verification': instance.verification.toJson(),
};

OneOffVerifyNameHolderSource _$OneOffVerifyNameHolderSourceFromJson(
  Map<String, dynamic> json,
) => OneOffVerifyNameHolderSource(
  type: oneOffVerifyNameHolderSourceTypeFromJson(json['type']),
  meta: OneOffIdentityAccount.fromJson(json['meta'] as Map<String, dynamic>),
  matchResult: verifyNameMatchTypeFromJson(json['match_result']),
  verification: VerifyNameMatchedComponents.fromJson(
    json['verification'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$OneOffVerifyNameHolderSourceToJson(
  OneOffVerifyNameHolderSource instance,
) => <String, dynamic>{
  'type': oneOffVerifyNameHolderSourceTypeToJson(instance.type),
  'meta': instance.meta.toJson(),
  'match_result': verifyNameMatchTypeToJson(instance.matchResult),
  'verification': instance.verification.toJson(),
};

OneOffVerifyNameSource _$OneOffVerifyNameSourceFromJson(
  Map<String, dynamic> json,
) => OneOffVerifyNameSource();

Map<String, dynamic> _$OneOffVerifyNameSourceToJson(
  OneOffVerifyNameSource instance,
) => <String, dynamic>{};

OneOffVerifyNameResult _$OneOffVerifyNameResultFromJson(
  Map<String, dynamic> json,
) => OneOffVerifyNameResult();

Map<String, dynamic> _$OneOffVerifyNameResultToJson(
  OneOffVerifyNameResult instance,
) => <String, dynamic>{};

CategoryGroups _$CategoryGroupsFromJson(Map<String, dynamic> json) =>
    CategoryGroups();

Map<String, dynamic> _$CategoryGroupsToJson(CategoryGroups instance) =>
    <String, dynamic>{};

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
  id: json['_id'] as String,
  account: json['_account'] as String,
  connection: json['_connection'] as String,
  user: json['_user'] as String,
  migrated: json['_migrated'] as String?,
  migratedAccount: json['_migrated_account'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  date: DateTime.parse(json['date'] as String),
  description: json['description'] as String,
  amount: (json['amount'] as num).toDouble(),
  balance: (json['balance'] as num?)?.toDouble(),
  type: transactionTypeFromJson(json['type']),
  hash: json['hash'] as String?,
  merchant: json['merchant'] == null
      ? null
      : Transaction$Merchant.fromJson(json['merchant'] as Map<String, dynamic>),
  category: json['category'] == null
      ? null
      : Transaction$Category.fromJson(json['category'] as Map<String, dynamic>),
  meta: json['meta'] == null
      ? null
      : Transaction$Meta.fromJson(json['meta'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      '_id': instance.id,
      '_account': instance.account,
      '_connection': instance.connection,
      '_user': instance.user,
      '_migrated': instance.migrated,
      '_migrated_account': instance.migratedAccount,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'date': instance.date.toIso8601String(),
      'description': instance.description,
      'amount': instance.amount,
      'balance': instance.balance,
      'type': transactionTypeToJson(instance.type),
      'hash': instance.hash,
      'merchant': instance.merchant?.toJson(),
      'category': instance.category?.toJson(),
      'meta': instance.meta?.toJson(),
    };

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
  id: json['_id'] as String?,
  name: json['name'] as String?,
  groups: json['groups'] == null
      ? null
      : CategoryGroups.fromJson(json['groups'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  '_id': instance.id,
  'name': instance.name,
  'groups': instance.groups?.toJson(),
};

PendingTransaction _$PendingTransactionFromJson(
  Map<String, dynamic> json,
) => PendingTransaction(
  account: json['_account'] as String?,
  connection: json['_connection'] as String?,
  user: json['_user'] as String?,
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  description: json['description'] as String?,
  amount: (json['amount'] as num?)?.toDouble(),
  type: transactionTypeNullableFromJson(json['type']),
  meta: json['meta'] == null
      ? null
      : PendingTransaction$Meta.fromJson(json['meta'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PendingTransactionToJson(PendingTransaction instance) =>
    <String, dynamic>{
      '_account': instance.account,
      '_connection': instance.connection,
      '_user': instance.user,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'date': instance.date?.toIso8601String(),
      'description': instance.description,
      'amount': instance.amount,
      'type': transactionTypeNullableToJson(instance.type),
      'meta': instance.meta?.toJson(),
    };

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
  id: json['_id'] as String?,
  from: json['from'] as String?,
  to: json['to'] == null
      ? null
      : Payment$To.fromJson(json['to'] as Map<String, dynamic>),
  amount: (json['amount'] as num?)?.toDouble(),
  meta: json['meta'] == null
      ? null
      : Payment$Meta.fromJson(json['meta'] as Map<String, dynamic>),
  sid: json['sid'] as String?,
  status: paymentStatusNullableFromJson(json['status']),
  statusText: json['status_text'] as String?,
  $final: json['final'] as bool?,
  timeline: (json['timeline'] as List<dynamic>?)
      ?.map((e) => Payment$Timeline$Item.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  receivedAt: json['received_at'] == null
      ? null
      : DateTime.parse(json['received_at'] as String),
);

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
  '_id': instance.id,
  'from': instance.from,
  'to': instance.to?.toJson(),
  'amount': instance.amount,
  'meta': instance.meta?.toJson(),
  'sid': instance.sid,
  'status': paymentStatusNullableToJson(instance.status),
  'status_text': instance.statusText,
  'final': instance.$final,
  'timeline': instance.timeline?.map((e) => e.toJson()).toList(),
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'received_at': instance.receivedAt?.toIso8601String(),
};

Party _$PartyFromJson(Map<String, dynamic> json) => Party(
  id: json['_id'] as String,
  connection: json['_connection'] as String,
  user: json['_user'] as String,
  authorisation: json['_authorisation'] as String,
  type: partyTypeFromJson(json['type']),
  name: json['name'] == null
      ? null
      : Party$Name.fromJson(json['name'] as Map<String, dynamic>),
  dob: json['dob'] == null
      ? null
      : Party$Dob.fromJson(json['dob'] as Map<String, dynamic>),
  taxNumber: json['tax_number'] == null
      ? null
      : Party$TaxNumber.fromJson(json['tax_number'] as Map<String, dynamic>),
  phoneNumbers: (json['phone_numbers'] as List<dynamic>?)
      ?.map((e) => Party$PhoneNumbers$Item.fromJson(e as Map<String, dynamic>))
      .toList(),
  emailAddresses: (json['email_addresses'] as List<dynamic>?)
      ?.map(
        (e) => Party$EmailAddresses$Item.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  addresses: (json['addresses'] as List<dynamic>?)
      ?.map((e) => Party$Addresses$Item.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PartyToJson(Party instance) => <String, dynamic>{
  '_id': instance.id,
  '_connection': instance.connection,
  '_user': instance.user,
  '_authorisation': instance.authorisation,
  'type': partyTypeToJson(instance.type),
  'name': instance.name?.toJson(),
  'dob': instance.dob?.toJson(),
  'tax_number': instance.taxNumber?.toJson(),
  'phone_numbers': instance.phoneNumbers?.map((e) => e.toJson()).toList(),
  'email_addresses': instance.emailAddresses?.map((e) => e.toJson()).toList(),
  'addresses': instance.addresses?.map((e) => e.toJson()).toList(),
};

Me _$MeFromJson(Map<String, dynamic> json) => Me(
  id: json['_id'] as String?,
  accessGrantedAt: json['access_granted_at'] == null
      ? null
      : DateTime.parse(json['access_granted_at'] as String),
  email: json['email'] as String?,
);

Map<String, dynamic> _$MeToJson(Me instance) => <String, dynamic>{
  '_id': instance.id,
  'access_granted_at': instance.accessGrantedAt?.toIso8601String(),
  'email': instance.email,
};

Webhook _$WebhookFromJson(Map<String, dynamic> json) => Webhook(
  id: json['_id'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  lastCalledAt: json['last_called_at'] == null
      ? null
      : DateTime.parse(json['last_called_at'] as String),
  state: json['state'] as String?,
  url: json['url'] as String?,
);

Map<String, dynamic> _$WebhookToJson(Webhook instance) => <String, dynamic>{
  '_id': instance.id,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'last_called_at': instance.lastCalledAt?.toIso8601String(),
  'state': instance.state,
  'url': instance.url,
};

WebhookEvent _$WebhookEventFromJson(Map<String, dynamic> json) => WebhookEvent(
  id: json['_id'] as String?,
  hook: json['hook'] as String?,
  status: webhookEventStatusNullableFromJson(json['status']),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  lastFailedAt: json['last_failed_at'] == null
      ? null
      : DateTime.parse(json['last_failed_at'] as String),
  payload: json['payload'] == null
      ? null
      : WebhookEvent$Payload.fromJson(json['payload'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WebhookEventToJson(WebhookEvent instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'hook': instance.hook,
      'status': webhookEventStatusNullableToJson(instance.status),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'last_failed_at': instance.lastFailedAt?.toIso8601String(),
      'payload': instance.payload?.toJson(),
    };

AuthorisationRequestSuccessResponse
_$AuthorisationRequestSuccessResponseFromJson(Map<String, dynamic> json) =>
    AuthorisationRequestSuccessResponse(
      success: json['success'] as bool,
      requestUri: json['request_uri'] as String,
      authorisationUrl: json['authorisation_url'] as String,
      expiresIn: (json['expires_in'] as num).toDouble(),
    );

Map<String, dynamic> _$AuthorisationRequestSuccessResponseToJson(
  AuthorisationRequestSuccessResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'request_uri': instance.requestUri,
  'authorisation_url': instance.authorisationUrl,
  'expires_in': instance.expiresIn,
};

CreateAuthorisationRequestInvalidRequestResponse
_$CreateAuthorisationRequestInvalidRequestResponseFromJson(
  Map<String, dynamic> json,
) => CreateAuthorisationRequestInvalidRequestResponse(
  success: json['success'] as bool,
  error: oAuth400ErrorCodeFromJson(json['error']),
  errorDescription: json['error_description'] as String,
  issues: (json['issues'] as List<dynamic>?)
      ?.map(
        (e) =>
            CreateAuthorisationRequestInvalidRequestResponse$Issues$Item.fromJson(
              e as Map<String, dynamic>,
            ),
      )
      .toList(),
);

Map<String, dynamic> _$CreateAuthorisationRequestInvalidRequestResponseToJson(
  CreateAuthorisationRequestInvalidRequestResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'error': oAuth400ErrorCodeToJson(instance.error),
  'error_description': instance.errorDescription,
  'issues': instance.issues?.map((e) => e.toJson()).toList(),
};

OAuthUnauthorizedResponse _$OAuthUnauthorizedResponseFromJson(
  Map<String, dynamic> json,
) => OAuthUnauthorizedResponse(
  success: json['success'] as bool,
  error: oAuth401ErrorCodeFromJson(json['error']),
  errorDescription: json['error_description'] as String,
  issues: (json['issues'] as List<dynamic>?)
      ?.map(
        (e) => OAuthUnauthorizedResponse$Issues$Item.fromJson(
          e as Map<String, dynamic>,
        ),
      )
      .toList(),
);

Map<String, dynamic> _$OAuthUnauthorizedResponseToJson(
  OAuthUnauthorizedResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'error': oAuth401ErrorCodeToJson(instance.error),
  'error_description': instance.errorDescription,
  'issues': instance.issues?.map((e) => e.toJson()).toList(),
};

OAuthInternalServerErrorResponse _$OAuthInternalServerErrorResponseFromJson(
  Map<String, dynamic> json,
) => OAuthInternalServerErrorResponse(
  success: json['success'] as bool,
  error: oAuth500ErrorCodeFromJson(json['error']),
  errorDescription: json['error_description'] as String,
  issues: (json['issues'] as List<dynamic>?)
      ?.map(
        (e) => OAuthInternalServerErrorResponse$Issues$Item.fromJson(
          e as Map<String, dynamic>,
        ),
      )
      .toList(),
);

Map<String, dynamic> _$OAuthInternalServerErrorResponseToJson(
  OAuthInternalServerErrorResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'error': oAuth500ErrorCodeToJson(instance.error),
  'error_description': instance.errorDescription,
  'issues': instance.issues?.map((e) => e.toJson()).toList(),
};

TransactionConstraints _$TransactionConstraintsFromJson(
  Map<String, dynamic> json,
) => TransactionConstraints(
  startDate: DateTime.parse(json['start_date'] as String),
);

Map<String, dynamic> _$TransactionConstraintsToJson(
  TransactionConstraints instance,
) => <String, dynamic>{'start_date': _dateToJson(instance.startDate)};

EnduringPaymentPeriodLimit _$EnduringPaymentPeriodLimitFromJson(
  Map<String, dynamic> json,
) => EnduringPaymentPeriodLimit(
  amount: (json['amount'] as num).toDouble(),
  frequency: enduringPaymentFrequencyFromJson(json['frequency']),
);

Map<String, dynamic> _$EnduringPaymentPeriodLimitToJson(
  EnduringPaymentPeriodLimit instance,
) => <String, dynamic>{
  'amount': instance.amount,
  'frequency': enduringPaymentFrequencyToJson(instance.frequency),
};

PaymentConsentStaticPayeeInput _$PaymentConsentStaticPayeeInputFromJson(
  Map<String, dynamic> json,
) => PaymentConsentStaticPayeeInput(
  source: paymentConsentStaticPayeeInputSourceFromJson(json['source']),
  accountNumber: json['account_number'] as String,
);

Map<String, dynamic> _$PaymentConsentStaticPayeeInputToJson(
  PaymentConsentStaticPayeeInput instance,
) => <String, dynamic>{
  'source': paymentConsentStaticPayeeInputSourceToJson(instance.source),
  'account_number': instance.accountNumber,
};

PaymentConsentRegisteredPayeeInput _$PaymentConsentRegisteredPayeeInputFromJson(
  Map<String, dynamic> json,
) => PaymentConsentRegisteredPayeeInput(
  source: paymentConsentRegisteredPayeeInputSourceFromJson(json['source']),
  payee: json['_payee'] as String,
);

Map<String, dynamic> _$PaymentConsentRegisteredPayeeInputToJson(
  PaymentConsentRegisteredPayeeInput instance,
) => <String, dynamic>{
  'source': paymentConsentRegisteredPayeeInputSourceToJson(instance.source),
  '_payee': instance.payee,
};

PaymentConsentInlinePayeeInputNoneVerified
_$PaymentConsentInlinePayeeInputNoneVerifiedFromJson(
  Map<String, dynamic> json,
) => PaymentConsentInlinePayeeInputNoneVerified(
  source: paymentConsentInlinePayeeInputNoneVerifiedSourceFromJson(
    json['source'],
  ),
  accountNumber: json['account_number'] as String,
  name: json['name'] as String,
  verificationMethod:
      paymentConsentInlinePayeeInputNoneVerifiedVerificationMethodFromJson(
        json['verification_method'],
      ),
);

Map<String, dynamic> _$PaymentConsentInlinePayeeInputNoneVerifiedToJson(
  PaymentConsentInlinePayeeInputNoneVerified instance,
) => <String, dynamic>{
  'source': paymentConsentInlinePayeeInputNoneVerifiedSourceToJson(
    instance.source,
  ),
  'account_number': instance.accountNumber,
  'name': instance.name,
  'verification_method':
      paymentConsentInlinePayeeInputNoneVerifiedVerificationMethodToJson(
        instance.verificationMethod,
      ),
};

PaymentConsentInlinePayeeInputClientVerified
_$PaymentConsentInlinePayeeInputClientVerifiedFromJson(
  Map<String, dynamic> json,
) => PaymentConsentInlinePayeeInputClientVerified(
  source: paymentConsentInlinePayeeInputClientVerifiedSourceFromJson(
    json['source'],
  ),
  accountNumber: json['account_number'] as String,
  name: json['name'] as String,
  verificationMethod:
      paymentConsentInlinePayeeInputClientVerifiedVerificationMethodFromJson(
        json['verification_method'],
      ),
);

Map<String, dynamic> _$PaymentConsentInlinePayeeInputClientVerifiedToJson(
  PaymentConsentInlinePayeeInputClientVerified instance,
) => <String, dynamic>{
  'source': paymentConsentInlinePayeeInputClientVerifiedSourceToJson(
    instance.source,
  ),
  'account_number': instance.accountNumber,
  'name': instance.name,
  'verification_method':
      paymentConsentInlinePayeeInputClientVerifiedVerificationMethodToJson(
        instance.verificationMethod,
      ),
};

PaymentConsentInlinePayeeInputVerifiedVerified
_$PaymentConsentInlinePayeeInputVerifiedVerifiedFromJson(
  Map<String, dynamic> json,
) => PaymentConsentInlinePayeeInputVerifiedVerified(
  source: paymentConsentInlinePayeeInputVerifiedVerifiedSourceFromJson(
    json['source'],
  ),
  verificationMethod:
      paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethodFromJson(
        json['verification_method'],
      ),
  verificationToken: json['verification_token'] as String,
);

Map<String, dynamic> _$PaymentConsentInlinePayeeInputVerifiedVerifiedToJson(
  PaymentConsentInlinePayeeInputVerifiedVerified instance,
) => <String, dynamic>{
  'source': paymentConsentInlinePayeeInputVerifiedVerifiedSourceToJson(
    instance.source,
  ),
  'verification_method':
      paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethodToJson(
        instance.verificationMethod,
      ),
  'verification_token': instance.verificationToken,
};

PaymentConsentInlinePayeeInput _$PaymentConsentInlinePayeeInputFromJson(
  Map<String, dynamic> json,
) => PaymentConsentInlinePayeeInput();

Map<String, dynamic> _$PaymentConsentInlinePayeeInputToJson(
  PaymentConsentInlinePayeeInput instance,
) => <String, dynamic>{};

EnduringAccessPaymentRequestApiView
_$EnduringAccessPaymentRequestApiViewFromJson(Map<String, dynamic> json) =>
    EnduringAccessPaymentRequestApiView(
      singleLimit: (json['single_limit'] as num).toDouble(),
      periodicLimit: EnduringPaymentPeriodLimit.fromJson(
        json['periodic_limit'] as Map<String, dynamic>,
      ),
      payees:
          (json['payees'] as List<dynamic>?)
              ?.map((e) => e as Object)
              .toList() ??
          [],
    );

Map<String, dynamic> _$EnduringAccessPaymentRequestApiViewToJson(
  EnduringAccessPaymentRequestApiView instance,
) => <String, dynamic>{
  'single_limit': instance.singleLimit,
  'periodic_limit': instance.periodicLimit.toJson(),
  'payees': instance.payees,
};

EnduringAccessConstraints _$EnduringAccessConstraintsFromJson(
  Map<String, dynamic> json,
) => EnduringAccessConstraints(
  transactions: json['transactions'] == null
      ? null
      : TransactionConstraints.fromJson(
          json['transactions'] as Map<String, dynamic>,
        ),
  payments: json['payments'] == null
      ? null
      : EnduringAccessPaymentRequestApiView.fromJson(
          json['payments'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$EnduringAccessConstraintsToJson(
  EnduringAccessConstraints instance,
) => <String, dynamic>{
  'transactions': instance.transactions?.toJson(),
  'payments': instance.payments?.toJson(),
};

EnduringAccessRequest _$EnduringAccessRequestFromJson(
  Map<String, dynamic> json,
) => EnduringAccessRequest(
  type: enduringAccessRequestTypeFromJson(json['type']),
  connections: json['connections'],
  scope: enduringAccessScopeListFromJson(json['scope'] as List?),
  constraints: json['constraints'] == null
      ? null
      : EnduringAccessConstraints.fromJson(
          json['constraints'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$EnduringAccessRequestToJson(
  EnduringAccessRequest instance,
) => <String, dynamic>{
  'type': enduringAccessRequestTypeToJson(instance.type),
  'connections': instance.connections,
  'scope': enduringAccessScopeListToJson(instance.scope),
  'constraints': instance.constraints?.toJson(),
};

EnduringPaymentConstraints _$EnduringPaymentConstraintsFromJson(
  Map<String, dynamic> json,
) => EnduringPaymentConstraints(
  label: json['label'] as String?,
  singleLimit: (json['single_limit'] as num).toDouble(),
  periodicLimit: EnduringPaymentPeriodLimit.fromJson(
    json['periodic_limit'] as Map<String, dynamic>,
  ),
  payees:
      (json['payees'] as List<dynamic>?)?.map((e) => e as Object).toList() ??
      [],
);

Map<String, dynamic> _$EnduringPaymentConstraintsToJson(
  EnduringPaymentConstraints instance,
) => <String, dynamic>{
  'label': instance.label,
  'single_limit': instance.singleLimit,
  'periodic_limit': instance.periodicLimit.toJson(),
  'payees': instance.payees,
};

EnduringPaymentConsentRequest _$EnduringPaymentConsentRequestFromJson(
  Map<String, dynamic> json,
) => EnduringPaymentConsentRequest(
  type: enduringPaymentConsentRequestTypeFromJson(json['type']),
  user: json['_user'] as String,
  account: json['_account'] as String,
  paymentConsent: json['payment_consent'] == null
      ? null
      : EnduringPaymentConstraints.fromJson(
          json['payment_consent'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$EnduringPaymentConsentRequestToJson(
  EnduringPaymentConsentRequest instance,
) => <String, dynamic>{
  'type': enduringPaymentConsentRequestTypeToJson(instance.type),
  '_user': instance.user,
  '_account': instance.account,
  'payment_consent': instance.paymentConsent?.toJson(),
};

AccessRequest _$AccessRequestFromJson(Map<String, dynamic> json) =>
    AccessRequest();

Map<String, dynamic> _$AccessRequestToJson(AccessRequest instance) =>
    <String, dynamic>{};

$400$Response _$$400$ResponseFromJson(Map<String, dynamic> json) =>
    $400$Response(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$400$ResponseToJson($400$Response instance) =>
    <String, dynamic>{'success': instance.success, 'message': instance.message};

$401$Response _$$401$ResponseFromJson(Map<String, dynamic> json) =>
    $401$Response(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$401$ResponseToJson($401$Response instance) =>
    <String, dynamic>{'success': instance.success, 'message': instance.message};

$403$Response _$$403$ResponseFromJson(Map<String, dynamic> json) =>
    $403$Response(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$403$ResponseToJson($403$Response instance) =>
    <String, dynamic>{'success': instance.success, 'message': instance.message};

$404$Response _$$404$ResponseFromJson(Map<String, dynamic> json) =>
    $404$Response(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$404$ResponseToJson($404$Response instance) =>
    <String, dynamic>{'success': instance.success, 'message': instance.message};

$429$Response _$$429$ResponseFromJson(Map<String, dynamic> json) =>
    $429$Response(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$429$ResponseToJson($429$Response instance) =>
    <String, dynamic>{'success': instance.success, 'message': instance.message};

$500$Response _$$500$ResponseFromJson(Map<String, dynamic> json) =>
    $500$Response(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$500$ResponseToJson($500$Response instance) =>
    <String, dynamic>{'success': instance.success, 'message': instance.message};

TokenPost$RequestBody _$TokenPost$RequestBodyFromJson(
  Map<String, dynamic> json,
) => TokenPost$RequestBody(
  grantType: json['grant_type'] as String,
  code: json['code'] as String,
  redirectUri: json['redirect_uri'] as String,
  clientId: json['client_id'] as String,
  clientSecret: json['client_secret'] as String,
);

Map<String, dynamic> _$TokenPost$RequestBodyToJson(
  TokenPost$RequestBody instance,
) => <String, dynamic>{
  'grant_type': instance.grantType,
  'code': instance.code,
  'redirect_uri': instance.redirectUri,
  'client_id': instance.clientId,
  'client_secret': instance.clientSecret,
};

ParPost$RequestBody _$ParPost$RequestBodyFromJson(Map<String, dynamic> json) =>
    ParPost$RequestBody(
      clientId: json['client_id'] as String,
      clientSecret: json['client_secret'] as String,
      loginHint: json['login_hint'],
      redirectUri: json['redirect_uri'] as String,
      redirectMode: oAuthRedirectModeNullableFromJson(json['redirect_mode']),
      responseType: oAuthResponseTypeFromJson(json['response_type']),
      state: json['state'] as String?,
      correlationId: json['correlation_id'] as String?,
      request: AccessRequest.fromJson(json['request'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ParPost$RequestBodyToJson(
  ParPost$RequestBody instance,
) => <String, dynamic>{
  'client_id': instance.clientId,
  'client_secret': instance.clientSecret,
  'login_hint': instance.loginHint,
  'redirect_uri': instance.redirectUri,
  'redirect_mode': oAuthRedirectModeNullableToJson(instance.redirectMode),
  'response_type': oAuthResponseTypeToJson(instance.responseType),
  'state': instance.state,
  'correlation_id': instance.correlationId,
  'request': instance.request.toJson(),
};

PaymentsPost$RequestBody _$PaymentsPost$RequestBodyFromJson(
  Map<String, dynamic> json,
) => PaymentsPost$RequestBody(
  from: json['from'] as String,
  to: PaymentsPost$RequestBody$To.fromJson(json['to'] as Map<String, dynamic>),
  amount: (json['amount'] as num).toDouble(),
  meta: json['meta'] == null
      ? null
      : PaymentsPost$RequestBody$Meta.fromJson(
          json['meta'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$PaymentsPost$RequestBodyToJson(
  PaymentsPost$RequestBody instance,
) => <String, dynamic>{
  'from': instance.from,
  'to': instance.to.toJson(),
  'amount': instance.amount,
  'meta': instance.meta?.toJson(),
};

PaymentsIrdPost$RequestBody _$PaymentsIrdPost$RequestBodyFromJson(
  Map<String, dynamic> json,
) => PaymentsIrdPost$RequestBody(
  from: json['from'] as String,
  amount: (json['amount'] as num).toDouble(),
  meta: PaymentsIrdPost$RequestBody$Meta.fromJson(
    json['meta'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$PaymentsIrdPost$RequestBodyToJson(
  PaymentsIrdPost$RequestBody instance,
) => <String, dynamic>{
  'from': instance.from,
  'amount': instance.amount,
  'meta': instance.meta.toJson(),
};

WebhooksPost$RequestBody _$WebhooksPost$RequestBodyFromJson(
  Map<String, dynamic> json,
) => WebhooksPost$RequestBody(
  webhookType: json['webhook_type'] as String?,
  state: json['state'] as String?,
);

Map<String, dynamic> _$WebhooksPost$RequestBodyToJson(
  WebhooksPost$RequestBody instance,
) => <String, dynamic>{
  'webhook_type': instance.webhookType,
  'state': instance.state,
};

SupportTransactionIdPost$RequestBody
_$SupportTransactionIdPost$RequestBodyFromJson(Map<String, dynamic> json) =>
    SupportTransactionIdPost$RequestBody(
      type: supportTransactionIdPost$RequestBodyTypeFromJson(json['type']),
      otherId: json['other_id'] as String?,
      fields:
          (json['fields'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$SupportTransactionIdPost$RequestBodyToJson(
  SupportTransactionIdPost$RequestBody instance,
) => <String, dynamic>{
  'type': supportTransactionIdPost$RequestBodyTypeToJson(instance.type),
  'other_id': instance.otherId,
  'fields': instance.fields,
  'comment': instance.comment,
};

AccountsGet$Response _$AccountsGet$ResponseFromJson(
  Map<String, dynamic> json,
) => AccountsGet$Response(
  success: json['success'] as bool?,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => Account.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$AccountsGet$ResponseToJson(
  AccountsGet$Response instance,
) => <String, dynamic>{
  'success': instance.success,
  'items': instance.items?.map((e) => e.toJson()).toList(),
};

AccountsIdGet$Response _$AccountsIdGet$ResponseFromJson(
  Map<String, dynamic> json,
) => AccountsIdGet$Response(
  success: json['success'] as bool?,
  item: json['item'] == null
      ? null
      : Account.fromJson(json['item'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AccountsIdGet$ResponseToJson(
  AccountsIdGet$Response instance,
) => <String, dynamic>{
  'success': instance.success,
  'item': instance.item?.toJson(),
};

AccountsIdVerificationTokenGet$Response
_$AccountsIdVerificationTokenGet$ResponseFromJson(Map<String, dynamic> json) =>
    AccountsIdVerificationTokenGet$Response(
      success: json['success'] as bool?,
      item: json['item'] as String?,
    );

Map<String, dynamic> _$AccountsIdVerificationTokenGet$ResponseToJson(
  AccountsIdVerificationTokenGet$Response instance,
) => <String, dynamic>{'success': instance.success, 'item': instance.item};

AccountsIdVerificationTokenDelete$Response
_$AccountsIdVerificationTokenDelete$ResponseFromJson(
  Map<String, dynamic> json,
) => AccountsIdVerificationTokenDelete$Response(
  success: json['success'] as bool?,
);

Map<String, dynamic> _$AccountsIdVerificationTokenDelete$ResponseToJson(
  AccountsIdVerificationTokenDelete$Response instance,
) => <String, dynamic>{'success': instance.success};

AccountsIdPaymentConsentsConsentIdDelete$Response
_$AccountsIdPaymentConsentsConsentIdDelete$ResponseFromJson(
  Map<String, dynamic> json,
) => AccountsIdPaymentConsentsConsentIdDelete$Response(
  success: json['success'] as bool?,
);

Map<String, dynamic> _$AccountsIdPaymentConsentsConsentIdDelete$ResponseToJson(
  AccountsIdPaymentConsentsConsentIdDelete$Response instance,
) => <String, dynamic>{'success': instance.success};

AuthorisationsIdDelete$Response _$AuthorisationsIdDelete$ResponseFromJson(
  Map<String, dynamic> json,
) => AuthorisationsIdDelete$Response(success: json['success'] as bool?);

Map<String, dynamic> _$AuthorisationsIdDelete$ResponseToJson(
  AuthorisationsIdDelete$Response instance,
) => <String, dynamic>{'success': instance.success};

TokenDelete$Response _$TokenDelete$ResponseFromJson(
  Map<String, dynamic> json,
) => TokenDelete$Response(success: json['success'] as bool?);

Map<String, dynamic> _$TokenDelete$ResponseToJson(
  TokenDelete$Response instance,
) => <String, dynamic>{'success': instance.success};

ConnectionsGet$Response _$ConnectionsGet$ResponseFromJson(
  Map<String, dynamic> json,
) => ConnectionsGet$Response(
  success: json['success'] as bool?,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => Connection.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$ConnectionsGet$ResponseToJson(
  ConnectionsGet$Response instance,
) => <String, dynamic>{
  'success': instance.success,
  'items': instance.items?.map((e) => e.toJson()).toList(),
};

ConnectionsIdGet$Response _$ConnectionsIdGet$ResponseFromJson(
  Map<String, dynamic> json,
) => ConnectionsIdGet$Response(
  success: json['success'] as bool?,
  item: json['item'] == null
      ? null
      : Connection.fromJson(json['item'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ConnectionsIdGet$ResponseToJson(
  ConnectionsIdGet$Response instance,
) => <String, dynamic>{
  'success': instance.success,
  'item': instance.item?.toJson(),
};

CategoriesGet$Response _$CategoriesGet$ResponseFromJson(
  Map<String, dynamic> json,
) => CategoriesGet$Response(
  success: json['success'] as bool?,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$CategoriesGet$ResponseToJson(
  CategoriesGet$Response instance,
) => <String, dynamic>{
  'success': instance.success,
  'items': instance.items?.map((e) => e.toJson()).toList(),
};

CategoriesIdGet$Response _$CategoriesIdGet$ResponseFromJson(
  Map<String, dynamic> json,
) => CategoriesIdGet$Response(
  success: json['success'] as bool?,
  item: json['item'] == null
      ? null
      : Category.fromJson(json['item'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CategoriesIdGet$ResponseToJson(
  CategoriesIdGet$Response instance,
) => <String, dynamic>{
  'success': instance.success,
  'item': instance.item?.toJson(),
};

RefreshPost$Response _$RefreshPost$ResponseFromJson(
  Map<String, dynamic> json,
) => RefreshPost$Response(success: json['success'] as bool?);

Map<String, dynamic> _$RefreshPost$ResponseToJson(
  RefreshPost$Response instance,
) => <String, dynamic>{'success': instance.success};

RefreshIdPost$Response _$RefreshIdPost$ResponseFromJson(
  Map<String, dynamic> json,
) => RefreshIdPost$Response(success: json['success'] as bool?);

Map<String, dynamic> _$RefreshIdPost$ResponseToJson(
  RefreshIdPost$Response instance,
) => <String, dynamic>{'success': instance.success};

IdentityIdGet$Response _$IdentityIdGet$ResponseFromJson(
  Map<String, dynamic> json,
) => IdentityIdGet$Response(
  success: json['success'] as bool?,
  item: json['item'] == null
      ? null
      : OneOffIdentity.fromJson(json['item'] as Map<String, dynamic>),
);

Map<String, dynamic> _$IdentityIdGet$ResponseToJson(
  IdentityIdGet$Response instance,
) => <String, dynamic>{
  'success': instance.success,
  'item': instance.item?.toJson(),
};

PartiesGet$Response _$PartiesGet$ResponseFromJson(Map<String, dynamic> json) =>
    PartiesGet$Response(
      success: json['success'] as bool?,
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => Party.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PartiesGet$ResponseToJson(
  PartiesGet$Response instance,
) => <String, dynamic>{
  'success': instance.success,
  'items': instance.items?.map((e) => e.toJson()).toList(),
};

PaymentsGet$Response _$PaymentsGet$ResponseFromJson(
  Map<String, dynamic> json,
) => PaymentsGet$Response(
  success: json['success'] as bool?,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => Payment.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$PaymentsGet$ResponseToJson(
  PaymentsGet$Response instance,
) => <String, dynamic>{
  'success': instance.success,
  'items': instance.items?.map((e) => e.toJson()).toList(),
};

PaymentsPost$Response _$PaymentsPost$ResponseFromJson(
  Map<String, dynamic> json,
) => PaymentsPost$Response(
  success: json['success'] as bool?,
  item: json['item'] == null
      ? null
      : Payment.fromJson(json['item'] as Map<String, dynamic>),
  itemId: json['item_id'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$PaymentsPost$ResponseToJson(
  PaymentsPost$Response instance,
) => <String, dynamic>{
  'success': instance.success,
  'item': instance.item?.toJson(),
  'item_id': instance.itemId,
  'status': instance.status,
};

PaymentsIrdPost$Response _$PaymentsIrdPost$ResponseFromJson(
  Map<String, dynamic> json,
) => PaymentsIrdPost$Response(
  success: json['success'] as bool?,
  item: json['item'] == null
      ? null
      : Payment.fromJson(json['item'] as Map<String, dynamic>),
  itemId: json['item_id'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$PaymentsIrdPost$ResponseToJson(
  PaymentsIrdPost$Response instance,
) => <String, dynamic>{
  'success': instance.success,
  'item': instance.item?.toJson(),
  'item_id': instance.itemId,
  'status': instance.status,
};

PaymentsIdGet$Response _$PaymentsIdGet$ResponseFromJson(
  Map<String, dynamic> json,
) => PaymentsIdGet$Response(
  success: json['success'] as bool?,
  item: json['item'] == null
      ? null
      : Payment.fromJson(json['item'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PaymentsIdGet$ResponseToJson(
  PaymentsIdGet$Response instance,
) => <String, dynamic>{
  'success': instance.success,
  'item': instance.item?.toJson(),
};

PaymentsIdCancelPut$Response _$PaymentsIdCancelPut$ResponseFromJson(
  Map<String, dynamic> json,
) => PaymentsIdCancelPut$Response(success: json['success'] as bool?);

Map<String, dynamic> _$PaymentsIdCancelPut$ResponseToJson(
  PaymentsIdCancelPut$Response instance,
) => <String, dynamic>{'success': instance.success};

TransactionsGet$Response _$TransactionsGet$ResponseFromJson(
  Map<String, dynamic> json,
) => TransactionsGet$Response(
  success: json['success'] as bool?,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  cursor: json['cursor'] == null
      ? null
      : TransactionsGet$Response$Cursor.fromJson(
          json['cursor'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$TransactionsGet$ResponseToJson(
  TransactionsGet$Response instance,
) => <String, dynamic>{
  'success': instance.success,
  'items': instance.items?.map((e) => e.toJson()).toList(),
  'cursor': instance.cursor?.toJson(),
};

TransactionsPendingGet$Response _$TransactionsPendingGet$ResponseFromJson(
  Map<String, dynamic> json,
) => TransactionsPendingGet$Response(
  success: json['success'] as bool?,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => PendingTransaction.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$TransactionsPendingGet$ResponseToJson(
  TransactionsPendingGet$Response instance,
) => <String, dynamic>{
  'success': instance.success,
  'items': instance.items?.map((e) => e.toJson()).toList(),
};

TransactionsIdGet$Response _$TransactionsIdGet$ResponseFromJson(
  Map<String, dynamic> json,
) => TransactionsIdGet$Response(
  success: json['success'] as bool?,
  item: json['item'] == null
      ? null
      : Transaction.fromJson(json['item'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TransactionsIdGet$ResponseToJson(
  TransactionsIdGet$Response instance,
) => <String, dynamic>{
  'success': instance.success,
  'item': instance.item?.toJson(),
};

AccountsIdTransactionsGet$Response _$AccountsIdTransactionsGet$ResponseFromJson(
  Map<String, dynamic> json,
) => AccountsIdTransactionsGet$Response(
  success: json['success'] as bool?,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  cursor: json['cursor'] == null
      ? null
      : AccountsIdTransactionsGet$Response$Cursor.fromJson(
          json['cursor'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$AccountsIdTransactionsGet$ResponseToJson(
  AccountsIdTransactionsGet$Response instance,
) => <String, dynamic>{
  'success': instance.success,
  'items': instance.items?.map((e) => e.toJson()).toList(),
  'cursor': instance.cursor?.toJson(),
};

AccountsIdTransactionsPendingGet$Response
_$AccountsIdTransactionsPendingGet$ResponseFromJson(
  Map<String, dynamic> json,
) => AccountsIdTransactionsPendingGet$Response(
  success: json['success'] as bool?,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => PendingTransaction.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$AccountsIdTransactionsPendingGet$ResponseToJson(
  AccountsIdTransactionsPendingGet$Response instance,
) => <String, dynamic>{
  'success': instance.success,
  'items': instance.items?.map((e) => e.toJson()).toList(),
};

TransactionsIdsPost$Response _$TransactionsIdsPost$ResponseFromJson(
  Map<String, dynamic> json,
) => TransactionsIdsPost$Response(
  success: json['success'] as bool?,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$TransactionsIdsPost$ResponseToJson(
  TransactionsIdsPost$Response instance,
) => <String, dynamic>{
  'success': instance.success,
  'items': instance.items?.map((e) => e.toJson()).toList(),
};

MeGet$Response _$MeGet$ResponseFromJson(Map<String, dynamic> json) =>
    MeGet$Response(
      success: json['success'] as bool?,
      item: json['item'] == null
          ? null
          : Me.fromJson(json['item'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MeGet$ResponseToJson(MeGet$Response instance) =>
    <String, dynamic>{
      'success': instance.success,
      'item': instance.item?.toJson(),
    };

WebhooksGet$Response _$WebhooksGet$ResponseFromJson(
  Map<String, dynamic> json,
) => WebhooksGet$Response(
  success: json['success'] as bool?,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => Webhook.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$WebhooksGet$ResponseToJson(
  WebhooksGet$Response instance,
) => <String, dynamic>{
  'success': instance.success,
  'items': instance.items?.map((e) => e.toJson()).toList(),
};

WebhooksPost$Response _$WebhooksPost$ResponseFromJson(
  Map<String, dynamic> json,
) => WebhooksPost$Response(
  success: json['success'] as bool?,
  itemId: json['item_id'] as String?,
);

Map<String, dynamic> _$WebhooksPost$ResponseToJson(
  WebhooksPost$Response instance,
) => <String, dynamic>{'success': instance.success, 'item_id': instance.itemId};

KeysIdGet$Response _$KeysIdGet$ResponseFromJson(Map<String, dynamic> json) =>
    KeysIdGet$Response(
      success: json['success'] as bool?,
      item: json['item'] as String?,
    );

Map<String, dynamic> _$KeysIdGet$ResponseToJson(KeysIdGet$Response instance) =>
    <String, dynamic>{'success': instance.success, 'item': instance.item};

WebhooksIdDelete$Response _$WebhooksIdDelete$ResponseFromJson(
  Map<String, dynamic> json,
) => WebhooksIdDelete$Response(success: json['success'] as bool?);

Map<String, dynamic> _$WebhooksIdDelete$ResponseToJson(
  WebhooksIdDelete$Response instance,
) => <String, dynamic>{'success': instance.success};

WebhookEventsGet$Response _$WebhookEventsGet$ResponseFromJson(
  Map<String, dynamic> json,
) => WebhookEventsGet$Response(
  success: json['success'] as bool?,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => WebhookEvent.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$WebhookEventsGet$ResponseToJson(
  WebhookEventsGet$Response instance,
) => <String, dynamic>{
  'success': instance.success,
  'items': instance.items?.map((e) => e.toJson()).toList(),
};

SupportTransactionIdPost$Response _$SupportTransactionIdPost$ResponseFromJson(
  Map<String, dynamic> json,
) => SupportTransactionIdPost$Response(success: json['success'] as bool?);

Map<String, dynamic> _$SupportTransactionIdPost$ResponseToJson(
  SupportTransactionIdPost$Response instance,
) => <String, dynamic>{'success': instance.success};

Account$Balance _$Account$BalanceFromJson(Map<String, dynamic> json) =>
    Account$Balance(
      currency: json['currency'] as String,
      current: (json['current'] as num).toDouble(),
      available: (json['available'] as num?)?.toDouble(),
      limit: (json['limit'] as num?)?.toDouble(),
      overdrawn: json['overdrawn'] as bool?,
    );

Map<String, dynamic> _$Account$BalanceToJson(Account$Balance instance) =>
    <String, dynamic>{
      'currency': instance.currency,
      'current': instance.current,
      'available': instance.available,
      'limit': instance.limit,
      'overdrawn': instance.overdrawn,
    };

Account$Meta _$Account$MetaFromJson(Map<String, dynamic> json) => Account$Meta(
  holder: json['holder'] as String?,
  hasUnlistedHolders: json['has_unlisted_holders'] as bool?,
  loanDetails: json['loan_details'] == null
      ? null
      : Account$Meta$LoanDetails.fromJson(
          json['loan_details'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$Account$MetaToJson(Account$Meta instance) =>
    <String, dynamic>{
      'holder': instance.holder,
      'has_unlisted_holders': instance.hasUnlistedHolders,
      'loan_details': instance.loanDetails?.toJson(),
    };

Account$Refreshed _$Account$RefreshedFromJson(Map<String, dynamic> json) =>
    Account$Refreshed(
      balance: json['balance'] == null
          ? null
          : DateTime.parse(json['balance'] as String),
      meta: json['meta'] == null
          ? null
          : DateTime.parse(json['meta'] as String),
      transactions: json['transactions'] as String?,
      party: json['party'] as String?,
    );

Map<String, dynamic> _$Account$RefreshedToJson(Account$Refreshed instance) =>
    <String, dynamic>{
      'balance': instance.balance?.toIso8601String(),
      'meta': instance.meta?.toIso8601String(),
      'transactions': instance.transactions,
      'party': instance.party,
    };

VerifyNamePartySource$Meta _$VerifyNamePartySource$MetaFromJson(
  Map<String, dynamic> json,
) => VerifyNamePartySource$Meta(
  value: json['value'] as String,
  sources:
      (json['sources'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      [],
);

Map<String, dynamic> _$VerifyNamePartySource$MetaToJson(
  VerifyNamePartySource$Meta instance,
) => <String, dynamic>{'value': instance.value, 'sources': instance.sources};

VerifyNameHolderSource$Meta _$VerifyNameHolderSource$MetaFromJson(
  Map<String, dynamic> json,
) => VerifyNameHolderSource$Meta(
  id: json['_id'] as String,
  name: json['name'] as String,
  formattedAccount: json['formatted_account'] as String?,
  holder: json['holder'] as String,
  hasUnlistedHolders: json['has_unlisted_holders'] as bool?,
);

Map<String, dynamic> _$VerifyNameHolderSource$MetaToJson(
  VerifyNameHolderSource$Meta instance,
) => <String, dynamic>{
  '_id': instance.id,
  'name': instance.name,
  'formatted_account': instance.formattedAccount,
  'holder': instance.holder,
  'has_unlisted_holders': instance.hasUnlistedHolders,
};

Transaction$Merchant _$Transaction$MerchantFromJson(
  Map<String, dynamic> json,
) => Transaction$Merchant(
  id: json['_id'] as String?,
  name: json['name'] as String?,
  website: json['website'] as String?,
);

Map<String, dynamic> _$Transaction$MerchantToJson(
  Transaction$Merchant instance,
) => <String, dynamic>{
  '_id': instance.id,
  'name': instance.name,
  'website': instance.website,
};

Transaction$Category _$Transaction$CategoryFromJson(
  Map<String, dynamic> json,
) => Transaction$Category(
  id: json['_id'] as String?,
  name: json['name'] as String?,
  groups: json['groups'] == null
      ? null
      : CategoryGroups.fromJson(json['groups'] as Map<String, dynamic>),
);

Map<String, dynamic> _$Transaction$CategoryToJson(
  Transaction$Category instance,
) => <String, dynamic>{
  '_id': instance.id,
  'name': instance.name,
  'groups': instance.groups?.toJson(),
};

Transaction$Meta _$Transaction$MetaFromJson(Map<String, dynamic> json) =>
    Transaction$Meta(
      particulars: json['particulars'] as String?,
      code: json['code'] as String?,
      reference: json['reference'] as String?,
      otherAccount: json['other_account'] as String?,
      conversion: json['conversion'] == null
          ? null
          : Transaction$Meta$Conversion.fromJson(
              json['conversion'] as Map<String, dynamic>,
            ),
      cardSuffix: json['card_suffix'] as String?,
      logo: json['logo'] as String?,
    );

Map<String, dynamic> _$Transaction$MetaToJson(Transaction$Meta instance) =>
    <String, dynamic>{
      'particulars': instance.particulars,
      'code': instance.code,
      'reference': instance.reference,
      'other_account': instance.otherAccount,
      'conversion': instance.conversion?.toJson(),
      'card_suffix': instance.cardSuffix,
      'logo': instance.logo,
    };

PendingTransaction$Meta _$PendingTransaction$MetaFromJson(
  Map<String, dynamic> json,
) => PendingTransaction$Meta(
  particulars: json['particulars'] as String?,
  code: json['code'] as String?,
  reference: json['reference'] as String?,
  otherAccount: json['other_account'] as String?,
  conversion: json['conversion'] == null
      ? null
      : PendingTransaction$Meta$Conversion.fromJson(
          json['conversion'] as Map<String, dynamic>,
        ),
  cardSuffix: json['card_suffix'] as String?,
);

Map<String, dynamic> _$PendingTransaction$MetaToJson(
  PendingTransaction$Meta instance,
) => <String, dynamic>{
  'particulars': instance.particulars,
  'code': instance.code,
  'reference': instance.reference,
  'other_account': instance.otherAccount,
  'conversion': instance.conversion?.toJson(),
  'card_suffix': instance.cardSuffix,
};

Payment$To _$Payment$ToFromJson(Map<String, dynamic> json) => Payment$To(
  accountNumber: json['account_number'] as String?,
  name: json['name'] as String?,
);

Map<String, dynamic> _$Payment$ToToJson(Payment$To instance) =>
    <String, dynamic>{
      'account_number': instance.accountNumber,
      'name': instance.name,
    };

Payment$Meta _$Payment$MetaFromJson(Map<String, dynamic> json) => Payment$Meta(
  destination: json['destination'] == null
      ? null
      : Payment$Meta$Destination.fromJson(
          json['destination'] as Map<String, dynamic>,
        ),
  source: json['source'] == null
      ? null
      : Payment$Meta$Source.fromJson(json['source'] as Map<String, dynamic>),
);

Map<String, dynamic> _$Payment$MetaToJson(Payment$Meta instance) =>
    <String, dynamic>{
      'destination': instance.destination?.toJson(),
      'source': instance.source?.toJson(),
    };

Payment$Timeline$Item _$Payment$Timeline$ItemFromJson(
  Map<String, dynamic> json,
) => Payment$Timeline$Item(
  status: json['status'] as String?,
  time: json['time'] == null ? null : DateTime.parse(json['time'] as String),
  eta: json['eta'] == null ? null : DateTime.parse(json['eta'] as String),
);

Map<String, dynamic> _$Payment$Timeline$ItemToJson(
  Payment$Timeline$Item instance,
) => <String, dynamic>{
  'status': instance.status,
  'time': instance.time?.toIso8601String(),
  'eta': instance.eta?.toIso8601String(),
};

Party$Name _$Party$NameFromJson(Map<String, dynamic> json) =>
    Party$Name(value: json['value'] as String?);

Map<String, dynamic> _$Party$NameToJson(Party$Name instance) =>
    <String, dynamic>{'value': instance.value};

Party$Dob _$Party$DobFromJson(Map<String, dynamic> json) => Party$Dob(
  value: json['value'] == null ? null : DateTime.parse(json['value'] as String),
);

Map<String, dynamic> _$Party$DobToJson(Party$Dob instance) => <String, dynamic>{
  'value': _dateToJson(instance.value),
};

Party$TaxNumber _$Party$TaxNumberFromJson(Map<String, dynamic> json) =>
    Party$TaxNumber(value: json['value'] as String?);

Map<String, dynamic> _$Party$TaxNumberToJson(Party$TaxNumber instance) =>
    <String, dynamic>{'value': instance.value};

Party$PhoneNumbers$Item _$Party$PhoneNumbers$ItemFromJson(
  Map<String, dynamic> json,
) => Party$PhoneNumbers$Item(
  value: json['value'] as String?,
  subtype: party$PhoneNumbers$ItemSubtypeNullableFromJson(json['subtype']),
  verified: json['verified'] as bool?,
);

Map<String, dynamic> _$Party$PhoneNumbers$ItemToJson(
  Party$PhoneNumbers$Item instance,
) => <String, dynamic>{
  'value': instance.value,
  'subtype': party$PhoneNumbers$ItemSubtypeNullableToJson(instance.subtype),
  'verified': instance.verified,
};

Party$EmailAddresses$Item _$Party$EmailAddresses$ItemFromJson(
  Map<String, dynamic> json,
) => Party$EmailAddresses$Item(
  value: json['value'] as String?,
  subtype: party$EmailAddresses$ItemSubtypeNullableFromJson(json['subtype']),
  verified: json['verified'] as bool?,
);

Map<String, dynamic> _$Party$EmailAddresses$ItemToJson(
  Party$EmailAddresses$Item instance,
) => <String, dynamic>{
  'value': instance.value,
  'subtype': party$EmailAddresses$ItemSubtypeNullableToJson(instance.subtype),
  'verified': instance.verified,
};

Party$Addresses$Item _$Party$Addresses$ItemFromJson(
  Map<String, dynamic> json,
) => Party$Addresses$Item(
  value: json['value'] as String?,
  subtype: addressTypeNullableFromJson(json['subtype']),
  formatted: json['formatted'] as String?,
  components: json['components'] == null
      ? null
      : AddressComponents.fromJson(json['components'] as Map<String, dynamic>),
  googleMapsPlaceId: json['google_maps_place_id'] as String?,
);

Map<String, dynamic> _$Party$Addresses$ItemToJson(
  Party$Addresses$Item instance,
) => <String, dynamic>{
  'value': instance.value,
  'subtype': addressTypeNullableToJson(instance.subtype),
  'formatted': instance.formatted,
  'components': instance.components?.toJson(),
  'google_maps_place_id': instance.googleMapsPlaceId,
};

WebhookEvent$Payload _$WebhookEvent$PayloadFromJson(
  Map<String, dynamic> json,
) => WebhookEvent$Payload(
  success: json['success'] as bool?,
  webhookType: webhookEvent$PayloadWebhookTypeNullableFromJson(
    json['webhook_type'],
  ),
  webhookCode: json['webhook_code'] as String?,
);

Map<String, dynamic> _$WebhookEvent$PayloadToJson(
  WebhookEvent$Payload instance,
) => <String, dynamic>{
  'success': instance.success,
  'webhook_type': webhookEvent$PayloadWebhookTypeNullableToJson(
    instance.webhookType,
  ),
  'webhook_code': instance.webhookCode,
};

CreateAuthorisationRequestInvalidRequestResponse$Issues$Item
_$CreateAuthorisationRequestInvalidRequestResponse$Issues$ItemFromJson(
  Map<String, dynamic> json,
) => CreateAuthorisationRequestInvalidRequestResponse$Issues$Item(
  code: createAuthorisationRequestIssueCodeFromJson(json['code']),
  message: json['message'] as String,
  path: (json['path'] as List<dynamic>).map((e) => e as Object).toList(),
);

Map<String, dynamic>
_$CreateAuthorisationRequestInvalidRequestResponse$Issues$ItemToJson(
  CreateAuthorisationRequestInvalidRequestResponse$Issues$Item instance,
) => <String, dynamic>{
  'code': createAuthorisationRequestIssueCodeToJson(instance.code),
  'message': instance.message,
  'path': instance.path,
};

OAuthUnauthorizedResponse$Issues$Item
_$OAuthUnauthorizedResponse$Issues$ItemFromJson(Map<String, dynamic> json) =>
    OAuthUnauthorizedResponse$Issues$Item(
      code: oAuth401ErrorCodeFromJson(json['code']),
      message: json['message'] as String,
      path: (json['path'] as List<dynamic>).map((e) => e as Object).toList(),
    );

Map<String, dynamic> _$OAuthUnauthorizedResponse$Issues$ItemToJson(
  OAuthUnauthorizedResponse$Issues$Item instance,
) => <String, dynamic>{
  'code': oAuth401ErrorCodeToJson(instance.code),
  'message': instance.message,
  'path': instance.path,
};

OAuthInternalServerErrorResponse$Issues$Item
_$OAuthInternalServerErrorResponse$Issues$ItemFromJson(
  Map<String, dynamic> json,
) => OAuthInternalServerErrorResponse$Issues$Item(
  code: oAuth500ErrorCodeFromJson(json['code']),
  message: json['message'] as String,
  path: (json['path'] as List<dynamic>).map((e) => e as Object).toList(),
);

Map<String, dynamic> _$OAuthInternalServerErrorResponse$Issues$ItemToJson(
  OAuthInternalServerErrorResponse$Issues$Item instance,
) => <String, dynamic>{
  'code': oAuth500ErrorCodeToJson(instance.code),
  'message': instance.message,
  'path': instance.path,
};

PaymentsPost$RequestBody$To _$PaymentsPost$RequestBody$ToFromJson(
  Map<String, dynamic> json,
) => PaymentsPost$RequestBody$To(
  name: json['name'] as String?,
  accountNumber: json['account_number'] as String?,
);

Map<String, dynamic> _$PaymentsPost$RequestBody$ToToJson(
  PaymentsPost$RequestBody$To instance,
) => <String, dynamic>{
  'name': instance.name,
  'account_number': instance.accountNumber,
};

PaymentsPost$RequestBody$Meta _$PaymentsPost$RequestBody$MetaFromJson(
  Map<String, dynamic> json,
) => PaymentsPost$RequestBody$Meta(
  source: json['source'] == null
      ? null
      : PaymentsPost$RequestBody$Meta$Source.fromJson(
          json['source'] as Map<String, dynamic>,
        ),
  destination: json['destination'] == null
      ? null
      : PaymentsPost$RequestBody$Meta$Destination.fromJson(
          json['destination'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$PaymentsPost$RequestBody$MetaToJson(
  PaymentsPost$RequestBody$Meta instance,
) => <String, dynamic>{
  'source': instance.source?.toJson(),
  'destination': instance.destination?.toJson(),
};

PaymentsIrdPost$RequestBody$Meta _$PaymentsIrdPost$RequestBody$MetaFromJson(
  Map<String, dynamic> json,
) => PaymentsIrdPost$RequestBody$Meta(
  taxNumber: json['tax_number'] as String,
  taxType: json['tax_type'] as String,
  taxPeriod: json['tax_period'] as String?,
);

Map<String, dynamic> _$PaymentsIrdPost$RequestBody$MetaToJson(
  PaymentsIrdPost$RequestBody$Meta instance,
) => <String, dynamic>{
  'tax_number': instance.taxNumber,
  'tax_type': instance.taxType,
  'tax_period': instance.taxPeriod,
};

TransactionsGet$Response$Cursor _$TransactionsGet$Response$CursorFromJson(
  Map<String, dynamic> json,
) => TransactionsGet$Response$Cursor(next: json['next'] as String?);

Map<String, dynamic> _$TransactionsGet$Response$CursorToJson(
  TransactionsGet$Response$Cursor instance,
) => <String, dynamic>{'next': instance.next};

AccountsIdTransactionsGet$Response$Cursor
_$AccountsIdTransactionsGet$Response$CursorFromJson(
  Map<String, dynamic> json,
) => AccountsIdTransactionsGet$Response$Cursor(next: json['next'] as String?);

Map<String, dynamic> _$AccountsIdTransactionsGet$Response$CursorToJson(
  AccountsIdTransactionsGet$Response$Cursor instance,
) => <String, dynamic>{'next': instance.next};

Account$Meta$LoanDetails _$Account$Meta$LoanDetailsFromJson(
  Map<String, dynamic> json,
) => Account$Meta$LoanDetails(
  purpose: account$Meta$LoanDetailsPurposeFromJson(json['purpose']),
  type: account$Meta$LoanDetailsTypeFromJson(json['type']),
  interest: Account$Meta$LoanDetails$Interest.fromJson(
    json['interest'] as Map<String, dynamic>,
  ),
  isInterestOnly: json['is_interest_only'] as bool,
  interestOnlyExpiresAt: json['interest_only_expires_at'] == null
      ? null
      : DateTime.parse(json['interest_only_expires_at'] as String),
  term: json['term'] == null
      ? null
      : Account$Meta$LoanDetails$Term.fromJson(
          json['term'] as Map<String, dynamic>,
        ),
  maturesAt: json['matures_at'] == null
      ? null
      : DateTime.parse(json['matures_at'] as String),
  initialPrincipal: (json['initial_principal'] as num?)?.toDouble(),
  repayment: json['repayment'] == null
      ? null
      : Account$Meta$LoanDetails$Repayment.fromJson(
          json['repayment'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$Account$Meta$LoanDetailsToJson(
  Account$Meta$LoanDetails instance,
) => <String, dynamic>{
  'purpose': account$Meta$LoanDetailsPurposeToJson(instance.purpose),
  'type': account$Meta$LoanDetailsTypeToJson(instance.type),
  'interest': instance.interest.toJson(),
  'is_interest_only': instance.isInterestOnly,
  'interest_only_expires_at': instance.interestOnlyExpiresAt?.toIso8601String(),
  'term': instance.term?.toJson(),
  'matures_at': instance.maturesAt?.toIso8601String(),
  'initial_principal': instance.initialPrincipal,
  'repayment': instance.repayment?.toJson(),
};

Transaction$Meta$Conversion _$Transaction$Meta$ConversionFromJson(
  Map<String, dynamic> json,
) => Transaction$Meta$Conversion(
  amount: (json['amount'] as num?)?.toDouble(),
  currency: json['currency'] as String?,
  rate: (json['rate'] as num?)?.toDouble(),
);

Map<String, dynamic> _$Transaction$Meta$ConversionToJson(
  Transaction$Meta$Conversion instance,
) => <String, dynamic>{
  'amount': instance.amount,
  'currency': instance.currency,
  'rate': instance.rate,
};

PendingTransaction$Meta$Conversion _$PendingTransaction$Meta$ConversionFromJson(
  Map<String, dynamic> json,
) => PendingTransaction$Meta$Conversion(
  amount: (json['amount'] as num?)?.toDouble(),
  currency: json['currency'] as String?,
  rate: (json['rate'] as num?)?.toDouble(),
);

Map<String, dynamic> _$PendingTransaction$Meta$ConversionToJson(
  PendingTransaction$Meta$Conversion instance,
) => <String, dynamic>{
  'amount': instance.amount,
  'currency': instance.currency,
  'rate': instance.rate,
};

Payment$Meta$Destination _$Payment$Meta$DestinationFromJson(
  Map<String, dynamic> json,
) => Payment$Meta$Destination(
  particulars: json['particulars'] as String?,
  code: json['code'] as String?,
  reference: json['reference'] as String?,
);

Map<String, dynamic> _$Payment$Meta$DestinationToJson(
  Payment$Meta$Destination instance,
) => <String, dynamic>{
  'particulars': instance.particulars,
  'code': instance.code,
  'reference': instance.reference,
};

Payment$Meta$Source _$Payment$Meta$SourceFromJson(Map<String, dynamic> json) =>
    Payment$Meta$Source(
      code: json['code'] as String?,
      reference: json['reference'] as String?,
    );

Map<String, dynamic> _$Payment$Meta$SourceToJson(
  Payment$Meta$Source instance,
) => <String, dynamic>{'code': instance.code, 'reference': instance.reference};

PaymentsPost$RequestBody$Meta$Source
_$PaymentsPost$RequestBody$Meta$SourceFromJson(Map<String, dynamic> json) =>
    PaymentsPost$RequestBody$Meta$Source(
      code: json['code'] as String?,
      reference: json['reference'] as String?,
    );

Map<String, dynamic> _$PaymentsPost$RequestBody$Meta$SourceToJson(
  PaymentsPost$RequestBody$Meta$Source instance,
) => <String, dynamic>{'code': instance.code, 'reference': instance.reference};

PaymentsPost$RequestBody$Meta$Destination
_$PaymentsPost$RequestBody$Meta$DestinationFromJson(
  Map<String, dynamic> json,
) => PaymentsPost$RequestBody$Meta$Destination(
  particulars: json['particulars'] as String?,
  code: json['code'] as String?,
  reference: json['reference'] as String?,
);

Map<String, dynamic> _$PaymentsPost$RequestBody$Meta$DestinationToJson(
  PaymentsPost$RequestBody$Meta$Destination instance,
) => <String, dynamic>{
  'particulars': instance.particulars,
  'code': instance.code,
  'reference': instance.reference,
};

Account$Meta$LoanDetails$Interest _$Account$Meta$LoanDetails$InterestFromJson(
  Map<String, dynamic> json,
) => Account$Meta$LoanDetails$Interest(
  rate: (json['rate'] as num).toDouble(),
  type: account$Meta$LoanDetails$InterestTypeFromJson(json['type']),
  expiresAt: json['expires_at'] == null
      ? null
      : DateTime.parse(json['expires_at'] as String),
);

Map<String, dynamic> _$Account$Meta$LoanDetails$InterestToJson(
  Account$Meta$LoanDetails$Interest instance,
) => <String, dynamic>{
  'rate': instance.rate,
  'type': account$Meta$LoanDetails$InterestTypeToJson(instance.type),
  'expires_at': instance.expiresAt?.toIso8601String(),
};

Account$Meta$LoanDetails$Term _$Account$Meta$LoanDetails$TermFromJson(
  Map<String, dynamic> json,
) => Account$Meta$LoanDetails$Term(
  years: (json['years'] as num?)?.toDouble(),
  months: (json['months'] as num?)?.toDouble(),
);

Map<String, dynamic> _$Account$Meta$LoanDetails$TermToJson(
  Account$Meta$LoanDetails$Term instance,
) => <String, dynamic>{'years': instance.years, 'months': instance.months};

Account$Meta$LoanDetails$Repayment _$Account$Meta$LoanDetails$RepaymentFromJson(
  Map<String, dynamic> json,
) => Account$Meta$LoanDetails$Repayment(
  frequency: account$Meta$LoanDetails$RepaymentFrequencyNullableFromJson(
    json['frequency'],
  ),
  nextDate: json['next_date'] == null
      ? null
      : DateTime.parse(json['next_date'] as String),
  nextAmount: (json['next_amount'] as num).toDouble(),
);

Map<String, dynamic> _$Account$Meta$LoanDetails$RepaymentToJson(
  Account$Meta$LoanDetails$Repayment instance,
) => <String, dynamic>{
  'frequency': account$Meta$LoanDetails$RepaymentFrequencyNullableToJson(
    instance.frequency,
  ),
  'next_date': instance.nextDate?.toIso8601String(),
  'next_amount': instance.nextAmount,
};
