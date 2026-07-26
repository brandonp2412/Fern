import 'package:fern/models/transaction.dart';
import 'package:fern/services/auto_categorizer.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fixtures.dart';

// Rebuilds a transaction fixture with a different description (and no
// merchant, so the description string alone drives categorisation), keeping
// everything else (amount, account, type) the same.
Transaction _withDescription(Transaction tx, String description) => Transaction.fromJson({
      ...tx.toJson(),
      'description': description,
      'merchant': null,
    });

void main() {
  group('categorize', () {
    test("McDonald's is categorised as Fast food stores / Lifestyle", () {
      final result = AutoCategorizer.categorize(mcdonaldsBurger());
      expect(result?.name, 'Fast food stores');
      expect(result?.group, 'Lifestyle');
    });

    test('an Uber trip is categorised as rideshare / Transport', () {
      final result = AutoCategorizer.categorize(uberTrip());
      expect(result?.name, 'Taxi, rideshare, and on-demand transport services');
      expect(result?.group, 'Transport');
    });

    test('a BP fuel stop is categorised as Fuel stations / Transport', () {
      final result = AutoCategorizer.categorize(bpFuel());
      expect(result?.name, 'Fuel stations');
      expect(result?.group, 'Transport');
    });

    test('Netflix is categorised as Entertainment / Lifestyle', () {
      final result = AutoCategorizer.categorize(netflixSubscription());
      expect(result?.name, 'Entertainment (not elsewhere classified)');
      expect(result?.group, 'Lifestyle');
    });

    test('Mercury Energy is categorised as Electricity services / Utilities', () {
      final result = AutoCategorizer.categorize(mercuryEnergyBill());
      expect(result?.name, 'Electricity services');
      expect(result?.group, 'Utilities');
    });

    test('a 2degrees mobile bill is categorised as Telecommunication services / Utilities', () {
      final tx = mercuryEnergyBill();
      final result = AutoCategorizer.categorize(_withDescription(tx, '2DEGREES MOBILE'));
      expect(result?.name, 'Telecommunication services');
      expect(result?.group, 'Utilities');
    });

    test('an AT HOP topup is categorised as rideshare/transport services', () {
      final tx = uberTrip();
      final result = AutoCategorizer.categorize(_withDescription(tx, 'AT HOP TOPUP'));
      expect(result?.name, 'Taxi, rideshare, and on-demand transport services');
      expect(result?.group, 'Transport');
    });

    test('a New World supermarket shop is categorised as Food', () {
      final tx = mcdonaldsBurger();
      final result = AutoCategorizer.categorize(_withDescription(tx, 'NEW WORLD PONSONBY'));
      expect(result?.name, 'Supermarkets and grocery stores');
      expect(result?.group, 'Food');
    });

    test('an internal transfer falls back to Transfers/Transfers', () {
      final result = AutoCategorizer.categorize(internalTransfer());
      expect(result?.name, 'Transfers');
      expect(result?.group, 'Transfers');
    });

    test('a positive DIRECT CREDIT payday falls back to Income/Income', () {
      final result = AutoCategorizer.categorize(payday(amount: 3200.00));
      expect(result?.name, 'Income');
      expect(result?.group, 'Income');
    });

    test('a negative DIRECT CREDIT (e.g. a reversal) does not fall back to Income', () {
      final result = AutoCategorizer.categorize(payday(amount: -50.00));
      expect(result, isNull);
    });

    test('an uncategorisable transaction returns null', () {
      final tx = _withDescription(mcdonaldsBurger(), 'JOHN SMITH 123456');
      final result = AutoCategorizer.categorize(tx);
      expect(result, isNull);
    });
  });

  group('lookupGroup', () {
    test('finds the group for a known category name', () {
      expect(AutoCategorizer.lookupGroup('Fuel stations'), 'Transport');
      expect(AutoCategorizer.lookupGroup('Fast food stores'), 'Lifestyle');
    });

    test('returns null for an unknown category name', () {
      expect(AutoCategorizer.lookupGroup('Not a real category'), isNull);
    });
  });

  group('allCategoryNames / categoriesByGroup', () {
    test('includes real category names used across the rule set', () {
      final names = AutoCategorizer.allCategoryNames;
      expect(names, contains('Fast food stores'));
      expect(names, contains('Fuel stations'));
      expect(names, contains('Electricity services'));
    });

    test('groups categories under their real group names, sorted', () {
      final byGroup = AutoCategorizer.categoriesByGroup;
      expect(byGroup['Transport'], contains('Fuel stations'));
      expect(byGroup['Transport'], contains('Taxi, rideshare, and on-demand transport services'));
      final transport = byGroup['Transport']!;
      expect(transport, orderedEquals(transport.toList()..sort()));
    });
  });
}
