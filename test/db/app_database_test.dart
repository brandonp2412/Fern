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
    test('saveAccounts writes real account data that watchAccounts streams back', () async {
      final anz = anzEveryday();
      final asb = asbStreamline();
      await db.saveAccounts([anz, asb]);

      final rows = await db.watchAccounts().first;
      final names = rows.map((a) => a.name).toSet();
      expect(names, {'ANZ Everyday', 'ASB Streamline'});
    });

    test('saving an account twice with the same id updates rather than duplicates', () async {
      final anz = anzEveryday(balance: 100.0);
      await db.saveAccounts([anz]);

      final updated = anzEveryday(balance: 999.99);
      await db.saveAccounts([updated]);

      final rows = await db.watchAccounts().first;
      expect(rows, hasLength(1));
      expect(rows.first.balance?.current, 999.99);
    });
  });

  group('transactions', () {
    test('saveTransactions writes real merchant data that watchTransactions streams back', () async {
      final mcdonalds = mcdonaldsBurger();
      final uber = uberTrip();
      await db.saveTransactions([mcdonalds, uber]);

      final rows = await db.watchTransactions().first;
      final merchants = rows.map((t) => t.merchant?.name).toSet();
      expect(merchants, {"McDonald's", 'Uber'});
    });

    test('watchTransactions filters to a single account by id', () async {
      final anzTxn = mcdonaldsBurger(account: 'acc_anz_everyday');
      final asbTxn = netflixSubscription(account: 'acc_asb_streamline');
      await db.saveTransactions([anzTxn, asbTxn]);

      final asbRows = await db.watchTransactions(accountId: 'acc_asb_streamline').first;
      expect(asbRows, hasLength(1));
      expect(asbRows.first.merchant?.name, 'Netflix');
    });

    test('watchTransactions respects the limit', () async {
      final txns = sampleTransactions();
      await db.saveTransactions(txns);

      final limited = await db.watchTransactions(limit: 2).first;
      expect(limited, hasLength(2));
    });
  });

  group('category overrides', () {
    test('saveCategoryOverride then loadCategoryOverrides returns the real category name', () async {
      final tx = mcdonaldsBurger();
      await db.saveCategoryOverride(tx.id, 'Cafes and restaurants', 'Lifestyle');

      final overrides = await db.loadCategoryOverrides();
      expect(overrides[tx.id]?.categoryName, 'Cafes and restaurants');
    });

    test('saving a second override for the same transaction replaces the first', () async {
      final tx = mcdonaldsBurger();
      await db.saveCategoryOverride(tx.id, 'Fast food stores', 'Lifestyle');
      await db.saveCategoryOverride(tx.id, 'Cafes and restaurants', 'Lifestyle');

      final overrides = await db.loadCategoryOverrides();
      expect(overrides, hasLength(1));
      expect(overrides[tx.id]?.categoryName, 'Cafes and restaurants');
    });

    test('clearCategoryOverride removes it', () async {
      final tx = mcdonaldsBurger();
      await db.saveCategoryOverride(tx.id, 'Cafes and restaurants', 'Lifestyle');
      await db.clearCategoryOverride(tx.id);

      final overrides = await db.loadCategoryOverrides();
      expect(overrides, isEmpty);
    });
  });

  group('clearAll', () {
    test('removes accounts and transactions', () async {
      final anz = anzEveryday();
      final mcdonalds = mcdonaldsBurger();
      await db.saveAccounts([anz]);
      await db.saveTransactions([mcdonalds]);

      await db.clearAll();

      expect(await db.watchAccounts().first, isEmpty);
      expect(await db.watchTransactions().first, isEmpty);
    });
  });
}
