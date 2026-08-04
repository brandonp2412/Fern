import 'dart:io';
import 'package:drift/drift.dart' show DatabaseConnection;
import 'package:drift/native.dart';
import 'package:test/test.dart';
import 'package:fern/db/app_database.dart';
import 'package:fern/models/account.dart';
import 'package:fern/models/transaction.dart';
import 'package:fern/models/user.dart';
import 'package:fern/services/akahu_api.dart';

void main() {
  final userToken = Platform.environment['AKAHU_ACCESS_TOKEN'];
  final appToken = Platform.environment['AKAHU_APP_ID_TOKEN'];
  final hasCreds =
      userToken != null && userToken.isNotEmpty && appToken != null && appToken.isNotEmpty;

  group('Akahu API integration', skip: hasCreds ? null : 'no credentials', () {
    late AkahuApi api;

    setUp(() {
      api = AkahuApi(
        userToken: userToken!,
        appToken: appToken!,
      );
    });

    test('GET /me returns user', () async {
      final user = await api.getMe();
      expect(user.id, startsWith('user_'));
    });

    test('GET /accounts returns list', () async {
      final accounts = await api.getAccounts();
      expect(accounts, isNotEmpty);
      for (final a in accounts) {
        expect(a.id, startsWith('acc_'));
        expect(a.name, isNotEmpty);
        expect(a.type, isNotEmpty);
        if (a.connection != null) {
          expect(a.connection!.id, startsWith('conn_'));
        }
        if (a.balance != null) {
          expect(a.balance!.current, isNotNull);
        }
      }
    });

    test('GET /accounts/{id} returns one account', () async {
      final accounts = await api.getAccounts();
      final account = await api.getAccount(accounts.first.id);
      expect(account.id, accounts.first.id);
      expect(account.name, accounts.first.name);
    });

    test('GET /accounts/{id}/transactions pages with cursor', () async {
      final accounts = await api.getAccounts();
      final withTxns = accounts.where((a) => a.hasTransactions);
      if (withTxns.isEmpty) return;
      final page = await api.getAccountTransactions(withTxns.first.id,
          start: '2026-07-01', end: '2026-08-02');
      for (final tx in page.items) {
        expect(tx.id, startsWith('trans_'));
        expect(tx.account, startsWith('acc_'));
        expect(tx.date, isNotEmpty);
      }
      if (page.hasMore) {
        final page2 = await api.getAccountTransactions(withTxns.first.id,
            cursor: page.nextCursor);
        expect(page2.items, isNotEmpty);
      }
    });

    test('GET /accounts/{id}/transactions/pending', () async {
      final accounts = await api.getAccounts();
      final withTxns = accounts.where((a) => a.hasTransactions);
      if (withTxns.isEmpty) return;
      final pending =
          await api.getAccountPendingTransactions(withTxns.first.id);
      for (final p in pending) {
        expect(p.description, isNotEmpty);
        expect(p.type, isNotEmpty);
      }
    });

    test('GET /transactions returns cross-account txns', () async {
      final page = await api.getTransactions(start: '2026-07-01', end: '2026-08-02');
      expect(page.items, isNotEmpty);
      for (final tx in page.items) {
        expect(tx.id, startsWith('trans_'));
      }
    });

    test('GET /transactions respects start date', () async {
      final start = DateTime.now()
          .subtract(const Duration(days: 7))
          .toIso8601String()
          .substring(0, 10);
      final page = await api.getTransactions(start: start);
      for (final tx in page.items) {
        final date = DateTime.parse(tx.date);
        expect(date.isAfter(DateTime.parse(start).subtract(const Duration(days: 1))),
            isTrue);
      }
    });

    test('GET /transactions/pending returns pending txns', () async {
      final pending = await api.getPendingTransactions();
      expect(pending, isA<List<PendingTransaction>>());
    });

    test('GET /transactions/{id} returns single txn', () async {
      final page =
          await api.getTransactions(start: '2026-07-01', end: '2026-08-02');
      if (page.items.isEmpty) return;
      final tx = await api.getTransaction(page.items.first.id);
      expect(tx.id, page.items.first.id);
    });

    test('POST /transactions/ids fetches by ids', () async {
      final page =
          await api.getTransactions(start: '2026-07-01', end: '2026-08-02');
      if (page.items.length < 2) return;
      final ids = page.items.take(2).map((t) => t.id).toList();
      final txns = await api.getTransactionsByIds(ids);
      expect(txns.length, ids.length);
      expect(txns.map((t) => t.id).toSet(), ids.toSet());
    });

    test('POST /refresh requests a refresh', () async {
      await api.refreshAll();
    });

    test('POST /refresh/{id} refreshes one account', () async {
      final accounts = await api.getAccounts();
      await api.refresh(accounts.first.id);
    });

    test('API throws ApiException on bad auth', () async {
      final badApi = AkahuApi(userToken: 'bad_token', appToken: appToken!);
      expect(() => badApi.getAccounts(), throwsA(isA<ApiException>()));
    });

    // The three tests below pin themselves to a known window rather than
    // "the current month" or "today": transactions dated
    // 2026-07-31T12:00:00.000Z UTC are midnight NZST on 2026-08-01 —
    // i.e. their raw UTC date is July but their local date is August 1st.
    // Any query that buckets by raw UTC date instead of local date will
    // drop these into July and fail these assertions.
    //
    // In the 2026-07-29 … 2026-08-01 window, the four July-31-UTC
    // transactions categorise (via auto-categorizer) as:
    //   - Health: $0.00  (REDACTED_MERCHANT)
    //   - Transport: $0.00  (REDACTED_MERCHANT)
    //   - Food: $0.00  (REDACTED_MERCHANT)
    //   - Uncategorised: $0.00  (REDACTED_MERCHANT — no Akahu group, no auto match)
    //   (total expense $0.00)

    test(
      'Overview "spending this month" includes the Jul 31 UTC / Aug 1 NZST transactions',
      () async {
        final page =
            await api.getTransactions(start: '2026-07-29', end: '2026-08-01');

        final db = AppDatabase.forTesting(
          DatabaseConnection(
            NativeDatabase.memory(),
            closeStreamsSynchronously: true,
          ),
        );
        addTearDown(() => db.close());
        await db.saveTransactions(page.items);

        final grouped = await db.watchMonthlySpendByGroup().first;

        expect(grouped['Health'], closeTo(0.00, 0.01));
        expect(grouped['Transport'], closeTo(0.00, 0.01));
      },
    );

    test(
      'watchMonthlyTotals attributes the Jul 31 UTC / Aug 1 NZST transactions to August, not July',
      () async {
        final page =
            await api.getTransactions(start: '2026-07-29', end: '2026-08-01');

        final db = AppDatabase.forTesting(
          DatabaseConnection(
            NativeDatabase.memory(),
            closeStreamsSynchronously: true,
          ),
        );
        addTearDown(() => db.close());
        await db.saveTransactions(page.items);

        final monthly = await db.watchMonthlyTotals(2).first;

        expect(monthly['2026-08']?.$2, closeTo(0.00, 0.01));
      },
    );

    test(
      '_dateWhere-backed queries (queryCategoryTotals) attribute the Jul 31 UTC '
      'transactions to the Aug 1 local day',
      () async {
        final page =
            await api.getTransactions(start: '2026-07-29', end: '2026-08-01');

        final db = AppDatabase.forTesting(
          DatabaseConnection(
            NativeDatabase.memory(),
            closeStreamsSynchronously: true,
          ),
        );
        addTearDown(() => db.close());
        await db.saveTransactions(page.items);

        final categories =
            await db.queryCategoryTotals(start: DateTime(2026, 8, 1)).first;

        expect(categories['Health'], closeTo(0.00, 0.01));
        expect(categories['Transport'], closeTo(0.00, 0.01));
      },
    );
  });

  group('model parsing from raw JSON', () {
    test('Account', () {
      final account = Account.fromJson({
        '_id': 'acc_test123',
        'name': 'Test Account',
        'type': 'CHECKING',
        'status': 'ACTIVE',
        'attributes': ['TRANSACTIONS', 'PAYMENT_TO'],
        'formatted_account': '12-1234-1234567-00',
        'balance': {'currency': 'NZD', 'current': 1500.50, 'available': 1500.0},
        'connection': {
          '_id': 'conn_test',
          'name': 'Test Bank',
          'logo': 'https://example.com/logo.png',
        },
        'meta': {'holder': 'MR TEST'},
        'refreshed': {'balance': '2026-07-25T00:00:00.000Z'},
      });
      expect(account.id, 'acc_test123');
      expect(account.balance!.current, 1500.50);
      expect(account.connection!.name, 'Test Bank');
      expect(account.holder, 'MR TEST');
      expect(account.canPayTo, isTrue);
      expect(account.displayBalance, 1500.50);
    });

    test('credit account balance is shown negative', () {
      final account = Account.fromJson({
        '_id': 'acc_cc',
        'name': 'Visa',
        'type': 'CREDITCARD',
        'attributes': ['TRANSACTIONS'],
        'balance': {'currency': 'NZD', 'current': 500},
      });
      expect(account.isDebt, isTrue);
      expect(account.displayBalance, -500);
    });

    test('Transaction with enrichment', () {
      final tx = Transaction.fromJson({
        '_id': 'trans_test123',
        '_account': 'acc_test123',
        'date': '2026-07-24T12:00:00.000Z',
        'description': 'CARD 4506 MCDONALDS',
        'amount': -14.9,
        'balance': 64824.2,
        'type': 'EFTPOS',
        'merchant': {'_id': 'merchant_1', 'name': "McDonald's"},
        'category': {
          '_id': 'nzfcc_1',
          'name': 'Fast food',
          'groups': {
            'personal_finance': {'_id': 'group_1', 'name': 'Food & Drink'},
          },
        },
        'meta': {
          'particulars': 'abc',
          'card_suffix': '4506',
          'logo': 'https://example.com/m.png',
          'conversion': {'amount': 10, 'currency': 'USD', 'rate': 0.61},
        },
      });
      expect(tx.title, "McDonald's");
      expect(tx.category!.groupName, 'Food & Drink');
      expect(tx.meta!.cardSuffix, '4506');
      expect(tx.meta!.conversion!.currency, 'USD');
    });

    test('User', () {
      final user = User.fromJson({
        '_id': 'user_test123',
        'email': 'test@example.com',
        'access_granted_at': '2026-07-25T05:06:16.996Z',
      });
      expect(user.id, 'user_test123');
      expect(user.email, 'test@example.com');
    });
  });
}
