import 'dart:convert';

import 'package:drift/drift.dart';

import '../models/account.dart';
import '../models/transaction.dart';
import '../services/auto_categorizer.dart';
import 'app_database.steps.dart';
import 'connection/connection.dart';

part 'app_database.g.dart';

@DataClassName('AccountRow')
class Accounts extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get status => text()();
  TextColumn get type => text()();
  TextColumn get attributes => text()();
  TextColumn get formattedAccount => text().nullable()();
  TextColumn get connectionId => text().nullable()();
  TextColumn get connectionName => text().nullable()();
  TextColumn get connectionLogo => text().nullable()();
  TextColumn get connectionType => text().nullable()();
  RealColumn get balanceCurrent => real().nullable()();
  RealColumn get balanceAvailable => real().nullable()();
  RealColumn get balanceLimit => real().nullable()();
  BoolColumn get balanceOverdrawn =>
      boolean().withDefault(const Constant(false))();
  TextColumn get holder => text().nullable()();
  TextColumn get refreshedBalance => text().nullable()();
  TextColumn get refreshedMeta => text().nullable()();
  TextColumn get refreshedTransactions => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('TransactionRow')
class Transactions extends Table {
  TextColumn get id => text()();
  TextColumn get accountId => text()();
  TextColumn get connectionId => text()();
  TextColumn get date => text()();
  TextColumn get description => text()();
  RealColumn get amount => real()();
  RealColumn get balance => real().nullable()();
  TextColumn get type => text()();
  TextColumn get merchantName => text().nullable()();
  TextColumn get categoryName => text().nullable()();
  TextColumn get categoryGroup => text().nullable()();
  TextColumn get autoCategoryName => text().nullable()();
  TextColumn get autoCategoryGroup => text().nullable()();
  TextColumn get metaLogo => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class CategoryOverrides extends Table {
  TextColumn get transactionId => text()();
  TextColumn get categoryName => text()();
  TextColumn get categoryGroup => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {transactionId};
}

@DataClassName('CategoryRule')
class CategoryRules extends Table {
  TextColumn get id => text()();
  TextColumn get matchText => text()();
  TextColumn get categoryName => text()();
  TextColumn get categoryGroup => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class TransactionImages extends Table {
  TextColumn get transactionId => text()();
  TextColumn get imagePath => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {transactionId};
}

@DriftDatabase(
  tables: [
    Accounts,
    Transactions,
    CategoryOverrides,
    CategoryRules,
    TransactionImages,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? openConnection());
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: stepByStep(
      from1To2: (m, schema) async {
        await m.deleteTable('cached_accounts');
        await m.deleteTable('cached_transactions');
        await m.createTable(schema.accounts);
        await m.createTable(schema.transactions);
        await m.addColumn(
          schema.categoryOverrides,
          schema.categoryOverrides.categoryGroup,
        );
        await m.database.customStatement(
          'ALTER TABLE category_overrides DROP COLUMN category_id',
        );
      },
      from2To3: (m, schema) async {
        await m.addColumn(schema.transactions, schema.transactions.metaLogo);
      },
      from3To4: (m, schema) async {
        final columns = await m.database
            .customSelect("PRAGMA table_info(category_overrides)")
            .get();
        if (columns.any((row) => row.data['name'] == 'category_id')) {
          await m.database.customStatement(
            'ALTER TABLE category_overrides DROP COLUMN category_id',
          );
        }
      },
      from4To5: (m, schema) async {
        await m.createTable(schema.categoryRules);
      },
      from5To6: (m, schema) async {
        await m.createTable(schema.transactionImages);
      },
    ),
  );

  Future<void> saveAccounts(List<Account> list) async {
    if (list.isEmpty) return;
    final now = DateTime.now();
    await batch((batch) {
      batch.insertAllOnConflictUpdate(
        accounts,
        list
            .map(
              (a) => AccountsCompanion.insert(
                id: a.id,
                name: a.name,
                status: a.status,
                type: a.type,
                attributes: json.encode(a.attributes),
                formattedAccount: Value(a.formattedAccount),
                connectionId: Value(a.connection?.id),
                connectionName: Value(a.connection?.name),
                connectionLogo: Value(a.connection?.logo),
                connectionType: Value(a.connection?.connectionType),
                balanceCurrent: Value(a.balance?.current?.toDouble()),
                balanceAvailable: Value(a.balance?.available?.toDouble()),
                balanceLimit: Value(a.balance?.limit?.toDouble()),
                balanceOverdrawn: Value(a.balance?.overdrawn ?? false),
                holder: Value(a.holder),
                refreshedBalance: Value(a.refreshed?.balance),
                refreshedMeta: Value(a.refreshed?.meta),
                refreshedTransactions: Value(a.refreshed?.transactions),
                updatedAt: now,
              ),
            )
            .toList(),
      );
    });
  }

  Stream<List<Account>> watchAccounts() => select(accounts).watch().map((rows) {
    return rows.map((r) {
      return Account(
        id: r.id,
        name: r.name,
        status: r.status,
        type: r.type,
        attributes: (json.decode(r.attributes) as List<dynamic>)
            .map((e) => e.toString())
            .toList(),
        formattedAccount: r.formattedAccount,
        connection: r.connectionId != null
            ? AccountConnection(
                id: r.connectionId!,
                name: r.connectionName ?? '',
                logo: r.connectionLogo ?? '',
                connectionType: r.connectionType,
              )
            : null,
        balance: AccountBalance(
          current: r.balanceCurrent,
          available: r.balanceAvailable,
          limit: r.balanceLimit,
          overdrawn: r.balanceOverdrawn,
        ),
        holder: r.holder,
        refreshed: AccountRefreshed(
          balance: r.refreshedBalance,
          meta: r.refreshedMeta,
          transactions: r.refreshedTransactions,
        ),
      );
    }).toList();
  });

  Future<void> saveTransactions(List<Transaction> txns) async {
    if (txns.isEmpty) return;
    final now = DateTime.now();
    await batch((batch) {
      batch.insertAllOnConflictUpdate(
        transactions,
        txns.map((t) {
          var autoName = t.autoCategoryName;
          var autoGroup = t.autoCategoryGroup;
          if (autoName == null) {
            final auto = AutoCategorizer.categorize(t);
            if (auto != null) {
              autoName = auto.name;
              autoGroup = auto.group;
            }
          }
          return TransactionsCompanion.insert(
            id: t.id,
            accountId: t.account,
            connectionId: t.connection,
            date: t.date,
            description: t.description,
            amount: t.amount.toDouble(),
            balance: Value(t.balance?.toDouble()),
            type: t.type,
            merchantName: Value(t.merchant?.name),
            categoryName: Value(t.category?.name),
            categoryGroup: Value(t.category?.groupName),
            autoCategoryName: Value(autoName),
            autoCategoryGroup: Value(autoGroup),
            metaLogo: Value(t.meta?.logo),
            updatedAt: now,
          );
        }).toList(),
      );
    });
  }

  Stream<List<Transaction>> watchTransactions({
    String? accountId,
    int limit = 2000,
  }) {
    final query = select(transactions);
    if (accountId != null) {
      query.where((t) => t.accountId.equals(accountId));
    }
    query
      ..orderBy([(t) => OrderingTerm.desc(t.date)])
      ..limit(limit);
    return query.watch().map((rows) {
      return rows.map((r) {
        return Transaction(
          id: r.id,
          account: r.accountId,
          connection: r.connectionId,
          date: r.date,
          description: r.description,
          amount: r.amount,
          balance: r.balance,
          type: r.type,
          merchant: r.merchantName != null
              ? TransactionMerchant(name: r.merchantName)
              : null,
          category: r.categoryName != null
              ? TransactionCategory(
                  id: '',
                  name: r.categoryName!,
                  groups: r.categoryGroup != null
                      ? {
                          'personal_finance': CategoryGroup(
                            id: '',
                            name: r.categoryGroup!,
                          ),
                        }
                      : {},
                )
              : null,
          meta: r.metaLogo != null ? TransactionMeta(logo: r.metaLogo) : null,
          autoCategoryName: r.autoCategoryName,
          autoCategoryGroup: r.autoCategoryGroup,
        );
      }).toList();
    });
  }

  Future<void> saveCategoryOverride(
    String transactionId,
    String categoryName,
    String? categoryGroup,
  ) {
    return into(categoryOverrides).insertOnConflictUpdate(
      CategoryOverridesCompanion.insert(
        transactionId: transactionId,
        categoryName: categoryName,
        categoryGroup: Value(categoryGroup),
        updatedAt: DateTime.now(),
      ),
    );
  }

  Future<void> saveCategoryOverrides(
    List<String> transactionIds,
    String categoryName,
    String? categoryGroup,
  ) async {
    final now = DateTime.now();
    await batch((batch) {
      batch.insertAllOnConflictUpdate(categoryOverrides, [
        for (final id in transactionIds)
          CategoryOverridesCompanion.insert(
            transactionId: id,
            categoryName: categoryName,
            categoryGroup: Value(categoryGroup),
            updatedAt: now,
          ),
      ]);
    });
  }

  Future<void> clearCategoryOverride(String transactionId) {
    return (delete(
      categoryOverrides,
    )..where((t) => t.transactionId.equals(transactionId))).go();
  }

  Future<Map<String, CategoryOverride>> loadCategoryOverrides() async {
    final rows = await select(categoryOverrides).get();
    return {for (final r in rows) r.transactionId: r};
  }

  Future<void> saveCategoryRule(
    String matchText,
    String categoryName,
    String? categoryGroup,
  ) {
    return into(categoryRules).insert(
      CategoryRulesCompanion.insert(
        id: '${DateTime.now().microsecondsSinceEpoch}',
        matchText: matchText,
        categoryName: categoryName,
        categoryGroup: Value(categoryGroup),
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> deleteCategoryRule(String id) {
    return (delete(categoryRules)..where((t) => t.id.equals(id))).go();
  }

  Future<List<CategoryRule>> loadCategoryRules() {
    return (select(categoryRules)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<void> saveTransactionImage(String transactionId, String imagePath) {
    return into(transactionImages).insertOnConflictUpdate(
      TransactionImagesCompanion.insert(
        transactionId: transactionId,
        imagePath: imagePath,
        updatedAt: DateTime.now(),
      ),
    );
  }

  Future<void> clearTransactionImage(String transactionId) {
    return (delete(
      transactionImages,
    )..where((t) => t.transactionId.equals(transactionId))).go();
  }

  Future<Map<String, String>> loadTransactionImages() async {
    final rows = await select(transactionImages).get();
    return {for (final r in rows) r.transactionId: r.imagePath};
  }

  Stream<List<_StatRow>> _watchStat(
    String sql, {
    required Set<ResultSetImplementation> readsFrom,
  }) {
    return customSelect(sql, readsFrom: readsFrom).watch().map((rows) {
      return rows.map((row) => _StatRow(row.data)).toList();
    });
  }

  Stream<Map<String, (double, double)>> watchMonthlyTotals(int numMonths) {
    final now = DateTime.now();
    final first = DateTime(now.year, now.month - numMonths + 1, 1);
    final firstKey =
        '${first.year.toString().padLeft(4, '0')}-${first.month.toString().padLeft(2, '0')}';
    return _watchStat(
      'SELECT strftime(\'%Y-%m\', t.date, \'localtime\') AS k,'
      ' COALESCE(SUM(CASE WHEN t.amount >= 0 THEN CAST(t.amount AS REAL) ELSE 0 END), 0) AS income,'
      ' COALESCE(SUM(CASE WHEN t.amount < 0 THEN ABS(CAST(t.amount AS REAL)) ELSE 0 END), 0) AS expense'
      ' FROM transactions t'
      ' WHERE strftime(\'%Y-%m\', t.date, \'localtime\') >= \'$firstKey\''
      '${_excludeTransfersWhere()}'
      ' GROUP BY k ORDER BY k',
      readsFrom: {transactions, categoryOverrides},
    ).map((rows) {
      final map = <String, (double, double)>{};
      for (final r in rows) {
        final k = r.str('k');
        final income = r.dbl('income');
        final expense = r.dbl('expense');
        map[k] = (income, expense);
      }
      return map;
    });
  }

  Stream<Map<String, double>> watchCategoryTotals() {
    return _watchStat(
      'SELECT COALESCE(ov.category_group, ov.category_name, t.category_group, t.auto_category_group, \'Uncategorised\') AS k,'
      ' COALESCE(SUM(ABS(CAST(t.amount AS REAL))), 0) AS total'
      ' FROM transactions t'
      ' LEFT JOIN category_overrides ov ON ov.transaction_id = t.id'
      ' WHERE t.amount < 0'
      ' GROUP BY k'
      ' ORDER BY total DESC',
      readsFrom: {transactions, categoryOverrides},
    ).map((rows) {
      return {for (final r in rows) r.str('k'): r.dbl('total')};
    });
  }

  Stream<Map<String, double>> watchWeeklyTrend(int rangeDays) {
    final start = DateTime.now().subtract(Duration(days: rangeDays));
    final startDate =
        '${start.year.toString().padLeft(4, '0')}-${start.month.toString().padLeft(2, '0')}-${start.day.toString().padLeft(2, '0')}';
    return _watchStat(
      'SELECT date(date(t.date, \'localtime\'), \'-\' || ((strftime(\'%w\', date(t.date, \'localtime\')) + 6) % 7) || \' days\') AS k,'
      ' COALESCE(SUM(ABS(CAST(t.amount AS REAL))), 0) AS total'
      ' FROM transactions t'
      ' WHERE date(t.date, \'localtime\') >= \'$startDate\''
      ' AND t.amount < 0'
      ' GROUP BY k'
      ' ORDER BY k',
      readsFrom: {transactions},
    ).map((rows) {
      return {for (final r in rows) r.str('k'): r.dbl('total')};
    });
  }

  Stream<Map<String, double>> watchTopMerchants(int count) {
    return _watchStat(
      'SELECT COALESCE(t.merchant_name, t.description) AS k,'
      ' COALESCE(SUM(ABS(CAST(t.amount AS REAL))), 0) AS total'
      ' FROM transactions t'
      ' WHERE t.amount < 0'
      ' AND COALESCE(t.merchant_name, t.description) != \'\''
      ' GROUP BY k'
      ' ORDER BY total DESC'
      ' LIMIT $count',
      readsFrom: {transactions},
    ).map((rows) {
      return {for (final r in rows) r.str('k'): r.dbl('total')};
    });
  }

  Stream<Map<String, double>> watchMonthlySpendByGroup() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, 1).toUtc().toIso8601String();
    final end = DateTime(now.year, now.month + 1, 1).toUtc().toIso8601String();
    return _watchStat(
      'SELECT COALESCE(ov.category_group, ov.category_name, t.category_group, t.auto_category_group, \'Uncategorised\') AS k,'
      ' COALESCE(SUM(ABS(CAST(t.amount AS REAL))), 0) AS total'
      ' FROM transactions t'
      ' LEFT JOIN category_overrides ov ON ov.transaction_id = t.id'
      ' WHERE t.date >= \'$start\' AND t.date < \'$end\''
      ' AND t.amount < 0'
      ' GROUP BY k'
      ' ORDER BY total DESC'
      ' LIMIT 6',
      readsFrom: {transactions, categoryOverrides},
    ).map((rows) {
      return {for (final r in rows) r.str('k'): r.dbl('total')};
    });
  }

  String _fmtDate(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  String _dateWhere({DateTime? start, DateTime? end}) {
    final parts = <String>[];
    if (start != null) {
      parts.add('date(t.date, \'localtime\') >= \'${_fmtDate(start)}\'');
    }
    if (end != null) {
      parts.add('date(t.date, \'localtime\') <= \'${_fmtDate(end)}\'');
    }
    if (parts.isEmpty) return '1=1';
    return parts.join(' AND ');
  }

  String _categoryWhere({Set<String>? categoryFilter}) {
    if (categoryFilter == null || categoryFilter.isEmpty) return '';
    final expanded = <String>{...categoryFilter};
    for (final cat in categoryFilter) {
      final names = AutoCategorizer.categoriesByGroup[cat];
      if (names != null) expanded.addAll(names);
    }
    final list = expanded
        .map((c) => '\'${c.replaceAll("'", "''")}\'')
        .join(',');
    return ' AND t.id IN ('
        'SELECT tt.id FROM transactions tt'
        ' LEFT JOIN category_overrides oo ON oo.transaction_id = tt.id'
        ' WHERE COALESCE(oo.category_group, oo.category_name, tt.category_group, tt.auto_category_group, \'Uncategorised\') IN ($list)'
        ')';
  }

  // Transfers between the user's own accounts are not real income or
  // spending; if left in, a transfer's outflow and inflow each get summed
  // into "expense" and "income" separately (they never cancel out), so
  // moving money between accounts inflates both totals.
  String _excludeTransfersWhere() =>
      ' AND t.id NOT IN ('
      'SELECT tt.id FROM transactions tt'
      ' LEFT JOIN category_overrides oo ON oo.transaction_id = tt.id'
      ' WHERE COALESCE(oo.category_group, oo.category_name, tt.category_group, tt.auto_category_group, \'Uncategorised\') = \'Transfers\''
      ')';

  Stream<Map<String, (double, double)>> queryMonthlyTotals({
    DateTime? start,
    DateTime? end,
    Set<String>? categoryFilter,
  }) {
    final excludeTransfers = (categoryFilter == null || categoryFilter.isEmpty)
        ? _excludeTransfersWhere()
        : '';
    return _watchStat(
      'SELECT strftime(\'%Y-%m\', t.date, \'localtime\') AS k,'
      ' COALESCE(SUM(CASE WHEN t.amount >= 0 THEN CAST(t.amount AS REAL) ELSE 0 END), 0) AS income,'
      ' COALESCE(SUM(CASE WHEN t.amount < 0 THEN ABS(CAST(t.amount AS REAL)) ELSE 0 END), 0) AS expense'
      ' FROM transactions t'
      ' WHERE ${_dateWhere(start: start, end: end)}${_categoryWhere(categoryFilter: categoryFilter)}$excludeTransfers'
      ' GROUP BY k ORDER BY k',
      readsFrom: {transactions, categoryOverrides},
    ).map((rows) {
      final map = <String, (double, double)>{};
      for (final r in rows) {
        map[r.str('k')] = (r.dbl('income'), r.dbl('expense'));
      }
      return map;
    });
  }

  Stream<Map<String, double>> queryCategoryTotals({
    DateTime? start,
    DateTime? end,
    Set<String>? categoryFilter,
  }) {
    final where = start != null || end != null
        ? 'AND ${_dateWhere(start: start, end: end)}'
        : '';
    final catWhere = _categoryWhere(categoryFilter: categoryFilter);
    return _watchStat(
      'SELECT COALESCE(ov.category_group, ov.category_name, t.category_group, t.auto_category_group, \'Uncategorised\') AS k,'
      ' COALESCE(SUM(ABS(CAST(t.amount AS REAL))), 0) AS total'
      ' FROM transactions t'
      ' LEFT JOIN category_overrides ov ON ov.transaction_id = t.id'
      ' WHERE t.amount < 0 $where$catWhere'
      ' GROUP BY k'
      ' ORDER BY total DESC',
      readsFrom: {transactions, categoryOverrides},
    ).map((rows) {
      return {for (final r in rows) r.str('k'): r.dbl('total')};
    });
  }

  Stream<Map<String, double>> queryWeeklyTrend({
    DateTime? start,
    DateTime? end,
    Set<String>? categoryFilter,
  }) {
    final where = _dateWhere(start: start, end: end);
    final catWhere = _categoryWhere(categoryFilter: categoryFilter);
    return _watchStat(
      'SELECT date(date(t.date, \'localtime\'), \'-\' || ((strftime(\'%w\', date(t.date, \'localtime\')) + 6) % 7) || \' days\') AS k,'
      ' COALESCE(SUM(ABS(CAST(t.amount AS REAL))), 0) AS total'
      ' FROM transactions t'
      ' WHERE t.amount < 0 AND $where$catWhere'
      ' GROUP BY k'
      ' ORDER BY k',
      readsFrom: {transactions, categoryOverrides},
    ).map((rows) {
      return {for (final r in rows) r.str('k'): r.dbl('total')};
    });
  }

  Stream<Map<String, double>> queryTopMerchants({
    int count = 5,
    DateTime? start,
    DateTime? end,
    Set<String>? categoryFilter,
  }) {
    final where = _dateWhere(start: start, end: end);
    final catWhere = _categoryWhere(categoryFilter: categoryFilter);
    return _watchStat(
      'SELECT COALESCE(t.merchant_name, t.description) AS k,'
      ' COALESCE(SUM(ABS(CAST(t.amount AS REAL))), 0) AS total'
      ' FROM transactions t'
      ' WHERE t.amount < 0 AND $where$catWhere'
      ' AND COALESCE(t.merchant_name, t.description) != \'\''
      ' GROUP BY k'
      ' ORDER BY total DESC'
      ' LIMIT $count',
      readsFrom: {transactions, categoryOverrides},
    ).map((rows) {
      return {for (final r in rows) r.str('k'): r.dbl('total')};
    });
  }

  Future<void> clearAll() async {
    await batch((batch) {
      batch.deleteAll(accounts);
      batch.deleteAll(transactions);
      batch.deleteAll(categoryOverrides);
      batch.deleteAll(categoryRules);
      batch.deleteAll(transactionImages);
    });
  }
}

class _StatRow {
  final Map<String, dynamic> data;
  _StatRow(this.data);

  String str(String col) => (data[col] as String?) ?? '';
  double dbl(String col) => (data[col] as num?)?.toDouble() ?? 0;
}
