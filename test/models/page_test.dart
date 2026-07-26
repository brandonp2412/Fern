import 'package:fern/models/page.dart';
import 'package:fern/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fixtures.dart';

void main() {
  group('Page', () {
    test('hasMore is true when a real Akahu cursor.next is present', () {
      final page = Page<Transaction>(
        items: [mcdonaldsBurger(), uberTrip()],
        nextCursor: 'eyJvZmZzZXQiOjIwMH0=',
      );
      expect(page.items, hasLength(2));
      expect(page.hasMore, isTrue);
    });

    test('hasMore is false on the last page (no cursor)', () {
      final page = Page<Transaction>(items: [bpFuel()], nextCursor: null);
      expect(page.hasMore, isFalse);
    });
  });
}
