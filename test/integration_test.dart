import 'dart:io';
import 'package:test/test.dart';
import 'package:fern_money/models/account.dart';
import 'package:fern_money/models/transaction.dart';
import 'package:fern_money/models/user.dart';
import 'package:fern_money/services/akahu_api.dart';

void main() {
  final userToken = Platform.environment['AKAHU_ACCESS_TOKEN'];
  final appToken = Platform.environment['AKAHU_APP_ID_TOKEN'];

  group('Akahu API integration', () {
    late AkahuApi api;

    setUp(() {
      api = AkahuApi(
        userToken: userToken ?? '',
        appToken: appToken ?? '',
        appSecret: '',
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

    test('GET /accounts/{id}/transactions returns tx list', () async {
      final accounts = await api.getAccounts();
      final txns = await api.getAccountTransactions(accounts.first.id, limit: 3);
      expect(txns.length, lessThanOrEqualTo(3));
      for (final tx in txns) {
        expect(tx.id, startsWith('trans_'));
        expect(tx.account, startsWith('acc_'));
        expect(tx.description, isNotEmpty);
        expect(tx.type, isNotEmpty);
        expect(tx.date, isNotEmpty);
      }
    });

    test('GET /transactions returns cross-account txns', () async {
      final txns = await api.getTransactions(limit: 5);
      expect(txns.length, lessThanOrEqualTo(5));
      for (final tx in txns) {
        expect(tx.id, startsWith('trans_'));
      }
    });

    test('API throws ApiException on bad auth', () async {
      final badApi = AkahuApi(
        userToken: 'bad_token',
        appToken: appToken ?? '',
        appSecret: '',
      );
      expect(
        () => badApi.getAccounts(),
        throwsA(isA<ApiException>()),
      );
    });

    test('model parsing from raw JSON', () {
      final accountJson = {
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
      };
      final account = Account.fromJson(accountJson);
      expect(account.id, 'acc_test123');
      expect(account.name, 'Test Account');
      expect(account.type, 'CHECKING');
      expect(account.balance!.current, 1500.50);
      expect(account.connection!.name, 'Test Bank');
      expect(account.attributes, contains('TRANSACTIONS'));

      final txJson = {
        '_id': 'trans_test123',
        '_account': 'acc_test123',
        'date': '2026-07-24T12:00:00.000Z',
        'description': 'CARD 4506 MCDONALDS',
        'amount': -14.9,
        'balance': 64824.2,
        'type': 'EFTPOS',
        'merchant': {'name': "McDonald's"},
        'category': {'_id': 'cat_1', 'name': 'Fast food'},
      };
      final tx = Transaction.fromJson(txJson);
      expect(tx.id, 'trans_test123');
      expect(tx.amount, -14.9);
      expect(tx.type, 'EFTPOS');
      expect(tx.merchant!.name, "McDonald's");

      final userJson = {
        '_id': 'user_test123',
        'email': 'test@example.com',
        'access_granted_at': '2026-07-25T05:06:16.996Z',
      };
      final user = User.fromJson(userJson);
      expect(user.id, 'user_test123');
      expect(user.email, 'test@example.com');
    });
  });
}
