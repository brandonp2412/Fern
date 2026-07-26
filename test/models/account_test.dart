import 'dart:convert';

import 'package:fern/models/account.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fixtures.dart';

void main() {
  group('Account.fromJson / toJson', () {
    test('ANZ Everyday round-trips through JSON', () {
      final account = anzEveryday(balance: 2450.32);

      expect(account.id, 'acc_anz_everyday');
      expect(account.name, 'ANZ Everyday');
      expect(account.type, 'CHECKING');
      expect(account.formattedAccount, '01-0123-0123456-00');
      expect(account.connection?.name, 'ANZ');
      expect(account.balance?.current, 2450.32);

      final roundTripped = Account.fromJson(json.decode(json.encode(account.toJson())));
      expect(roundTripped.name, 'ANZ Everyday');
      expect(roundTripped.connection?.name, 'ANZ');
      expect(roundTripped.balance?.current, 2450.32);
    });

    test('Kiwibank Notice Saver has no PAYMENT_TO attribute', () {
      final account = kiwibankNoticeSaver();
      expect(account.canPayTo, isFalse);
      expect(account.canPayFrom, isFalse);
      expect(account.hasTransactions, isTrue);
    });
  });

  group('isActive', () {
    test('ANZ Everyday defaults to ACTIVE', () {
      expect(anzEveryday().isActive, isTrue);
    });

    test('an inactive ASB Streamline is not active', () {
      final json = asbStreamline().toJson();
      json['status'] = 'INACTIVE';
      expect(Account.fromJson(json).isActive, isFalse);
    });
  });

  group('isDebt / displayBalance', () {
    test('Amex Platinum credit card is debt and shows balance negated', () {
      final amex = amexCreditCard(owing: 512.40);
      expect(amex.isDebt, isTrue);
      expect(amex.displayBalance, -512.40);
    });

    test('ASB Streamline savings account is not debt and shows balance as-is', () {
      final asb = asbStreamline(balance: 8120.11);
      expect(asb.isDebt, isFalse);
      expect(asb.displayBalance, 8120.11);
    });

    test('a paid-off Amex Platinum (zero or negative current) is not negated', () {
      final json = amexCreditCard().toJson();
      json['balance']['current'] = -200.0;
      final amex = Account.fromJson(json);
      expect(amex.displayBalance, -200.0);
    });
  });

  group('canPayFrom / canPayTo', () {
    test('ANZ Everyday can pay from and to', () {
      final anz = anzEveryday();
      expect(anz.canPayFrom, isTrue);
      expect(anz.canPayTo, isTrue);
    });

    test('Amex Platinum can only pay to (it is a credit card)', () {
      final amex = amexCreditCard();
      expect(amex.canPayFrom, isFalse);
      expect(amex.canPayTo, isTrue);
    });
  });
}
