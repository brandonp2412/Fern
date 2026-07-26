import 'package:fern/models/connection.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Connection.fromJson', () {
    test('parses a real ANZ connection', () {
      final anz = Connection.fromJson({
        '_id': 'conn_anz',
        'name': 'ANZ',
        'logo': 'https://cdn.akahu.nz/logos/anz.png',
        'connection_type': 'bank',
      });

      expect(anz.id, 'conn_anz');
      expect(anz.name, 'ANZ');
      expect(anz.logo, 'https://cdn.akahu.nz/logos/anz.png');
      expect(anz.connectionType, 'bank');
      expect(anz.newConnectionsEnabled, isTrue);
    });

    test('a retired connection reports new_connections_enabled as false', () {
      final retired = Connection.fromJson({
        '_id': 'conn_oldbank',
        'name': 'Kiwibank Legacy',
        'logo': 'https://cdn.akahu.nz/logos/kiwibank.png',
        'new_connections_enabled': false,
      });

      expect(retired.name, 'Kiwibank Legacy');
      expect(retired.newConnectionsEnabled, isFalse);
    });

    test('missing fields fall back to empty strings', () {
      final connection = Connection.fromJson({});
      expect(connection.id, '');
      expect(connection.name, '');
      expect(connection.logo, '');
      expect(connection.connectionType, isNull);
    });
  });
}
