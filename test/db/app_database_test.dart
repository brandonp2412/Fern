import 'dart:convert';

import 'package:fern/db/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fixtures.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = testDb();
  });

  tearDown(() async {
    await db.close();
  });

  group('accounts', () {
    test('saveAccounts writes real account JSON that watchAccountsJson streams back', () async {
      final anz = anzEveryday();
      final asb = asbStreamline();
      await db.saveAccounts({
        anz.id: json.encode(anz.toJson()),
        asb.id: json.encode(asb.toJson()),
      });

      final rows = await db.watchAccountsJson().first;
      final names = rows.map((r) => json.decode(r)['name']).toSet();
      expect(names, {'ANZ Everyday', 'ASB Streamline'});
    });

    test('saving an account twice with the same id updates rather than duplicates', () async {
      final anz = anzEveryday(balance: 100.0);
      await db.saveAccounts({anz.id: json.encode(anz.toJson())});

      final updated = anzEveryday(balance: 999.99);
      await db.saveAccounts({updated.id: json.encode(updated.toJson())});

      final rows = await db.watchAccountsJson().first;
      expect(rows, hasLength(1));
      expect(json.decode(rows.first)['balance']['current'], 999.99);
    });
  });

  group('transactions', () {
    test('saveTransactions writes real merchant JSON that watchTransactionsJson streams back', () async {
      final mcdonalds = mcdonaldsBurger();
      final uber = uberTrip();
      await db.saveTransactions([
        (id: mcdonalds.id, accountId: mcdonalds.account, json: json.encode(mcdonalds.toJson())),
        (id: uber.id, accountId: uber.account, json: json.encode(uber.toJson())),
      ]);

      final rows = await db.watchTransactionsJson().first;
      final merchants = rows.map((r) => json.decode(r)['merchant']?['name']).toSet();
      expect(merchants, {"McDonald's", 'Uber'});
    });

    test('watchTransactionsJson filters to a single account by id', () async {
      final anzTxn = mcdonaldsBurger(account: 'acc_anz_everyday');
      final asbTxn = netflixSubscription(account: 'acc_asb_streamline');
      await db.saveTransactions([
        (id: anzTxn.id, accountId: anzTxn.account, json: json.encode(anzTxn.toJson())),
        (id: asbTxn.id, accountId: asbTxn.account, json: json.encode(asbTxn.toJson())),
      ]);

      final asbRows = await db.watchTransactionsJson(accountId: 'acc_asb_streamline').first;
      expect(asbRows, hasLength(1));
      expect(json.decode(asbRows.first)['merchant']['name'], 'Netflix');
    });

    test('watchTransactionsJson respects the limit', () async {
      final txns = sampleTransactions();
      await db.saveTransactions([
        for (final t in txns) (id: t.id, accountId: t.account, json: json.encode(t.toJson())),
      ]);

      final limited = await db.watchTransactionsJson(limit: 2).first;
      expect(limited, hasLength(2));
    });
  });

  group('category overrides', () {
    test('saveCategoryOverride then loadCategoryOverrides returns the real category name', () async {
      final tx = mcdonaldsBurger();
      await db.saveCategoryOverride(tx.id, 'Cafes and restaurants');

      final overrides = await db.loadCategoryOverrides();
      expect(overrides[tx.id]?.categoryName, 'Cafes and restaurants');
    });

    test('saving a second override for the same transaction replaces the first', () async {
      final tx = mcdonaldsBurger();
      await db.saveCategoryOverride(tx.id, 'Fast food stores');
      await db.saveCategoryOverride(tx.id, 'Cafes and restaurants');

      final overrides = await db.loadCategoryOverrides();
      expect(overrides, hasLength(1));
      expect(overrides[tx.id]?.categoryName, 'Cafes and restaurants');
    });

    test('clearCategoryOverride removes it', () async {
      final tx = mcdonaldsBurger();
      await db.saveCategoryOverride(tx.id, 'Cafes and restaurants');
      await db.clearCategoryOverride(tx.id);

      final overrides = await db.loadCategoryOverrides();
      expect(overrides, isEmpty);
    });
  });

  group('clearAll', () {
    test('removes cached accounts and transactions', () async {
      final anz = anzEveryday();
      final mcdonalds = mcdonaldsBurger();
      await db.saveAccounts({anz.id: json.encode(anz.toJson())});
      await db.saveTransactions([
        (id: mcdonalds.id, accountId: mcdonalds.account, json: json.encode(mcdonalds.toJson())),
      ]);

      await db.clearAll();

      expect(await db.watchAccountsJson().first, isEmpty);
      expect(await db.watchTransactionsJson().first, isEmpty);
    });
  });
}
