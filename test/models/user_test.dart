import 'package:fern/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User.fromJson', () {
    test('parses a real Akahu /me response', () {
      final user = User.fromJson({
        '_id': 'user_2n2crlefk9enq9dp8dv3f',
        'email': 'test@example.com',
        'access_granted_at': '2026-01-15T09:30:00.000Z',
      });

      expect(user.id, 'user_2n2crlefk9enq9dp8dv3f');
      expect(user.email, 'test@example.com');
      expect(user.accessGrantedAt, '2026-01-15T09:30:00.000Z');
    });

    test('falls back to empty id and null fields when missing', () {
      final user = User.fromJson({});
      expect(user.id, '');
      expect(user.email, isNull);
      expect(user.accessGrantedAt, isNull);
    });
  });
}
