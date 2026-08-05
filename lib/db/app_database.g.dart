// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AccountsTable extends Accounts
    with TableInfo<$AccountsTable, AccountRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attributesMeta = const VerificationMeta(
    'attributes',
  );
  @override
  late final GeneratedColumn<String> attributes = GeneratedColumn<String>(
    'attributes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _formattedAccountMeta = const VerificationMeta(
    'formattedAccount',
  );
  @override
  late final GeneratedColumn<String> formattedAccount = GeneratedColumn<String>(
    'formatted_account',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _connectionIdMeta = const VerificationMeta(
    'connectionId',
  );
  @override
  late final GeneratedColumn<String> connectionId = GeneratedColumn<String>(
    'connection_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _connectionNameMeta = const VerificationMeta(
    'connectionName',
  );
  @override
  late final GeneratedColumn<String> connectionName = GeneratedColumn<String>(
    'connection_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _connectionLogoMeta = const VerificationMeta(
    'connectionLogo',
  );
  @override
  late final GeneratedColumn<String> connectionLogo = GeneratedColumn<String>(
    'connection_logo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _connectionTypeMeta = const VerificationMeta(
    'connectionType',
  );
  @override
  late final GeneratedColumn<String> connectionType = GeneratedColumn<String>(
    'connection_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _balanceCurrentMeta = const VerificationMeta(
    'balanceCurrent',
  );
  @override
  late final GeneratedColumn<double> balanceCurrent = GeneratedColumn<double>(
    'balance_current',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _balanceAvailableMeta = const VerificationMeta(
    'balanceAvailable',
  );
  @override
  late final GeneratedColumn<double> balanceAvailable = GeneratedColumn<double>(
    'balance_available',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _balanceLimitMeta = const VerificationMeta(
    'balanceLimit',
  );
  @override
  late final GeneratedColumn<double> balanceLimit = GeneratedColumn<double>(
    'balance_limit',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _balanceOverdrawnMeta = const VerificationMeta(
    'balanceOverdrawn',
  );
  @override
  late final GeneratedColumn<bool> balanceOverdrawn = GeneratedColumn<bool>(
    'balance_overdrawn',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("balance_overdrawn" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _holderMeta = const VerificationMeta('holder');
  @override
  late final GeneratedColumn<String> holder = GeneratedColumn<String>(
    'holder',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _refreshedBalanceMeta = const VerificationMeta(
    'refreshedBalance',
  );
  @override
  late final GeneratedColumn<String> refreshedBalance = GeneratedColumn<String>(
    'refreshed_balance',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _refreshedMetaMeta = const VerificationMeta(
    'refreshedMeta',
  );
  @override
  late final GeneratedColumn<String> refreshedMeta = GeneratedColumn<String>(
    'refreshed_meta',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _refreshedTransactionsMeta =
      const VerificationMeta('refreshedTransactions');
  @override
  late final GeneratedColumn<String> refreshedTransactions =
      GeneratedColumn<String>(
        'refreshed_transactions',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    status,
    type,
    attributes,
    formattedAccount,
    connectionId,
    connectionName,
    connectionLogo,
    connectionType,
    balanceCurrent,
    balanceAvailable,
    balanceLimit,
    balanceOverdrawn,
    holder,
    refreshedBalance,
    refreshedMeta,
    refreshedTransactions,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<AccountRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('attributes')) {
      context.handle(
        _attributesMeta,
        attributes.isAcceptableOrUnknown(data['attributes']!, _attributesMeta),
      );
    } else if (isInserting) {
      context.missing(_attributesMeta);
    }
    if (data.containsKey('formatted_account')) {
      context.handle(
        _formattedAccountMeta,
        formattedAccount.isAcceptableOrUnknown(
          data['formatted_account']!,
          _formattedAccountMeta,
        ),
      );
    }
    if (data.containsKey('connection_id')) {
      context.handle(
        _connectionIdMeta,
        connectionId.isAcceptableOrUnknown(
          data['connection_id']!,
          _connectionIdMeta,
        ),
      );
    }
    if (data.containsKey('connection_name')) {
      context.handle(
        _connectionNameMeta,
        connectionName.isAcceptableOrUnknown(
          data['connection_name']!,
          _connectionNameMeta,
        ),
      );
    }
    if (data.containsKey('connection_logo')) {
      context.handle(
        _connectionLogoMeta,
        connectionLogo.isAcceptableOrUnknown(
          data['connection_logo']!,
          _connectionLogoMeta,
        ),
      );
    }
    if (data.containsKey('connection_type')) {
      context.handle(
        _connectionTypeMeta,
        connectionType.isAcceptableOrUnknown(
          data['connection_type']!,
          _connectionTypeMeta,
        ),
      );
    }
    if (data.containsKey('balance_current')) {
      context.handle(
        _balanceCurrentMeta,
        balanceCurrent.isAcceptableOrUnknown(
          data['balance_current']!,
          _balanceCurrentMeta,
        ),
      );
    }
    if (data.containsKey('balance_available')) {
      context.handle(
        _balanceAvailableMeta,
        balanceAvailable.isAcceptableOrUnknown(
          data['balance_available']!,
          _balanceAvailableMeta,
        ),
      );
    }
    if (data.containsKey('balance_limit')) {
      context.handle(
        _balanceLimitMeta,
        balanceLimit.isAcceptableOrUnknown(
          data['balance_limit']!,
          _balanceLimitMeta,
        ),
      );
    }
    if (data.containsKey('balance_overdrawn')) {
      context.handle(
        _balanceOverdrawnMeta,
        balanceOverdrawn.isAcceptableOrUnknown(
          data['balance_overdrawn']!,
          _balanceOverdrawnMeta,
        ),
      );
    }
    if (data.containsKey('holder')) {
      context.handle(
        _holderMeta,
        holder.isAcceptableOrUnknown(data['holder']!, _holderMeta),
      );
    }
    if (data.containsKey('refreshed_balance')) {
      context.handle(
        _refreshedBalanceMeta,
        refreshedBalance.isAcceptableOrUnknown(
          data['refreshed_balance']!,
          _refreshedBalanceMeta,
        ),
      );
    }
    if (data.containsKey('refreshed_meta')) {
      context.handle(
        _refreshedMetaMeta,
        refreshedMeta.isAcceptableOrUnknown(
          data['refreshed_meta']!,
          _refreshedMetaMeta,
        ),
      );
    }
    if (data.containsKey('refreshed_transactions')) {
      context.handle(
        _refreshedTransactionsMeta,
        refreshedTransactions.isAcceptableOrUnknown(
          data['refreshed_transactions']!,
          _refreshedTransactionsMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      attributes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attributes'],
      )!,
      formattedAccount: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}formatted_account'],
      ),
      connectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}connection_id'],
      ),
      connectionName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}connection_name'],
      ),
      connectionLogo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}connection_logo'],
      ),
      connectionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}connection_type'],
      ),
      balanceCurrent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}balance_current'],
      ),
      balanceAvailable: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}balance_available'],
      ),
      balanceLimit: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}balance_limit'],
      ),
      balanceOverdrawn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}balance_overdrawn'],
      )!,
      holder: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}holder'],
      ),
      refreshedBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}refreshed_balance'],
      ),
      refreshedMeta: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}refreshed_meta'],
      ),
      refreshedTransactions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}refreshed_transactions'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }
}

class AccountRow extends DataClass implements Insertable<AccountRow> {
  final String id;
  final String name;
  final String status;
  final String type;
  final String attributes;
  final String? formattedAccount;
  final String? connectionId;
  final String? connectionName;
  final String? connectionLogo;
  final String? connectionType;
  final double? balanceCurrent;
  final double? balanceAvailable;
  final double? balanceLimit;
  final bool balanceOverdrawn;
  final String? holder;
  final String? refreshedBalance;
  final String? refreshedMeta;
  final String? refreshedTransactions;
  final DateTime updatedAt;
  const AccountRow({
    required this.id,
    required this.name,
    required this.status,
    required this.type,
    required this.attributes,
    this.formattedAccount,
    this.connectionId,
    this.connectionName,
    this.connectionLogo,
    this.connectionType,
    this.balanceCurrent,
    this.balanceAvailable,
    this.balanceLimit,
    required this.balanceOverdrawn,
    this.holder,
    this.refreshedBalance,
    this.refreshedMeta,
    this.refreshedTransactions,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['status'] = Variable<String>(status);
    map['type'] = Variable<String>(type);
    map['attributes'] = Variable<String>(attributes);
    if (!nullToAbsent || formattedAccount != null) {
      map['formatted_account'] = Variable<String>(formattedAccount);
    }
    if (!nullToAbsent || connectionId != null) {
      map['connection_id'] = Variable<String>(connectionId);
    }
    if (!nullToAbsent || connectionName != null) {
      map['connection_name'] = Variable<String>(connectionName);
    }
    if (!nullToAbsent || connectionLogo != null) {
      map['connection_logo'] = Variable<String>(connectionLogo);
    }
    if (!nullToAbsent || connectionType != null) {
      map['connection_type'] = Variable<String>(connectionType);
    }
    if (!nullToAbsent || balanceCurrent != null) {
      map['balance_current'] = Variable<double>(balanceCurrent);
    }
    if (!nullToAbsent || balanceAvailable != null) {
      map['balance_available'] = Variable<double>(balanceAvailable);
    }
    if (!nullToAbsent || balanceLimit != null) {
      map['balance_limit'] = Variable<double>(balanceLimit);
    }
    map['balance_overdrawn'] = Variable<bool>(balanceOverdrawn);
    if (!nullToAbsent || holder != null) {
      map['holder'] = Variable<String>(holder);
    }
    if (!nullToAbsent || refreshedBalance != null) {
      map['refreshed_balance'] = Variable<String>(refreshedBalance);
    }
    if (!nullToAbsent || refreshedMeta != null) {
      map['refreshed_meta'] = Variable<String>(refreshedMeta);
    }
    if (!nullToAbsent || refreshedTransactions != null) {
      map['refreshed_transactions'] = Variable<String>(refreshedTransactions);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      id: Value(id),
      name: Value(name),
      status: Value(status),
      type: Value(type),
      attributes: Value(attributes),
      formattedAccount: formattedAccount == null && nullToAbsent
          ? const Value.absent()
          : Value(formattedAccount),
      connectionId: connectionId == null && nullToAbsent
          ? const Value.absent()
          : Value(connectionId),
      connectionName: connectionName == null && nullToAbsent
          ? const Value.absent()
          : Value(connectionName),
      connectionLogo: connectionLogo == null && nullToAbsent
          ? const Value.absent()
          : Value(connectionLogo),
      connectionType: connectionType == null && nullToAbsent
          ? const Value.absent()
          : Value(connectionType),
      balanceCurrent: balanceCurrent == null && nullToAbsent
          ? const Value.absent()
          : Value(balanceCurrent),
      balanceAvailable: balanceAvailable == null && nullToAbsent
          ? const Value.absent()
          : Value(balanceAvailable),
      balanceLimit: balanceLimit == null && nullToAbsent
          ? const Value.absent()
          : Value(balanceLimit),
      balanceOverdrawn: Value(balanceOverdrawn),
      holder: holder == null && nullToAbsent
          ? const Value.absent()
          : Value(holder),
      refreshedBalance: refreshedBalance == null && nullToAbsent
          ? const Value.absent()
          : Value(refreshedBalance),
      refreshedMeta: refreshedMeta == null && nullToAbsent
          ? const Value.absent()
          : Value(refreshedMeta),
      refreshedTransactions: refreshedTransactions == null && nullToAbsent
          ? const Value.absent()
          : Value(refreshedTransactions),
      updatedAt: Value(updatedAt),
    );
  }

  factory AccountRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      status: serializer.fromJson<String>(json['status']),
      type: serializer.fromJson<String>(json['type']),
      attributes: serializer.fromJson<String>(json['attributes']),
      formattedAccount: serializer.fromJson<String?>(json['formattedAccount']),
      connectionId: serializer.fromJson<String?>(json['connectionId']),
      connectionName: serializer.fromJson<String?>(json['connectionName']),
      connectionLogo: serializer.fromJson<String?>(json['connectionLogo']),
      connectionType: serializer.fromJson<String?>(json['connectionType']),
      balanceCurrent: serializer.fromJson<double?>(json['balanceCurrent']),
      balanceAvailable: serializer.fromJson<double?>(json['balanceAvailable']),
      balanceLimit: serializer.fromJson<double?>(json['balanceLimit']),
      balanceOverdrawn: serializer.fromJson<bool>(json['balanceOverdrawn']),
      holder: serializer.fromJson<String?>(json['holder']),
      refreshedBalance: serializer.fromJson<String?>(json['refreshedBalance']),
      refreshedMeta: serializer.fromJson<String?>(json['refreshedMeta']),
      refreshedTransactions: serializer.fromJson<String?>(
        json['refreshedTransactions'],
      ),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'status': serializer.toJson<String>(status),
      'type': serializer.toJson<String>(type),
      'attributes': serializer.toJson<String>(attributes),
      'formattedAccount': serializer.toJson<String?>(formattedAccount),
      'connectionId': serializer.toJson<String?>(connectionId),
      'connectionName': serializer.toJson<String?>(connectionName),
      'connectionLogo': serializer.toJson<String?>(connectionLogo),
      'connectionType': serializer.toJson<String?>(connectionType),
      'balanceCurrent': serializer.toJson<double?>(balanceCurrent),
      'balanceAvailable': serializer.toJson<double?>(balanceAvailable),
      'balanceLimit': serializer.toJson<double?>(balanceLimit),
      'balanceOverdrawn': serializer.toJson<bool>(balanceOverdrawn),
      'holder': serializer.toJson<String?>(holder),
      'refreshedBalance': serializer.toJson<String?>(refreshedBalance),
      'refreshedMeta': serializer.toJson<String?>(refreshedMeta),
      'refreshedTransactions': serializer.toJson<String?>(
        refreshedTransactions,
      ),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AccountRow copyWith({
    String? id,
    String? name,
    String? status,
    String? type,
    String? attributes,
    Value<String?> formattedAccount = const Value.absent(),
    Value<String?> connectionId = const Value.absent(),
    Value<String?> connectionName = const Value.absent(),
    Value<String?> connectionLogo = const Value.absent(),
    Value<String?> connectionType = const Value.absent(),
    Value<double?> balanceCurrent = const Value.absent(),
    Value<double?> balanceAvailable = const Value.absent(),
    Value<double?> balanceLimit = const Value.absent(),
    bool? balanceOverdrawn,
    Value<String?> holder = const Value.absent(),
    Value<String?> refreshedBalance = const Value.absent(),
    Value<String?> refreshedMeta = const Value.absent(),
    Value<String?> refreshedTransactions = const Value.absent(),
    DateTime? updatedAt,
  }) => AccountRow(
    id: id ?? this.id,
    name: name ?? this.name,
    status: status ?? this.status,
    type: type ?? this.type,
    attributes: attributes ?? this.attributes,
    formattedAccount: formattedAccount.present
        ? formattedAccount.value
        : this.formattedAccount,
    connectionId: connectionId.present ? connectionId.value : this.connectionId,
    connectionName: connectionName.present
        ? connectionName.value
        : this.connectionName,
    connectionLogo: connectionLogo.present
        ? connectionLogo.value
        : this.connectionLogo,
    connectionType: connectionType.present
        ? connectionType.value
        : this.connectionType,
    balanceCurrent: balanceCurrent.present
        ? balanceCurrent.value
        : this.balanceCurrent,
    balanceAvailable: balanceAvailable.present
        ? balanceAvailable.value
        : this.balanceAvailable,
    balanceLimit: balanceLimit.present ? balanceLimit.value : this.balanceLimit,
    balanceOverdrawn: balanceOverdrawn ?? this.balanceOverdrawn,
    holder: holder.present ? holder.value : this.holder,
    refreshedBalance: refreshedBalance.present
        ? refreshedBalance.value
        : this.refreshedBalance,
    refreshedMeta: refreshedMeta.present
        ? refreshedMeta.value
        : this.refreshedMeta,
    refreshedTransactions: refreshedTransactions.present
        ? refreshedTransactions.value
        : this.refreshedTransactions,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AccountRow copyWithCompanion(AccountsCompanion data) {
    return AccountRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      status: data.status.present ? data.status.value : this.status,
      type: data.type.present ? data.type.value : this.type,
      attributes: data.attributes.present
          ? data.attributes.value
          : this.attributes,
      formattedAccount: data.formattedAccount.present
          ? data.formattedAccount.value
          : this.formattedAccount,
      connectionId: data.connectionId.present
          ? data.connectionId.value
          : this.connectionId,
      connectionName: data.connectionName.present
          ? data.connectionName.value
          : this.connectionName,
      connectionLogo: data.connectionLogo.present
          ? data.connectionLogo.value
          : this.connectionLogo,
      connectionType: data.connectionType.present
          ? data.connectionType.value
          : this.connectionType,
      balanceCurrent: data.balanceCurrent.present
          ? data.balanceCurrent.value
          : this.balanceCurrent,
      balanceAvailable: data.balanceAvailable.present
          ? data.balanceAvailable.value
          : this.balanceAvailable,
      balanceLimit: data.balanceLimit.present
          ? data.balanceLimit.value
          : this.balanceLimit,
      balanceOverdrawn: data.balanceOverdrawn.present
          ? data.balanceOverdrawn.value
          : this.balanceOverdrawn,
      holder: data.holder.present ? data.holder.value : this.holder,
      refreshedBalance: data.refreshedBalance.present
          ? data.refreshedBalance.value
          : this.refreshedBalance,
      refreshedMeta: data.refreshedMeta.present
          ? data.refreshedMeta.value
          : this.refreshedMeta,
      refreshedTransactions: data.refreshedTransactions.present
          ? data.refreshedTransactions.value
          : this.refreshedTransactions,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('status: $status, ')
          ..write('type: $type, ')
          ..write('attributes: $attributes, ')
          ..write('formattedAccount: $formattedAccount, ')
          ..write('connectionId: $connectionId, ')
          ..write('connectionName: $connectionName, ')
          ..write('connectionLogo: $connectionLogo, ')
          ..write('connectionType: $connectionType, ')
          ..write('balanceCurrent: $balanceCurrent, ')
          ..write('balanceAvailable: $balanceAvailable, ')
          ..write('balanceLimit: $balanceLimit, ')
          ..write('balanceOverdrawn: $balanceOverdrawn, ')
          ..write('holder: $holder, ')
          ..write('refreshedBalance: $refreshedBalance, ')
          ..write('refreshedMeta: $refreshedMeta, ')
          ..write('refreshedTransactions: $refreshedTransactions, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    status,
    type,
    attributes,
    formattedAccount,
    connectionId,
    connectionName,
    connectionLogo,
    connectionType,
    balanceCurrent,
    balanceAvailable,
    balanceLimit,
    balanceOverdrawn,
    holder,
    refreshedBalance,
    refreshedMeta,
    refreshedTransactions,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.status == this.status &&
          other.type == this.type &&
          other.attributes == this.attributes &&
          other.formattedAccount == this.formattedAccount &&
          other.connectionId == this.connectionId &&
          other.connectionName == this.connectionName &&
          other.connectionLogo == this.connectionLogo &&
          other.connectionType == this.connectionType &&
          other.balanceCurrent == this.balanceCurrent &&
          other.balanceAvailable == this.balanceAvailable &&
          other.balanceLimit == this.balanceLimit &&
          other.balanceOverdrawn == this.balanceOverdrawn &&
          other.holder == this.holder &&
          other.refreshedBalance == this.refreshedBalance &&
          other.refreshedMeta == this.refreshedMeta &&
          other.refreshedTransactions == this.refreshedTransactions &&
          other.updatedAt == this.updatedAt);
}

class AccountsCompanion extends UpdateCompanion<AccountRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> status;
  final Value<String> type;
  final Value<String> attributes;
  final Value<String?> formattedAccount;
  final Value<String?> connectionId;
  final Value<String?> connectionName;
  final Value<String?> connectionLogo;
  final Value<String?> connectionType;
  final Value<double?> balanceCurrent;
  final Value<double?> balanceAvailable;
  final Value<double?> balanceLimit;
  final Value<bool> balanceOverdrawn;
  final Value<String?> holder;
  final Value<String?> refreshedBalance;
  final Value<String?> refreshedMeta;
  final Value<String?> refreshedTransactions;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.status = const Value.absent(),
    this.type = const Value.absent(),
    this.attributes = const Value.absent(),
    this.formattedAccount = const Value.absent(),
    this.connectionId = const Value.absent(),
    this.connectionName = const Value.absent(),
    this.connectionLogo = const Value.absent(),
    this.connectionType = const Value.absent(),
    this.balanceCurrent = const Value.absent(),
    this.balanceAvailable = const Value.absent(),
    this.balanceLimit = const Value.absent(),
    this.balanceOverdrawn = const Value.absent(),
    this.holder = const Value.absent(),
    this.refreshedBalance = const Value.absent(),
    this.refreshedMeta = const Value.absent(),
    this.refreshedTransactions = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AccountsCompanion.insert({
    required String id,
    required String name,
    required String status,
    required String type,
    required String attributes,
    this.formattedAccount = const Value.absent(),
    this.connectionId = const Value.absent(),
    this.connectionName = const Value.absent(),
    this.connectionLogo = const Value.absent(),
    this.connectionType = const Value.absent(),
    this.balanceCurrent = const Value.absent(),
    this.balanceAvailable = const Value.absent(),
    this.balanceLimit = const Value.absent(),
    this.balanceOverdrawn = const Value.absent(),
    this.holder = const Value.absent(),
    this.refreshedBalance = const Value.absent(),
    this.refreshedMeta = const Value.absent(),
    this.refreshedTransactions = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       status = Value(status),
       type = Value(type),
       attributes = Value(attributes),
       updatedAt = Value(updatedAt);
  static Insertable<AccountRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? status,
    Expression<String>? type,
    Expression<String>? attributes,
    Expression<String>? formattedAccount,
    Expression<String>? connectionId,
    Expression<String>? connectionName,
    Expression<String>? connectionLogo,
    Expression<String>? connectionType,
    Expression<double>? balanceCurrent,
    Expression<double>? balanceAvailable,
    Expression<double>? balanceLimit,
    Expression<bool>? balanceOverdrawn,
    Expression<String>? holder,
    Expression<String>? refreshedBalance,
    Expression<String>? refreshedMeta,
    Expression<String>? refreshedTransactions,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (status != null) 'status': status,
      if (type != null) 'type': type,
      if (attributes != null) 'attributes': attributes,
      if (formattedAccount != null) 'formatted_account': formattedAccount,
      if (connectionId != null) 'connection_id': connectionId,
      if (connectionName != null) 'connection_name': connectionName,
      if (connectionLogo != null) 'connection_logo': connectionLogo,
      if (connectionType != null) 'connection_type': connectionType,
      if (balanceCurrent != null) 'balance_current': balanceCurrent,
      if (balanceAvailable != null) 'balance_available': balanceAvailable,
      if (balanceLimit != null) 'balance_limit': balanceLimit,
      if (balanceOverdrawn != null) 'balance_overdrawn': balanceOverdrawn,
      if (holder != null) 'holder': holder,
      if (refreshedBalance != null) 'refreshed_balance': refreshedBalance,
      if (refreshedMeta != null) 'refreshed_meta': refreshedMeta,
      if (refreshedTransactions != null)
        'refreshed_transactions': refreshedTransactions,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AccountsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? status,
    Value<String>? type,
    Value<String>? attributes,
    Value<String?>? formattedAccount,
    Value<String?>? connectionId,
    Value<String?>? connectionName,
    Value<String?>? connectionLogo,
    Value<String?>? connectionType,
    Value<double?>? balanceCurrent,
    Value<double?>? balanceAvailable,
    Value<double?>? balanceLimit,
    Value<bool>? balanceOverdrawn,
    Value<String?>? holder,
    Value<String?>? refreshedBalance,
    Value<String?>? refreshedMeta,
    Value<String?>? refreshedTransactions,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AccountsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      type: type ?? this.type,
      attributes: attributes ?? this.attributes,
      formattedAccount: formattedAccount ?? this.formattedAccount,
      connectionId: connectionId ?? this.connectionId,
      connectionName: connectionName ?? this.connectionName,
      connectionLogo: connectionLogo ?? this.connectionLogo,
      connectionType: connectionType ?? this.connectionType,
      balanceCurrent: balanceCurrent ?? this.balanceCurrent,
      balanceAvailable: balanceAvailable ?? this.balanceAvailable,
      balanceLimit: balanceLimit ?? this.balanceLimit,
      balanceOverdrawn: balanceOverdrawn ?? this.balanceOverdrawn,
      holder: holder ?? this.holder,
      refreshedBalance: refreshedBalance ?? this.refreshedBalance,
      refreshedMeta: refreshedMeta ?? this.refreshedMeta,
      refreshedTransactions:
          refreshedTransactions ?? this.refreshedTransactions,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (attributes.present) {
      map['attributes'] = Variable<String>(attributes.value);
    }
    if (formattedAccount.present) {
      map['formatted_account'] = Variable<String>(formattedAccount.value);
    }
    if (connectionId.present) {
      map['connection_id'] = Variable<String>(connectionId.value);
    }
    if (connectionName.present) {
      map['connection_name'] = Variable<String>(connectionName.value);
    }
    if (connectionLogo.present) {
      map['connection_logo'] = Variable<String>(connectionLogo.value);
    }
    if (connectionType.present) {
      map['connection_type'] = Variable<String>(connectionType.value);
    }
    if (balanceCurrent.present) {
      map['balance_current'] = Variable<double>(balanceCurrent.value);
    }
    if (balanceAvailable.present) {
      map['balance_available'] = Variable<double>(balanceAvailable.value);
    }
    if (balanceLimit.present) {
      map['balance_limit'] = Variable<double>(balanceLimit.value);
    }
    if (balanceOverdrawn.present) {
      map['balance_overdrawn'] = Variable<bool>(balanceOverdrawn.value);
    }
    if (holder.present) {
      map['holder'] = Variable<String>(holder.value);
    }
    if (refreshedBalance.present) {
      map['refreshed_balance'] = Variable<String>(refreshedBalance.value);
    }
    if (refreshedMeta.present) {
      map['refreshed_meta'] = Variable<String>(refreshedMeta.value);
    }
    if (refreshedTransactions.present) {
      map['refreshed_transactions'] = Variable<String>(
        refreshedTransactions.value,
      );
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('status: $status, ')
          ..write('type: $type, ')
          ..write('attributes: $attributes, ')
          ..write('formattedAccount: $formattedAccount, ')
          ..write('connectionId: $connectionId, ')
          ..write('connectionName: $connectionName, ')
          ..write('connectionLogo: $connectionLogo, ')
          ..write('connectionType: $connectionType, ')
          ..write('balanceCurrent: $balanceCurrent, ')
          ..write('balanceAvailable: $balanceAvailable, ')
          ..write('balanceLimit: $balanceLimit, ')
          ..write('balanceOverdrawn: $balanceOverdrawn, ')
          ..write('holder: $holder, ')
          ..write('refreshedBalance: $refreshedBalance, ')
          ..write('refreshedMeta: $refreshedMeta, ')
          ..write('refreshedTransactions: $refreshedTransactions, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, TransactionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _connectionIdMeta = const VerificationMeta(
    'connectionId',
  );
  @override
  late final GeneratedColumn<String> connectionId = GeneratedColumn<String>(
    'connection_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _balanceMeta = const VerificationMeta(
    'balance',
  );
  @override
  late final GeneratedColumn<double> balance = GeneratedColumn<double>(
    'balance',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _merchantNameMeta = const VerificationMeta(
    'merchantName',
  );
  @override
  late final GeneratedColumn<String> merchantName = GeneratedColumn<String>(
    'merchant_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryNameMeta = const VerificationMeta(
    'categoryName',
  );
  @override
  late final GeneratedColumn<String> categoryName = GeneratedColumn<String>(
    'category_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryGroupMeta = const VerificationMeta(
    'categoryGroup',
  );
  @override
  late final GeneratedColumn<String> categoryGroup = GeneratedColumn<String>(
    'category_group',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _autoCategoryNameMeta = const VerificationMeta(
    'autoCategoryName',
  );
  @override
  late final GeneratedColumn<String> autoCategoryName = GeneratedColumn<String>(
    'auto_category_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _autoCategoryGroupMeta = const VerificationMeta(
    'autoCategoryGroup',
  );
  @override
  late final GeneratedColumn<String> autoCategoryGroup =
      GeneratedColumn<String>(
        'auto_category_group',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _metaLogoMeta = const VerificationMeta(
    'metaLogo',
  );
  @override
  late final GeneratedColumn<String> metaLogo = GeneratedColumn<String>(
    'meta_logo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountId,
    connectionId,
    date,
    description,
    amount,
    balance,
    type,
    merchantName,
    categoryName,
    categoryGroup,
    autoCategoryName,
    autoCategoryGroup,
    metaLogo,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransactionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('connection_id')) {
      context.handle(
        _connectionIdMeta,
        connectionId.isAcceptableOrUnknown(
          data['connection_id']!,
          _connectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_connectionIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('balance')) {
      context.handle(
        _balanceMeta,
        balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('merchant_name')) {
      context.handle(
        _merchantNameMeta,
        merchantName.isAcceptableOrUnknown(
          data['merchant_name']!,
          _merchantNameMeta,
        ),
      );
    }
    if (data.containsKey('category_name')) {
      context.handle(
        _categoryNameMeta,
        categoryName.isAcceptableOrUnknown(
          data['category_name']!,
          _categoryNameMeta,
        ),
      );
    }
    if (data.containsKey('category_group')) {
      context.handle(
        _categoryGroupMeta,
        categoryGroup.isAcceptableOrUnknown(
          data['category_group']!,
          _categoryGroupMeta,
        ),
      );
    }
    if (data.containsKey('auto_category_name')) {
      context.handle(
        _autoCategoryNameMeta,
        autoCategoryName.isAcceptableOrUnknown(
          data['auto_category_name']!,
          _autoCategoryNameMeta,
        ),
      );
    }
    if (data.containsKey('auto_category_group')) {
      context.handle(
        _autoCategoryGroupMeta,
        autoCategoryGroup.isAcceptableOrUnknown(
          data['auto_category_group']!,
          _autoCategoryGroupMeta,
        ),
      );
    }
    if (data.containsKey('meta_logo')) {
      context.handle(
        _metaLogoMeta,
        metaLogo.isAcceptableOrUnknown(data['meta_logo']!, _metaLogoMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      connectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}connection_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      balance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}balance'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      merchantName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}merchant_name'],
      ),
      categoryName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_name'],
      ),
      categoryGroup: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_group'],
      ),
      autoCategoryName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}auto_category_name'],
      ),
      autoCategoryGroup: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}auto_category_group'],
      ),
      metaLogo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meta_logo'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class TransactionRow extends DataClass implements Insertable<TransactionRow> {
  final String id;
  final String accountId;
  final String connectionId;
  final String date;
  final String description;
  final double amount;
  final double? balance;
  final String type;
  final String? merchantName;
  final String? categoryName;
  final String? categoryGroup;
  final String? autoCategoryName;
  final String? autoCategoryGroup;
  final String? metaLogo;
  final DateTime updatedAt;
  const TransactionRow({
    required this.id,
    required this.accountId,
    required this.connectionId,
    required this.date,
    required this.description,
    required this.amount,
    this.balance,
    required this.type,
    this.merchantName,
    this.categoryName,
    this.categoryGroup,
    this.autoCategoryName,
    this.autoCategoryGroup,
    this.metaLogo,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['account_id'] = Variable<String>(accountId);
    map['connection_id'] = Variable<String>(connectionId);
    map['date'] = Variable<String>(date);
    map['description'] = Variable<String>(description);
    map['amount'] = Variable<double>(amount);
    if (!nullToAbsent || balance != null) {
      map['balance'] = Variable<double>(balance);
    }
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || merchantName != null) {
      map['merchant_name'] = Variable<String>(merchantName);
    }
    if (!nullToAbsent || categoryName != null) {
      map['category_name'] = Variable<String>(categoryName);
    }
    if (!nullToAbsent || categoryGroup != null) {
      map['category_group'] = Variable<String>(categoryGroup);
    }
    if (!nullToAbsent || autoCategoryName != null) {
      map['auto_category_name'] = Variable<String>(autoCategoryName);
    }
    if (!nullToAbsent || autoCategoryGroup != null) {
      map['auto_category_group'] = Variable<String>(autoCategoryGroup);
    }
    if (!nullToAbsent || metaLogo != null) {
      map['meta_logo'] = Variable<String>(metaLogo);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      accountId: Value(accountId),
      connectionId: Value(connectionId),
      date: Value(date),
      description: Value(description),
      amount: Value(amount),
      balance: balance == null && nullToAbsent
          ? const Value.absent()
          : Value(balance),
      type: Value(type),
      merchantName: merchantName == null && nullToAbsent
          ? const Value.absent()
          : Value(merchantName),
      categoryName: categoryName == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryName),
      categoryGroup: categoryGroup == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryGroup),
      autoCategoryName: autoCategoryName == null && nullToAbsent
          ? const Value.absent()
          : Value(autoCategoryName),
      autoCategoryGroup: autoCategoryGroup == null && nullToAbsent
          ? const Value.absent()
          : Value(autoCategoryGroup),
      metaLogo: metaLogo == null && nullToAbsent
          ? const Value.absent()
          : Value(metaLogo),
      updatedAt: Value(updatedAt),
    );
  }

  factory TransactionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionRow(
      id: serializer.fromJson<String>(json['id']),
      accountId: serializer.fromJson<String>(json['accountId']),
      connectionId: serializer.fromJson<String>(json['connectionId']),
      date: serializer.fromJson<String>(json['date']),
      description: serializer.fromJson<String>(json['description']),
      amount: serializer.fromJson<double>(json['amount']),
      balance: serializer.fromJson<double?>(json['balance']),
      type: serializer.fromJson<String>(json['type']),
      merchantName: serializer.fromJson<String?>(json['merchantName']),
      categoryName: serializer.fromJson<String?>(json['categoryName']),
      categoryGroup: serializer.fromJson<String?>(json['categoryGroup']),
      autoCategoryName: serializer.fromJson<String?>(json['autoCategoryName']),
      autoCategoryGroup: serializer.fromJson<String?>(
        json['autoCategoryGroup'],
      ),
      metaLogo: serializer.fromJson<String?>(json['metaLogo']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'accountId': serializer.toJson<String>(accountId),
      'connectionId': serializer.toJson<String>(connectionId),
      'date': serializer.toJson<String>(date),
      'description': serializer.toJson<String>(description),
      'amount': serializer.toJson<double>(amount),
      'balance': serializer.toJson<double?>(balance),
      'type': serializer.toJson<String>(type),
      'merchantName': serializer.toJson<String?>(merchantName),
      'categoryName': serializer.toJson<String?>(categoryName),
      'categoryGroup': serializer.toJson<String?>(categoryGroup),
      'autoCategoryName': serializer.toJson<String?>(autoCategoryName),
      'autoCategoryGroup': serializer.toJson<String?>(autoCategoryGroup),
      'metaLogo': serializer.toJson<String?>(metaLogo),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TransactionRow copyWith({
    String? id,
    String? accountId,
    String? connectionId,
    String? date,
    String? description,
    double? amount,
    Value<double?> balance = const Value.absent(),
    String? type,
    Value<String?> merchantName = const Value.absent(),
    Value<String?> categoryName = const Value.absent(),
    Value<String?> categoryGroup = const Value.absent(),
    Value<String?> autoCategoryName = const Value.absent(),
    Value<String?> autoCategoryGroup = const Value.absent(),
    Value<String?> metaLogo = const Value.absent(),
    DateTime? updatedAt,
  }) => TransactionRow(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    connectionId: connectionId ?? this.connectionId,
    date: date ?? this.date,
    description: description ?? this.description,
    amount: amount ?? this.amount,
    balance: balance.present ? balance.value : this.balance,
    type: type ?? this.type,
    merchantName: merchantName.present ? merchantName.value : this.merchantName,
    categoryName: categoryName.present ? categoryName.value : this.categoryName,
    categoryGroup: categoryGroup.present
        ? categoryGroup.value
        : this.categoryGroup,
    autoCategoryName: autoCategoryName.present
        ? autoCategoryName.value
        : this.autoCategoryName,
    autoCategoryGroup: autoCategoryGroup.present
        ? autoCategoryGroup.value
        : this.autoCategoryGroup,
    metaLogo: metaLogo.present ? metaLogo.value : this.metaLogo,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  TransactionRow copyWithCompanion(TransactionsCompanion data) {
    return TransactionRow(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      connectionId: data.connectionId.present
          ? data.connectionId.value
          : this.connectionId,
      date: data.date.present ? data.date.value : this.date,
      description: data.description.present
          ? data.description.value
          : this.description,
      amount: data.amount.present ? data.amount.value : this.amount,
      balance: data.balance.present ? data.balance.value : this.balance,
      type: data.type.present ? data.type.value : this.type,
      merchantName: data.merchantName.present
          ? data.merchantName.value
          : this.merchantName,
      categoryName: data.categoryName.present
          ? data.categoryName.value
          : this.categoryName,
      categoryGroup: data.categoryGroup.present
          ? data.categoryGroup.value
          : this.categoryGroup,
      autoCategoryName: data.autoCategoryName.present
          ? data.autoCategoryName.value
          : this.autoCategoryName,
      autoCategoryGroup: data.autoCategoryGroup.present
          ? data.autoCategoryGroup.value
          : this.autoCategoryGroup,
      metaLogo: data.metaLogo.present ? data.metaLogo.value : this.metaLogo,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionRow(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('connectionId: $connectionId, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('amount: $amount, ')
          ..write('balance: $balance, ')
          ..write('type: $type, ')
          ..write('merchantName: $merchantName, ')
          ..write('categoryName: $categoryName, ')
          ..write('categoryGroup: $categoryGroup, ')
          ..write('autoCategoryName: $autoCategoryName, ')
          ..write('autoCategoryGroup: $autoCategoryGroup, ')
          ..write('metaLogo: $metaLogo, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    accountId,
    connectionId,
    date,
    description,
    amount,
    balance,
    type,
    merchantName,
    categoryName,
    categoryGroup,
    autoCategoryName,
    autoCategoryGroup,
    metaLogo,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionRow &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.connectionId == this.connectionId &&
          other.date == this.date &&
          other.description == this.description &&
          other.amount == this.amount &&
          other.balance == this.balance &&
          other.type == this.type &&
          other.merchantName == this.merchantName &&
          other.categoryName == this.categoryName &&
          other.categoryGroup == this.categoryGroup &&
          other.autoCategoryName == this.autoCategoryName &&
          other.autoCategoryGroup == this.autoCategoryGroup &&
          other.metaLogo == this.metaLogo &&
          other.updatedAt == this.updatedAt);
}

class TransactionsCompanion extends UpdateCompanion<TransactionRow> {
  final Value<String> id;
  final Value<String> accountId;
  final Value<String> connectionId;
  final Value<String> date;
  final Value<String> description;
  final Value<double> amount;
  final Value<double?> balance;
  final Value<String> type;
  final Value<String?> merchantName;
  final Value<String?> categoryName;
  final Value<String?> categoryGroup;
  final Value<String?> autoCategoryName;
  final Value<String?> autoCategoryGroup;
  final Value<String?> metaLogo;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.connectionId = const Value.absent(),
    this.date = const Value.absent(),
    this.description = const Value.absent(),
    this.amount = const Value.absent(),
    this.balance = const Value.absent(),
    this.type = const Value.absent(),
    this.merchantName = const Value.absent(),
    this.categoryName = const Value.absent(),
    this.categoryGroup = const Value.absent(),
    this.autoCategoryName = const Value.absent(),
    this.autoCategoryGroup = const Value.absent(),
    this.metaLogo = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionsCompanion.insert({
    required String id,
    required String accountId,
    required String connectionId,
    required String date,
    required String description,
    required double amount,
    this.balance = const Value.absent(),
    required String type,
    this.merchantName = const Value.absent(),
    this.categoryName = const Value.absent(),
    this.categoryGroup = const Value.absent(),
    this.autoCategoryName = const Value.absent(),
    this.autoCategoryGroup = const Value.absent(),
    this.metaLogo = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       accountId = Value(accountId),
       connectionId = Value(connectionId),
       date = Value(date),
       description = Value(description),
       amount = Value(amount),
       type = Value(type),
       updatedAt = Value(updatedAt);
  static Insertable<TransactionRow> custom({
    Expression<String>? id,
    Expression<String>? accountId,
    Expression<String>? connectionId,
    Expression<String>? date,
    Expression<String>? description,
    Expression<double>? amount,
    Expression<double>? balance,
    Expression<String>? type,
    Expression<String>? merchantName,
    Expression<String>? categoryName,
    Expression<String>? categoryGroup,
    Expression<String>? autoCategoryName,
    Expression<String>? autoCategoryGroup,
    Expression<String>? metaLogo,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (connectionId != null) 'connection_id': connectionId,
      if (date != null) 'date': date,
      if (description != null) 'description': description,
      if (amount != null) 'amount': amount,
      if (balance != null) 'balance': balance,
      if (type != null) 'type': type,
      if (merchantName != null) 'merchant_name': merchantName,
      if (categoryName != null) 'category_name': categoryName,
      if (categoryGroup != null) 'category_group': categoryGroup,
      if (autoCategoryName != null) 'auto_category_name': autoCategoryName,
      if (autoCategoryGroup != null) 'auto_category_group': autoCategoryGroup,
      if (metaLogo != null) 'meta_logo': metaLogo,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionsCompanion copyWith({
    Value<String>? id,
    Value<String>? accountId,
    Value<String>? connectionId,
    Value<String>? date,
    Value<String>? description,
    Value<double>? amount,
    Value<double?>? balance,
    Value<String>? type,
    Value<String?>? merchantName,
    Value<String?>? categoryName,
    Value<String?>? categoryGroup,
    Value<String?>? autoCategoryName,
    Value<String?>? autoCategoryGroup,
    Value<String?>? metaLogo,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return TransactionsCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      connectionId: connectionId ?? this.connectionId,
      date: date ?? this.date,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      balance: balance ?? this.balance,
      type: type ?? this.type,
      merchantName: merchantName ?? this.merchantName,
      categoryName: categoryName ?? this.categoryName,
      categoryGroup: categoryGroup ?? this.categoryGroup,
      autoCategoryName: autoCategoryName ?? this.autoCategoryName,
      autoCategoryGroup: autoCategoryGroup ?? this.autoCategoryGroup,
      metaLogo: metaLogo ?? this.metaLogo,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (connectionId.present) {
      map['connection_id'] = Variable<String>(connectionId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (balance.present) {
      map['balance'] = Variable<double>(balance.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (merchantName.present) {
      map['merchant_name'] = Variable<String>(merchantName.value);
    }
    if (categoryName.present) {
      map['category_name'] = Variable<String>(categoryName.value);
    }
    if (categoryGroup.present) {
      map['category_group'] = Variable<String>(categoryGroup.value);
    }
    if (autoCategoryName.present) {
      map['auto_category_name'] = Variable<String>(autoCategoryName.value);
    }
    if (autoCategoryGroup.present) {
      map['auto_category_group'] = Variable<String>(autoCategoryGroup.value);
    }
    if (metaLogo.present) {
      map['meta_logo'] = Variable<String>(metaLogo.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('connectionId: $connectionId, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('amount: $amount, ')
          ..write('balance: $balance, ')
          ..write('type: $type, ')
          ..write('merchantName: $merchantName, ')
          ..write('categoryName: $categoryName, ')
          ..write('categoryGroup: $categoryGroup, ')
          ..write('autoCategoryName: $autoCategoryName, ')
          ..write('autoCategoryGroup: $autoCategoryGroup, ')
          ..write('metaLogo: $metaLogo, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoryOverridesTable extends CategoryOverrides
    with TableInfo<$CategoryOverridesTable, CategoryOverride> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryOverridesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _transactionIdMeta = const VerificationMeta(
    'transactionId',
  );
  @override
  late final GeneratedColumn<String> transactionId = GeneratedColumn<String>(
    'transaction_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryNameMeta = const VerificationMeta(
    'categoryName',
  );
  @override
  late final GeneratedColumn<String> categoryName = GeneratedColumn<String>(
    'category_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryGroupMeta = const VerificationMeta(
    'categoryGroup',
  );
  @override
  late final GeneratedColumn<String> categoryGroup = GeneratedColumn<String>(
    'category_group',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    transactionId,
    categoryName,
    categoryGroup,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category_overrides';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoryOverride> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('transaction_id')) {
      context.handle(
        _transactionIdMeta,
        transactionId.isAcceptableOrUnknown(
          data['transaction_id']!,
          _transactionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionIdMeta);
    }
    if (data.containsKey('category_name')) {
      context.handle(
        _categoryNameMeta,
        categoryName.isAcceptableOrUnknown(
          data['category_name']!,
          _categoryNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_categoryNameMeta);
    }
    if (data.containsKey('category_group')) {
      context.handle(
        _categoryGroupMeta,
        categoryGroup.isAcceptableOrUnknown(
          data['category_group']!,
          _categoryGroupMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {transactionId};
  @override
  CategoryOverride map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryOverride(
      transactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_id'],
      )!,
      categoryName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_name'],
      )!,
      categoryGroup: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_group'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CategoryOverridesTable createAlias(String alias) {
    return $CategoryOverridesTable(attachedDatabase, alias);
  }
}

class CategoryOverride extends DataClass
    implements Insertable<CategoryOverride> {
  final String transactionId;
  final String categoryName;
  final String? categoryGroup;
  final DateTime updatedAt;
  const CategoryOverride({
    required this.transactionId,
    required this.categoryName,
    this.categoryGroup,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['transaction_id'] = Variable<String>(transactionId);
    map['category_name'] = Variable<String>(categoryName);
    if (!nullToAbsent || categoryGroup != null) {
      map['category_group'] = Variable<String>(categoryGroup);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CategoryOverridesCompanion toCompanion(bool nullToAbsent) {
    return CategoryOverridesCompanion(
      transactionId: Value(transactionId),
      categoryName: Value(categoryName),
      categoryGroup: categoryGroup == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryGroup),
      updatedAt: Value(updatedAt),
    );
  }

  factory CategoryOverride.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryOverride(
      transactionId: serializer.fromJson<String>(json['transactionId']),
      categoryName: serializer.fromJson<String>(json['categoryName']),
      categoryGroup: serializer.fromJson<String?>(json['categoryGroup']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'transactionId': serializer.toJson<String>(transactionId),
      'categoryName': serializer.toJson<String>(categoryName),
      'categoryGroup': serializer.toJson<String?>(categoryGroup),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CategoryOverride copyWith({
    String? transactionId,
    String? categoryName,
    Value<String?> categoryGroup = const Value.absent(),
    DateTime? updatedAt,
  }) => CategoryOverride(
    transactionId: transactionId ?? this.transactionId,
    categoryName: categoryName ?? this.categoryName,
    categoryGroup: categoryGroup.present
        ? categoryGroup.value
        : this.categoryGroup,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CategoryOverride copyWithCompanion(CategoryOverridesCompanion data) {
    return CategoryOverride(
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      categoryName: data.categoryName.present
          ? data.categoryName.value
          : this.categoryName,
      categoryGroup: data.categoryGroup.present
          ? data.categoryGroup.value
          : this.categoryGroup,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryOverride(')
          ..write('transactionId: $transactionId, ')
          ..write('categoryName: $categoryName, ')
          ..write('categoryGroup: $categoryGroup, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(transactionId, categoryName, categoryGroup, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryOverride &&
          other.transactionId == this.transactionId &&
          other.categoryName == this.categoryName &&
          other.categoryGroup == this.categoryGroup &&
          other.updatedAt == this.updatedAt);
}

class CategoryOverridesCompanion extends UpdateCompanion<CategoryOverride> {
  final Value<String> transactionId;
  final Value<String> categoryName;
  final Value<String?> categoryGroup;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CategoryOverridesCompanion({
    this.transactionId = const Value.absent(),
    this.categoryName = const Value.absent(),
    this.categoryGroup = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoryOverridesCompanion.insert({
    required String transactionId,
    required String categoryName,
    this.categoryGroup = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : transactionId = Value(transactionId),
       categoryName = Value(categoryName),
       updatedAt = Value(updatedAt);
  static Insertable<CategoryOverride> custom({
    Expression<String>? transactionId,
    Expression<String>? categoryName,
    Expression<String>? categoryGroup,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (transactionId != null) 'transaction_id': transactionId,
      if (categoryName != null) 'category_name': categoryName,
      if (categoryGroup != null) 'category_group': categoryGroup,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoryOverridesCompanion copyWith({
    Value<String>? transactionId,
    Value<String>? categoryName,
    Value<String?>? categoryGroup,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CategoryOverridesCompanion(
      transactionId: transactionId ?? this.transactionId,
      categoryName: categoryName ?? this.categoryName,
      categoryGroup: categoryGroup ?? this.categoryGroup,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (transactionId.present) {
      map['transaction_id'] = Variable<String>(transactionId.value);
    }
    if (categoryName.present) {
      map['category_name'] = Variable<String>(categoryName.value);
    }
    if (categoryGroup.present) {
      map['category_group'] = Variable<String>(categoryGroup.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryOverridesCompanion(')
          ..write('transactionId: $transactionId, ')
          ..write('categoryName: $categoryName, ')
          ..write('categoryGroup: $categoryGroup, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoryRulesTable extends CategoryRules
    with TableInfo<$CategoryRulesTable, CategoryRule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _matchTextMeta = const VerificationMeta(
    'matchText',
  );
  @override
  late final GeneratedColumn<String> matchText = GeneratedColumn<String>(
    'match_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryNameMeta = const VerificationMeta(
    'categoryName',
  );
  @override
  late final GeneratedColumn<String> categoryName = GeneratedColumn<String>(
    'category_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryGroupMeta = const VerificationMeta(
    'categoryGroup',
  );
  @override
  late final GeneratedColumn<String> categoryGroup = GeneratedColumn<String>(
    'category_group',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    matchText,
    categoryName,
    categoryGroup,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoryRule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('match_text')) {
      context.handle(
        _matchTextMeta,
        matchText.isAcceptableOrUnknown(data['match_text']!, _matchTextMeta),
      );
    } else if (isInserting) {
      context.missing(_matchTextMeta);
    }
    if (data.containsKey('category_name')) {
      context.handle(
        _categoryNameMeta,
        categoryName.isAcceptableOrUnknown(
          data['category_name']!,
          _categoryNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_categoryNameMeta);
    }
    if (data.containsKey('category_group')) {
      context.handle(
        _categoryGroupMeta,
        categoryGroup.isAcceptableOrUnknown(
          data['category_group']!,
          _categoryGroupMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryRule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryRule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      matchText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}match_text'],
      )!,
      categoryName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_name'],
      )!,
      categoryGroup: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_group'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CategoryRulesTable createAlias(String alias) {
    return $CategoryRulesTable(attachedDatabase, alias);
  }
}

class CategoryRule extends DataClass implements Insertable<CategoryRule> {
  final String id;
  final String matchText;
  final String categoryName;
  final String? categoryGroup;
  final DateTime createdAt;
  const CategoryRule({
    required this.id,
    required this.matchText,
    required this.categoryName,
    this.categoryGroup,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['match_text'] = Variable<String>(matchText);
    map['category_name'] = Variable<String>(categoryName);
    if (!nullToAbsent || categoryGroup != null) {
      map['category_group'] = Variable<String>(categoryGroup);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CategoryRulesCompanion toCompanion(bool nullToAbsent) {
    return CategoryRulesCompanion(
      id: Value(id),
      matchText: Value(matchText),
      categoryName: Value(categoryName),
      categoryGroup: categoryGroup == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryGroup),
      createdAt: Value(createdAt),
    );
  }

  factory CategoryRule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryRule(
      id: serializer.fromJson<String>(json['id']),
      matchText: serializer.fromJson<String>(json['matchText']),
      categoryName: serializer.fromJson<String>(json['categoryName']),
      categoryGroup: serializer.fromJson<String?>(json['categoryGroup']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'matchText': serializer.toJson<String>(matchText),
      'categoryName': serializer.toJson<String>(categoryName),
      'categoryGroup': serializer.toJson<String?>(categoryGroup),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CategoryRule copyWith({
    String? id,
    String? matchText,
    String? categoryName,
    Value<String?> categoryGroup = const Value.absent(),
    DateTime? createdAt,
  }) => CategoryRule(
    id: id ?? this.id,
    matchText: matchText ?? this.matchText,
    categoryName: categoryName ?? this.categoryName,
    categoryGroup: categoryGroup.present
        ? categoryGroup.value
        : this.categoryGroup,
    createdAt: createdAt ?? this.createdAt,
  );
  CategoryRule copyWithCompanion(CategoryRulesCompanion data) {
    return CategoryRule(
      id: data.id.present ? data.id.value : this.id,
      matchText: data.matchText.present ? data.matchText.value : this.matchText,
      categoryName: data.categoryName.present
          ? data.categoryName.value
          : this.categoryName,
      categoryGroup: data.categoryGroup.present
          ? data.categoryGroup.value
          : this.categoryGroup,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryRule(')
          ..write('id: $id, ')
          ..write('matchText: $matchText, ')
          ..write('categoryName: $categoryName, ')
          ..write('categoryGroup: $categoryGroup, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, matchText, categoryName, categoryGroup, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryRule &&
          other.id == this.id &&
          other.matchText == this.matchText &&
          other.categoryName == this.categoryName &&
          other.categoryGroup == this.categoryGroup &&
          other.createdAt == this.createdAt);
}

class CategoryRulesCompanion extends UpdateCompanion<CategoryRule> {
  final Value<String> id;
  final Value<String> matchText;
  final Value<String> categoryName;
  final Value<String?> categoryGroup;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const CategoryRulesCompanion({
    this.id = const Value.absent(),
    this.matchText = const Value.absent(),
    this.categoryName = const Value.absent(),
    this.categoryGroup = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoryRulesCompanion.insert({
    required String id,
    required String matchText,
    required String categoryName,
    this.categoryGroup = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       matchText = Value(matchText),
       categoryName = Value(categoryName),
       createdAt = Value(createdAt);
  static Insertable<CategoryRule> custom({
    Expression<String>? id,
    Expression<String>? matchText,
    Expression<String>? categoryName,
    Expression<String>? categoryGroup,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (matchText != null) 'match_text': matchText,
      if (categoryName != null) 'category_name': categoryName,
      if (categoryGroup != null) 'category_group': categoryGroup,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoryRulesCompanion copyWith({
    Value<String>? id,
    Value<String>? matchText,
    Value<String>? categoryName,
    Value<String?>? categoryGroup,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return CategoryRulesCompanion(
      id: id ?? this.id,
      matchText: matchText ?? this.matchText,
      categoryName: categoryName ?? this.categoryName,
      categoryGroup: categoryGroup ?? this.categoryGroup,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (matchText.present) {
      map['match_text'] = Variable<String>(matchText.value);
    }
    if (categoryName.present) {
      map['category_name'] = Variable<String>(categoryName.value);
    }
    if (categoryGroup.present) {
      map['category_group'] = Variable<String>(categoryGroup.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryRulesCompanion(')
          ..write('id: $id, ')
          ..write('matchText: $matchText, ')
          ..write('categoryName: $categoryName, ')
          ..write('categoryGroup: $categoryGroup, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ImageRulesTable extends ImageRules
    with TableInfo<$ImageRulesTable, ImageRule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ImageRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _matchTextMeta = const VerificationMeta(
    'matchText',
  );
  @override
  late final GeneratedColumn<String> matchText = GeneratedColumn<String>(
    'match_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exactMeta = const VerificationMeta('exact');
  @override
  late final GeneratedColumn<bool> exact = GeneratedColumn<bool>(
    'exact',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("exact" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    matchText,
    exact,
    imagePath,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'image_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<ImageRule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('match_text')) {
      context.handle(
        _matchTextMeta,
        matchText.isAcceptableOrUnknown(data['match_text']!, _matchTextMeta),
      );
    } else if (isInserting) {
      context.missing(_matchTextMeta);
    }
    if (data.containsKey('exact')) {
      context.handle(
        _exactMeta,
        exact.isAcceptableOrUnknown(data['exact']!, _exactMeta),
      );
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ImageRule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ImageRule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      matchText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}match_text'],
      )!,
      exact: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}exact'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ImageRulesTable createAlias(String alias) {
    return $ImageRulesTable(attachedDatabase, alias);
  }
}

class ImageRule extends DataClass implements Insertable<ImageRule> {
  final String id;
  final String matchText;
  final bool exact;
  final String imagePath;
  final DateTime createdAt;
  const ImageRule({
    required this.id,
    required this.matchText,
    required this.exact,
    required this.imagePath,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['match_text'] = Variable<String>(matchText);
    map['exact'] = Variable<bool>(exact);
    map['image_path'] = Variable<String>(imagePath);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ImageRulesCompanion toCompanion(bool nullToAbsent) {
    return ImageRulesCompanion(
      id: Value(id),
      matchText: Value(matchText),
      exact: Value(exact),
      imagePath: Value(imagePath),
      createdAt: Value(createdAt),
    );
  }

  factory ImageRule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ImageRule(
      id: serializer.fromJson<String>(json['id']),
      matchText: serializer.fromJson<String>(json['matchText']),
      exact: serializer.fromJson<bool>(json['exact']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'matchText': serializer.toJson<String>(matchText),
      'exact': serializer.toJson<bool>(exact),
      'imagePath': serializer.toJson<String>(imagePath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ImageRule copyWith({
    String? id,
    String? matchText,
    bool? exact,
    String? imagePath,
    DateTime? createdAt,
  }) => ImageRule(
    id: id ?? this.id,
    matchText: matchText ?? this.matchText,
    exact: exact ?? this.exact,
    imagePath: imagePath ?? this.imagePath,
    createdAt: createdAt ?? this.createdAt,
  );
  ImageRule copyWithCompanion(ImageRulesCompanion data) {
    return ImageRule(
      id: data.id.present ? data.id.value : this.id,
      matchText: data.matchText.present ? data.matchText.value : this.matchText,
      exact: data.exact.present ? data.exact.value : this.exact,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ImageRule(')
          ..write('id: $id, ')
          ..write('matchText: $matchText, ')
          ..write('exact: $exact, ')
          ..write('imagePath: $imagePath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, matchText, exact, imagePath, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ImageRule &&
          other.id == this.id &&
          other.matchText == this.matchText &&
          other.exact == this.exact &&
          other.imagePath == this.imagePath &&
          other.createdAt == this.createdAt);
}

class ImageRulesCompanion extends UpdateCompanion<ImageRule> {
  final Value<String> id;
  final Value<String> matchText;
  final Value<bool> exact;
  final Value<String> imagePath;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ImageRulesCompanion({
    this.id = const Value.absent(),
    this.matchText = const Value.absent(),
    this.exact = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ImageRulesCompanion.insert({
    required String id,
    required String matchText,
    this.exact = const Value.absent(),
    required String imagePath,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       matchText = Value(matchText),
       imagePath = Value(imagePath),
       createdAt = Value(createdAt);
  static Insertable<ImageRule> custom({
    Expression<String>? id,
    Expression<String>? matchText,
    Expression<bool>? exact,
    Expression<String>? imagePath,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (matchText != null) 'match_text': matchText,
      if (exact != null) 'exact': exact,
      if (imagePath != null) 'image_path': imagePath,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ImageRulesCompanion copyWith({
    Value<String>? id,
    Value<String>? matchText,
    Value<bool>? exact,
    Value<String>? imagePath,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ImageRulesCompanion(
      id: id ?? this.id,
      matchText: matchText ?? this.matchText,
      exact: exact ?? this.exact,
      imagePath: imagePath ?? this.imagePath,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (matchText.present) {
      map['match_text'] = Variable<String>(matchText.value);
    }
    if (exact.present) {
      map['exact'] = Variable<bool>(exact.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImageRulesCompanion(')
          ..write('id: $id, ')
          ..write('matchText: $matchText, ')
          ..write('exact: $exact, ')
          ..write('imagePath: $imagePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AccountsTable accounts = $AccountsTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $CategoryOverridesTable categoryOverrides =
      $CategoryOverridesTable(this);
  late final $CategoryRulesTable categoryRules = $CategoryRulesTable(this);
  late final $ImageRulesTable imageRules = $ImageRulesTable(this);
  late final Index transactionsDate = Index(
    'transactions_date',
    'CREATE INDEX transactions_date ON transactions (date DESC)',
  );
  late final Index transactionsAccountDate = Index(
    'transactions_account_date',
    'CREATE INDEX transactions_account_date ON transactions (account_id, date DESC)',
  );
  late final Index transactionsSpendingDate = Index(
    'transactions_spending_date',
    'CREATE INDEX transactions_spending_date ON transactions (date DESC) WHERE amount < 0',
  );
  late final Index categoryRulesCreatedAt = Index(
    'category_rules_created_at',
    'CREATE INDEX category_rules_created_at ON category_rules (created_at DESC)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    accounts,
    transactions,
    categoryOverrides,
    categoryRules,
    imageRules,
    transactionsDate,
    transactionsAccountDate,
    transactionsSpendingDate,
    categoryRulesCreatedAt,
  ];
}

typedef $$AccountsTableCreateCompanionBuilder =
    AccountsCompanion Function({
      required String id,
      required String name,
      required String status,
      required String type,
      required String attributes,
      Value<String?> formattedAccount,
      Value<String?> connectionId,
      Value<String?> connectionName,
      Value<String?> connectionLogo,
      Value<String?> connectionType,
      Value<double?> balanceCurrent,
      Value<double?> balanceAvailable,
      Value<double?> balanceLimit,
      Value<bool> balanceOverdrawn,
      Value<String?> holder,
      Value<String?> refreshedBalance,
      Value<String?> refreshedMeta,
      Value<String?> refreshedTransactions,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$AccountsTableUpdateCompanionBuilder =
    AccountsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> status,
      Value<String> type,
      Value<String> attributes,
      Value<String?> formattedAccount,
      Value<String?> connectionId,
      Value<String?> connectionName,
      Value<String?> connectionLogo,
      Value<String?> connectionType,
      Value<double?> balanceCurrent,
      Value<double?> balanceAvailable,
      Value<double?> balanceLimit,
      Value<bool> balanceOverdrawn,
      Value<String?> holder,
      Value<String?> refreshedBalance,
      Value<String?> refreshedMeta,
      Value<String?> refreshedTransactions,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$AccountsTableFilterComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attributes => $composableBuilder(
    column: $table.attributes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get formattedAccount => $composableBuilder(
    column: $table.formattedAccount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get connectionId => $composableBuilder(
    column: $table.connectionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get connectionName => $composableBuilder(
    column: $table.connectionName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get connectionLogo => $composableBuilder(
    column: $table.connectionLogo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get connectionType => $composableBuilder(
    column: $table.connectionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get balanceCurrent => $composableBuilder(
    column: $table.balanceCurrent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get balanceAvailable => $composableBuilder(
    column: $table.balanceAvailable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get balanceLimit => $composableBuilder(
    column: $table.balanceLimit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get balanceOverdrawn => $composableBuilder(
    column: $table.balanceOverdrawn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get holder => $composableBuilder(
    column: $table.holder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get refreshedBalance => $composableBuilder(
    column: $table.refreshedBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get refreshedMeta => $composableBuilder(
    column: $table.refreshedMeta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get refreshedTransactions => $composableBuilder(
    column: $table.refreshedTransactions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attributes => $composableBuilder(
    column: $table.attributes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get formattedAccount => $composableBuilder(
    column: $table.formattedAccount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get connectionId => $composableBuilder(
    column: $table.connectionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get connectionName => $composableBuilder(
    column: $table.connectionName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get connectionLogo => $composableBuilder(
    column: $table.connectionLogo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get connectionType => $composableBuilder(
    column: $table.connectionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get balanceCurrent => $composableBuilder(
    column: $table.balanceCurrent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get balanceAvailable => $composableBuilder(
    column: $table.balanceAvailable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get balanceLimit => $composableBuilder(
    column: $table.balanceLimit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get balanceOverdrawn => $composableBuilder(
    column: $table.balanceOverdrawn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get holder => $composableBuilder(
    column: $table.holder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get refreshedBalance => $composableBuilder(
    column: $table.refreshedBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get refreshedMeta => $composableBuilder(
    column: $table.refreshedMeta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get refreshedTransactions => $composableBuilder(
    column: $table.refreshedTransactions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get attributes => $composableBuilder(
    column: $table.attributes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get formattedAccount => $composableBuilder(
    column: $table.formattedAccount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get connectionId => $composableBuilder(
    column: $table.connectionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get connectionName => $composableBuilder(
    column: $table.connectionName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get connectionLogo => $composableBuilder(
    column: $table.connectionLogo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get connectionType => $composableBuilder(
    column: $table.connectionType,
    builder: (column) => column,
  );

  GeneratedColumn<double> get balanceCurrent => $composableBuilder(
    column: $table.balanceCurrent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get balanceAvailable => $composableBuilder(
    column: $table.balanceAvailable,
    builder: (column) => column,
  );

  GeneratedColumn<double> get balanceLimit => $composableBuilder(
    column: $table.balanceLimit,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get balanceOverdrawn => $composableBuilder(
    column: $table.balanceOverdrawn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get holder =>
      $composableBuilder(column: $table.holder, builder: (column) => column);

  GeneratedColumn<String> get refreshedBalance => $composableBuilder(
    column: $table.refreshedBalance,
    builder: (column) => column,
  );

  GeneratedColumn<String> get refreshedMeta => $composableBuilder(
    column: $table.refreshedMeta,
    builder: (column) => column,
  );

  GeneratedColumn<String> get refreshedTransactions => $composableBuilder(
    column: $table.refreshedTransactions,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AccountsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AccountsTable,
          AccountRow,
          $$AccountsTableFilterComposer,
          $$AccountsTableOrderingComposer,
          $$AccountsTableAnnotationComposer,
          $$AccountsTableCreateCompanionBuilder,
          $$AccountsTableUpdateCompanionBuilder,
          (
            AccountRow,
            BaseReferences<_$AppDatabase, $AccountsTable, AccountRow>,
          ),
          AccountRow,
          PrefetchHooks Function()
        > {
  $$AccountsTableTableManager(_$AppDatabase db, $AccountsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> attributes = const Value.absent(),
                Value<String?> formattedAccount = const Value.absent(),
                Value<String?> connectionId = const Value.absent(),
                Value<String?> connectionName = const Value.absent(),
                Value<String?> connectionLogo = const Value.absent(),
                Value<String?> connectionType = const Value.absent(),
                Value<double?> balanceCurrent = const Value.absent(),
                Value<double?> balanceAvailable = const Value.absent(),
                Value<double?> balanceLimit = const Value.absent(),
                Value<bool> balanceOverdrawn = const Value.absent(),
                Value<String?> holder = const Value.absent(),
                Value<String?> refreshedBalance = const Value.absent(),
                Value<String?> refreshedMeta = const Value.absent(),
                Value<String?> refreshedTransactions = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AccountsCompanion(
                id: id,
                name: name,
                status: status,
                type: type,
                attributes: attributes,
                formattedAccount: formattedAccount,
                connectionId: connectionId,
                connectionName: connectionName,
                connectionLogo: connectionLogo,
                connectionType: connectionType,
                balanceCurrent: balanceCurrent,
                balanceAvailable: balanceAvailable,
                balanceLimit: balanceLimit,
                balanceOverdrawn: balanceOverdrawn,
                holder: holder,
                refreshedBalance: refreshedBalance,
                refreshedMeta: refreshedMeta,
                refreshedTransactions: refreshedTransactions,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String status,
                required String type,
                required String attributes,
                Value<String?> formattedAccount = const Value.absent(),
                Value<String?> connectionId = const Value.absent(),
                Value<String?> connectionName = const Value.absent(),
                Value<String?> connectionLogo = const Value.absent(),
                Value<String?> connectionType = const Value.absent(),
                Value<double?> balanceCurrent = const Value.absent(),
                Value<double?> balanceAvailable = const Value.absent(),
                Value<double?> balanceLimit = const Value.absent(),
                Value<bool> balanceOverdrawn = const Value.absent(),
                Value<String?> holder = const Value.absent(),
                Value<String?> refreshedBalance = const Value.absent(),
                Value<String?> refreshedMeta = const Value.absent(),
                Value<String?> refreshedTransactions = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => AccountsCompanion.insert(
                id: id,
                name: name,
                status: status,
                type: type,
                attributes: attributes,
                formattedAccount: formattedAccount,
                connectionId: connectionId,
                connectionName: connectionName,
                connectionLogo: connectionLogo,
                connectionType: connectionType,
                balanceCurrent: balanceCurrent,
                balanceAvailable: balanceAvailable,
                balanceLimit: balanceLimit,
                balanceOverdrawn: balanceOverdrawn,
                holder: holder,
                refreshedBalance: refreshedBalance,
                refreshedMeta: refreshedMeta,
                refreshedTransactions: refreshedTransactions,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AccountsTable,
      AccountRow,
      $$AccountsTableFilterComposer,
      $$AccountsTableOrderingComposer,
      $$AccountsTableAnnotationComposer,
      $$AccountsTableCreateCompanionBuilder,
      $$AccountsTableUpdateCompanionBuilder,
      (AccountRow, BaseReferences<_$AppDatabase, $AccountsTable, AccountRow>),
      AccountRow,
      PrefetchHooks Function()
    >;
typedef $$TransactionsTableCreateCompanionBuilder =
    TransactionsCompanion Function({
      required String id,
      required String accountId,
      required String connectionId,
      required String date,
      required String description,
      required double amount,
      Value<double?> balance,
      required String type,
      Value<String?> merchantName,
      Value<String?> categoryName,
      Value<String?> categoryGroup,
      Value<String?> autoCategoryName,
      Value<String?> autoCategoryGroup,
      Value<String?> metaLogo,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$TransactionsTableUpdateCompanionBuilder =
    TransactionsCompanion Function({
      Value<String> id,
      Value<String> accountId,
      Value<String> connectionId,
      Value<String> date,
      Value<String> description,
      Value<double> amount,
      Value<double?> balance,
      Value<String> type,
      Value<String?> merchantName,
      Value<String?> categoryName,
      Value<String?> categoryGroup,
      Value<String?> autoCategoryName,
      Value<String?> autoCategoryGroup,
      Value<String?> metaLogo,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get connectionId => $composableBuilder(
    column: $table.connectionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get merchantName => $composableBuilder(
    column: $table.merchantName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryName => $composableBuilder(
    column: $table.categoryName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryGroup => $composableBuilder(
    column: $table.categoryGroup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get autoCategoryName => $composableBuilder(
    column: $table.autoCategoryName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get autoCategoryGroup => $composableBuilder(
    column: $table.autoCategoryGroup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metaLogo => $composableBuilder(
    column: $table.metaLogo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get connectionId => $composableBuilder(
    column: $table.connectionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get merchantName => $composableBuilder(
    column: $table.merchantName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryName => $composableBuilder(
    column: $table.categoryName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryGroup => $composableBuilder(
    column: $table.categoryGroup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get autoCategoryName => $composableBuilder(
    column: $table.autoCategoryName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get autoCategoryGroup => $composableBuilder(
    column: $table.autoCategoryGroup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metaLogo => $composableBuilder(
    column: $table.metaLogo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<String> get connectionId => $composableBuilder(
    column: $table.connectionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<double> get balance =>
      $composableBuilder(column: $table.balance, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get merchantName => $composableBuilder(
    column: $table.merchantName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryName => $composableBuilder(
    column: $table.categoryName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryGroup => $composableBuilder(
    column: $table.categoryGroup,
    builder: (column) => column,
  );

  GeneratedColumn<String> get autoCategoryName => $composableBuilder(
    column: $table.autoCategoryName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get autoCategoryGroup => $composableBuilder(
    column: $table.autoCategoryGroup,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metaLogo =>
      $composableBuilder(column: $table.metaLogo, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$TransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionsTable,
          TransactionRow,
          $$TransactionsTableFilterComposer,
          $$TransactionsTableOrderingComposer,
          $$TransactionsTableAnnotationComposer,
          $$TransactionsTableCreateCompanionBuilder,
          $$TransactionsTableUpdateCompanionBuilder,
          (
            TransactionRow,
            BaseReferences<_$AppDatabase, $TransactionsTable, TransactionRow>,
          ),
          TransactionRow,
          PrefetchHooks Function()
        > {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<String> connectionId = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<double?> balance = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> merchantName = const Value.absent(),
                Value<String?> categoryName = const Value.absent(),
                Value<String?> categoryGroup = const Value.absent(),
                Value<String?> autoCategoryName = const Value.absent(),
                Value<String?> autoCategoryGroup = const Value.absent(),
                Value<String?> metaLogo = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion(
                id: id,
                accountId: accountId,
                connectionId: connectionId,
                date: date,
                description: description,
                amount: amount,
                balance: balance,
                type: type,
                merchantName: merchantName,
                categoryName: categoryName,
                categoryGroup: categoryGroup,
                autoCategoryName: autoCategoryName,
                autoCategoryGroup: autoCategoryGroup,
                metaLogo: metaLogo,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String accountId,
                required String connectionId,
                required String date,
                required String description,
                required double amount,
                Value<double?> balance = const Value.absent(),
                required String type,
                Value<String?> merchantName = const Value.absent(),
                Value<String?> categoryName = const Value.absent(),
                Value<String?> categoryGroup = const Value.absent(),
                Value<String?> autoCategoryName = const Value.absent(),
                Value<String?> autoCategoryGroup = const Value.absent(),
                Value<String?> metaLogo = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion.insert(
                id: id,
                accountId: accountId,
                connectionId: connectionId,
                date: date,
                description: description,
                amount: amount,
                balance: balance,
                type: type,
                merchantName: merchantName,
                categoryName: categoryName,
                categoryGroup: categoryGroup,
                autoCategoryName: autoCategoryName,
                autoCategoryGroup: autoCategoryGroup,
                metaLogo: metaLogo,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionsTable,
      TransactionRow,
      $$TransactionsTableFilterComposer,
      $$TransactionsTableOrderingComposer,
      $$TransactionsTableAnnotationComposer,
      $$TransactionsTableCreateCompanionBuilder,
      $$TransactionsTableUpdateCompanionBuilder,
      (
        TransactionRow,
        BaseReferences<_$AppDatabase, $TransactionsTable, TransactionRow>,
      ),
      TransactionRow,
      PrefetchHooks Function()
    >;
typedef $$CategoryOverridesTableCreateCompanionBuilder =
    CategoryOverridesCompanion Function({
      required String transactionId,
      required String categoryName,
      Value<String?> categoryGroup,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$CategoryOverridesTableUpdateCompanionBuilder =
    CategoryOverridesCompanion Function({
      Value<String> transactionId,
      Value<String> categoryName,
      Value<String?> categoryGroup,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$CategoryOverridesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoryOverridesTable> {
  $$CategoryOverridesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryName => $composableBuilder(
    column: $table.categoryName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryGroup => $composableBuilder(
    column: $table.categoryGroup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CategoryOverridesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoryOverridesTable> {
  $$CategoryOverridesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryName => $composableBuilder(
    column: $table.categoryName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryGroup => $composableBuilder(
    column: $table.categoryGroup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoryOverridesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoryOverridesTable> {
  $$CategoryOverridesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryName => $composableBuilder(
    column: $table.categoryName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryGroup => $composableBuilder(
    column: $table.categoryGroup,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CategoryOverridesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoryOverridesTable,
          CategoryOverride,
          $$CategoryOverridesTableFilterComposer,
          $$CategoryOverridesTableOrderingComposer,
          $$CategoryOverridesTableAnnotationComposer,
          $$CategoryOverridesTableCreateCompanionBuilder,
          $$CategoryOverridesTableUpdateCompanionBuilder,
          (
            CategoryOverride,
            BaseReferences<
              _$AppDatabase,
              $CategoryOverridesTable,
              CategoryOverride
            >,
          ),
          CategoryOverride,
          PrefetchHooks Function()
        > {
  $$CategoryOverridesTableTableManager(
    _$AppDatabase db,
    $CategoryOverridesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoryOverridesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoryOverridesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoryOverridesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> transactionId = const Value.absent(),
                Value<String> categoryName = const Value.absent(),
                Value<String?> categoryGroup = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoryOverridesCompanion(
                transactionId: transactionId,
                categoryName: categoryName,
                categoryGroup: categoryGroup,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String transactionId,
                required String categoryName,
                Value<String?> categoryGroup = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CategoryOverridesCompanion.insert(
                transactionId: transactionId,
                categoryName: categoryName,
                categoryGroup: categoryGroup,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CategoryOverridesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoryOverridesTable,
      CategoryOverride,
      $$CategoryOverridesTableFilterComposer,
      $$CategoryOverridesTableOrderingComposer,
      $$CategoryOverridesTableAnnotationComposer,
      $$CategoryOverridesTableCreateCompanionBuilder,
      $$CategoryOverridesTableUpdateCompanionBuilder,
      (
        CategoryOverride,
        BaseReferences<
          _$AppDatabase,
          $CategoryOverridesTable,
          CategoryOverride
        >,
      ),
      CategoryOverride,
      PrefetchHooks Function()
    >;
typedef $$CategoryRulesTableCreateCompanionBuilder =
    CategoryRulesCompanion Function({
      required String id,
      required String matchText,
      required String categoryName,
      Value<String?> categoryGroup,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$CategoryRulesTableUpdateCompanionBuilder =
    CategoryRulesCompanion Function({
      Value<String> id,
      Value<String> matchText,
      Value<String> categoryName,
      Value<String?> categoryGroup,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$CategoryRulesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoryRulesTable> {
  $$CategoryRulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get matchText => $composableBuilder(
    column: $table.matchText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryName => $composableBuilder(
    column: $table.categoryName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryGroup => $composableBuilder(
    column: $table.categoryGroup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CategoryRulesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoryRulesTable> {
  $$CategoryRulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get matchText => $composableBuilder(
    column: $table.matchText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryName => $composableBuilder(
    column: $table.categoryName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryGroup => $composableBuilder(
    column: $table.categoryGroup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoryRulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoryRulesTable> {
  $$CategoryRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get matchText =>
      $composableBuilder(column: $table.matchText, builder: (column) => column);

  GeneratedColumn<String> get categoryName => $composableBuilder(
    column: $table.categoryName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryGroup => $composableBuilder(
    column: $table.categoryGroup,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CategoryRulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoryRulesTable,
          CategoryRule,
          $$CategoryRulesTableFilterComposer,
          $$CategoryRulesTableOrderingComposer,
          $$CategoryRulesTableAnnotationComposer,
          $$CategoryRulesTableCreateCompanionBuilder,
          $$CategoryRulesTableUpdateCompanionBuilder,
          (
            CategoryRule,
            BaseReferences<_$AppDatabase, $CategoryRulesTable, CategoryRule>,
          ),
          CategoryRule,
          PrefetchHooks Function()
        > {
  $$CategoryRulesTableTableManager(_$AppDatabase db, $CategoryRulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoryRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoryRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoryRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> matchText = const Value.absent(),
                Value<String> categoryName = const Value.absent(),
                Value<String?> categoryGroup = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoryRulesCompanion(
                id: id,
                matchText: matchText,
                categoryName: categoryName,
                categoryGroup: categoryGroup,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String matchText,
                required String categoryName,
                Value<String?> categoryGroup = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => CategoryRulesCompanion.insert(
                id: id,
                matchText: matchText,
                categoryName: categoryName,
                categoryGroup: categoryGroup,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CategoryRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoryRulesTable,
      CategoryRule,
      $$CategoryRulesTableFilterComposer,
      $$CategoryRulesTableOrderingComposer,
      $$CategoryRulesTableAnnotationComposer,
      $$CategoryRulesTableCreateCompanionBuilder,
      $$CategoryRulesTableUpdateCompanionBuilder,
      (
        CategoryRule,
        BaseReferences<_$AppDatabase, $CategoryRulesTable, CategoryRule>,
      ),
      CategoryRule,
      PrefetchHooks Function()
    >;
typedef $$ImageRulesTableCreateCompanionBuilder =
    ImageRulesCompanion Function({
      required String id,
      required String matchText,
      Value<bool> exact,
      required String imagePath,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$ImageRulesTableUpdateCompanionBuilder =
    ImageRulesCompanion Function({
      Value<String> id,
      Value<String> matchText,
      Value<bool> exact,
      Value<String> imagePath,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$ImageRulesTableFilterComposer
    extends Composer<_$AppDatabase, $ImageRulesTable> {
  $$ImageRulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get matchText => $composableBuilder(
    column: $table.matchText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get exact => $composableBuilder(
    column: $table.exact,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ImageRulesTableOrderingComposer
    extends Composer<_$AppDatabase, $ImageRulesTable> {
  $$ImageRulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get matchText => $composableBuilder(
    column: $table.matchText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get exact => $composableBuilder(
    column: $table.exact,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ImageRulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ImageRulesTable> {
  $$ImageRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get matchText =>
      $composableBuilder(column: $table.matchText, builder: (column) => column);

  GeneratedColumn<bool> get exact =>
      $composableBuilder(column: $table.exact, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ImageRulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ImageRulesTable,
          ImageRule,
          $$ImageRulesTableFilterComposer,
          $$ImageRulesTableOrderingComposer,
          $$ImageRulesTableAnnotationComposer,
          $$ImageRulesTableCreateCompanionBuilder,
          $$ImageRulesTableUpdateCompanionBuilder,
          (
            ImageRule,
            BaseReferences<_$AppDatabase, $ImageRulesTable, ImageRule>,
          ),
          ImageRule,
          PrefetchHooks Function()
        > {
  $$ImageRulesTableTableManager(_$AppDatabase db, $ImageRulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ImageRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ImageRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ImageRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> matchText = const Value.absent(),
                Value<bool> exact = const Value.absent(),
                Value<String> imagePath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ImageRulesCompanion(
                id: id,
                matchText: matchText,
                exact: exact,
                imagePath: imagePath,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String matchText,
                Value<bool> exact = const Value.absent(),
                required String imagePath,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => ImageRulesCompanion.insert(
                id: id,
                matchText: matchText,
                exact: exact,
                imagePath: imagePath,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ImageRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ImageRulesTable,
      ImageRule,
      $$ImageRulesTableFilterComposer,
      $$ImageRulesTableOrderingComposer,
      $$ImageRulesTableAnnotationComposer,
      $$ImageRulesTableCreateCompanionBuilder,
      $$ImageRulesTableUpdateCompanionBuilder,
      (ImageRule, BaseReferences<_$AppDatabase, $ImageRulesTable, ImageRule>),
      ImageRule,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db, _db.accounts);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
  $$CategoryOverridesTableTableManager get categoryOverrides =>
      $$CategoryOverridesTableTableManager(_db, _db.categoryOverrides);
  $$CategoryRulesTableTableManager get categoryRules =>
      $$CategoryRulesTableTableManager(_db, _db.categoryRules);
  $$ImageRulesTableTableManager get imageRules =>
      $$ImageRulesTableTableManager(_db, _db.imageRules);
}
