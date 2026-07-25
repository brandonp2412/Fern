import 'package:drift/drift.dart';

import 'connection/connection.dart';

part 'app_database.g.dart';

/// Local cache of the last-fetched accounts, used as an offline fallback and
/// as a standing backup of the user's data.
class CachedAccounts extends Table {
  TextColumn get id => text()();
  TextColumn get json => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local cache of the last-fetched transactions, keyed by transaction id.
class CachedTransactions extends Table {
  TextColumn get id => text()();
  TextColumn get accountId => text()();
  TextColumn get json => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// User-chosen category overrides for transactions, since the Akahu API has
/// no endpoint for writing a transaction's category directly.
class CategoryOverrides extends Table {
  TextColumn get transactionId => text()();
  TextColumn get categoryId => text()();
  TextColumn get categoryName => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {transactionId};
}

@DriftDatabase(tables: [CachedAccounts, CachedTransactions, CategoryOverrides])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  Future<void> saveAccounts(Map<String, String> idToJson) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(
        cachedAccounts,
        idToJson.entries
            .map((e) => CachedAccountsCompanion.insert(
                  id: e.key,
                  json: e.value,
                  updatedAt: DateTime.now(),
                ))
            .toList(),
      );
    });
  }

  Future<List<String>> loadAccountsJson() async {
    final rows = await select(cachedAccounts).get();
    return rows.map((r) => r.json).toList();
  }

  Future<void> saveTransactions(
      List<({String id, String accountId, String json})> items) async {
    if (items.isEmpty) return;
    await batch((batch) {
      batch.insertAllOnConflictUpdate(
        cachedTransactions,
        items
            .map((e) => CachedTransactionsCompanion.insert(
                  id: e.id,
                  accountId: e.accountId,
                  json: e.json,
                  updatedAt: DateTime.now(),
                ))
            .toList(),
      );
    });
  }

  Future<List<String>> loadTransactionsJson({String? accountId, int limit = 200}) async {
    final query = select(cachedTransactions);
    if (accountId != null) {
      query.where((t) => t.accountId.equals(accountId));
    }
    query
      ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)])
      ..limit(limit);
    final rows = await query.get();
    return rows.map((r) => r.json).toList();
  }

  Future<void> setCategoryOverride(
      String transactionId, String categoryId, String categoryName) {
    return into(categoryOverrides).insertOnConflictUpdate(
      CategoryOverridesCompanion.insert(
        transactionId: transactionId,
        categoryId: categoryId,
        categoryName: categoryName,
        updatedAt: DateTime.now(),
      ),
    );
  }

  Future<void> clearCategoryOverride(String transactionId) {
    return (delete(categoryOverrides)
          ..where((t) => t.transactionId.equals(transactionId)))
        .go();
  }

  Future<Map<String, CategoryOverride>> loadCategoryOverrides() async {
    final rows = await select(categoryOverrides).get();
    return {for (final r in rows) r.transactionId: r};
  }

  Future<void> clearAll() async {
    await batch((batch) {
      batch.deleteAll(cachedAccounts);
      batch.deleteAll(cachedTransactions);
    });
  }
}
