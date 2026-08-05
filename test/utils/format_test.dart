import 'package:fern/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  group('money', () {
    test('formats a McDonald\'s purchase as a negative dollar amount', () {
      expect(money(-14.90), '-\$14.90');
    });

    test('formats a payday deposit with an explicit + sign', () {
      expect(money(3200.00, sign: true), '+\$3,200.00');
    });

    test(
      'formats a large Kiwibank savings balance with thousands separators',
      () {
        expect(money(15302.87), '\$15,302.87');
      },
    );

    test('formats a foreign currency amount with its currency code', () {
      expect(money(42.50, currency: 'USD'), 'USD 42.50');
    });

    test('renders an em dash for a null amount', () {
      expect(money(null), '—');
    });

    test('a positive amount with sign:false has no leading +', () {
      expect(money(87.20), '\$87.20');
    });
  });

  group('parseDate', () {
    test('parses a real Akahu ISO timestamp', () {
      final d = parseDate('2026-07-20T12:15:00.000Z');
      expect(d, isNotNull);
    });

    test('returns null for an empty or null string', () {
      expect(parseDate(''), isNull);
      expect(parseDate(null), isNull);
    });
  });

  group('shortDate / longDate / dateTime', () {
    test('formats an ANZ transaction date as "d MMM"', () {
      final d = DateTime.parse('2026-07-20T12:15:00.000Z').toLocal();
      expect(
        shortDate('2026-07-20T12:15:00.000Z'),
        DateFormat('d MMM').format(d),
      );
    });

    test('formats a long date including weekday and year', () {
      final d = DateTime.parse('2026-07-20T12:15:00.000Z').toLocal();
      expect(
        longDate('2026-07-20T12:15:00.000Z'),
        DateFormat('EEE d MMM y').format(d),
      );
    });

    test('formats date and time together', () {
      final d = DateTime.parse('2026-07-20T12:15:00.000Z').toLocal();
      expect(
        dateTime('2026-07-20T12:15:00.000Z'),
        DateFormat('d MMM y, h:mm a').format(d),
      );
    });

    test('all three return empty strings for a missing date', () {
      expect(shortDate(null), '');
      expect(longDate(null), '');
      expect(dateTime(null), '');
    });
  });

  group('relativeDate', () {
    test('a transaction from today reads "Today"', () {
      final iso = DateTime.now().toUtc().toIso8601String();
      expect(relativeDate(iso), 'Today');
    });

    test('a transaction from yesterday reads "Yesterday"', () {
      final iso = DateTime.now()
          .toUtc()
          .subtract(const Duration(days: 1))
          .toIso8601String();
      expect(relativeDate(iso), 'Yesterday');
    });

    test('a transaction from three days ago shows the weekday name', () {
      final threeDaysAgo = DateTime.now().subtract(const Duration(days: 3));
      final iso = DateTime.now()
          .toUtc()
          .subtract(const Duration(days: 3))
          .toIso8601String();
      expect(relativeDate(iso), DateFormat('EEEE').format(threeDaysAgo));
    });

    test('an older transaction (Mercury Energy bill) shows a short date', () {
      final iso = DateTime.now()
          .toUtc()
          .subtract(const Duration(days: 30))
          .toIso8601String();
      final d = DateTime.parse(iso).toLocal();
      expect(relativeDate(iso), DateFormat('d MMM').format(d));
    });

    test('returns an empty string for a missing date', () {
      expect(relativeDate(null), '');
    });
  });

  group('isoDay', () {
    test('formats a date as zero-padded yyyy-mm-dd', () {
      expect(isoDay(DateTime(2026, 7, 5)), '2026-07-05');
    });

    test('pads single-digit months and days', () {
      expect(isoDay(DateTime(2026, 1, 9)), '2026-01-09');
    });
  });

  group('accountTypeLabel / accountTypeIcon', () {
    test('ANZ Everyday (CHECKING) is labelled "Everyday"', () {
      expect(accountTypeLabel('CHECKING'), 'Everyday');
      expect(
        accountTypeIcon('CHECKING'),
        Icons.account_balance_wallet_outlined,
      );
    });

    test('Amex Platinum (CREDITCARD) is labelled "Credit card"', () {
      expect(accountTypeLabel('CREDITCARD'), 'Credit card');
      expect(accountTypeIcon('CREDITCARD'), Icons.credit_card);
    });

    test('Kiwibank Notice Saver (SAVINGS) is labelled "Savings"', () {
      expect(accountTypeLabel('savings'), 'Savings');
    });

    test('an unknown account type falls back to itself', () {
      expect(accountTypeLabel('MORTGAGE_OFFSET'), 'MORTGAGE_OFFSET');
      expect(
        accountTypeIcon('MORTGAGE_OFFSET'),
        Icons.account_balance_outlined,
      );
    });
  });

  group('txTypeLabel', () {
    test('labels every known Akahu transaction type', () {
      expect(txTypeLabel('CREDIT'), 'Credit');
      expect(txTypeLabel('DEBIT'), 'Debit');
      expect(txTypeLabel('PAYMENT'), 'Payment');
      expect(txTypeLabel('TRANSFER'), 'Transfer');
      expect(txTypeLabel('STANDING ORDER'), 'Standing order');
      expect(txTypeLabel('EFTPOS'), 'EFTPOS');
      expect(txTypeLabel('INTEREST'), 'Interest');
      expect(txTypeLabel('FEE'), 'Fee');
      expect(txTypeLabel('TAX'), 'Tax');
      expect(txTypeLabel('CREDIT CARD'), 'Card payment');
      expect(txTypeLabel('DIRECT CREDIT'), 'Direct credit');
      expect(txTypeLabel('DIRECT DEBIT'), 'Direct debit');
      expect(txTypeLabel('ATM'), 'ATM');
      expect(txTypeLabel('LOAN'), 'Loan payment');
    });

    test('an unrecognised type falls back to itself', () {
      expect(txTypeLabel('CASHBACK'), 'CASHBACK');
    });
  });
}
