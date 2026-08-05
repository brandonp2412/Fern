import 'dart:convert';

import 'package:fern/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fixtures.dart';

void main() {
  group('Transaction.fromJson / toJson', () {
    test("McDonald's transaction round-trips through JSON", () {
      final tx = mcdonaldsBurger();

      expect(tx.description, 'MCDONALDS AUCKLAND');
      expect(tx.amount, -14.90);
      expect(tx.merchant?.name, "McDonald's");
      expect(tx.title, "McDonald's");

      final roundTripped = Transaction.fromJson(
        json.decode(json.encode(tx.toJson())),
      );
      expect(roundTripped.merchant?.name, "McDonald's");
      expect(roundTripped.amount, -14.90);
      expect(roundTripped.account, 'acc_anz_everyday');
    });

    test(
      'a payday DIRECT CREDIT transaction has no merchant, title falls back to description',
      () {
        final tx = payday(amount: 3200.00);
        expect(tx.merchant, isNull);
        expect(tx.title, 'ACME LTD PAYROLL');
        expect(tx.type, 'DIRECT CREDIT');
        expect(tx.amount, 3200.00);
      },
    );

    test('an internal transfer is negative and typed TRANSFER', () {
      final tx = internalTransfer(amount: -500.00);
      expect(tx.type, 'TRANSFER');
      expect(tx.amount, -500.00);
      expect(tx.description, 'TRANSFER TO ASB STREAMLINE');
    });
  });

  group('title fallback', () {
    test('falls back to type when both merchant and description are empty', () {
      final tx = Transaction.fromJson({
        '_id': 'txn_empty',
        '_account': 'acc_anz_everyday',
        'date': '2026-07-01T00:00:00.000Z',
        'description': '',
        'amount': -5.0,
        'type': 'FEE',
      });
      expect(tx.title, 'FEE');
    });
  });

  group('TransactionCategory.groupName', () {
    test(
      'a Netflix transaction categorised under "Entertainment" reports that group',
      () {
        final tx = netflixSubscription();
        final withCategory = Transaction.fromJson({
          ...tx.toJson(),
          'category': {
            '_id': 'cat_streaming',
            'name': 'Streaming Services',
            'groups': {
              'personal_finance': {
                '_id': 'grp_entertainment',
                'name': 'Entertainment',
              },
            },
          },
        });
        expect(withCategory.category?.name, 'Streaming Services');
        expect(withCategory.category?.groupName, 'Entertainment');
      },
    );

    test(
      'falls back to the first available group when personal_finance is absent',
      () {
        final tx = Transaction.fromJson({
          ...mcdonaldsBurger().toJson(),
          'category': {
            '_id': 'cat_food',
            'name': 'Restaurants',
            'groups': {
              'business': {'_id': 'grp_business', 'name': 'Business Expenses'},
            },
          },
        });
        expect(tx.category?.groupName, 'Business Expenses');
      },
    );

    test('is null when there are no groups at all', () {
      final tx = Transaction.fromJson({
        ...bpFuel().toJson(),
        'category': {'_id': 'cat_fuel', 'name': 'Fuel'},
      });
      expect(tx.category?.groupName, isNull);
    });
  });

  group('PendingTransaction.fromJson', () {
    test('a pending Mercury Energy bill parses correctly', () {
      final pending = PendingTransaction.fromJson({
        '_account': 'acc_asb_streamline',
        'date': '2026-07-22T00:00:00.000Z',
        'description': 'MERCURY ENERGY',
        'amount': -145.32,
        'type': 'EFTPOS',
      });
      expect(pending.description, 'MERCURY ENERGY');
      expect(pending.amount, -145.32);
      expect(pending.account, 'acc_asb_streamline');
    });
  });
}
