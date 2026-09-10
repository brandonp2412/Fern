import 'dart:io';

import 'package:fern/data/import_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('database import validation accepts SQLite files', () async {
    final directory = await Directory.systemTemp.createTemp(
      'fern-import-test-',
    );
    addTearDown(() => directory.delete(recursive: true));
    final file = File('${directory.path}/backup.sqlite');
    await file.writeAsBytes([
      ...'SQLite format 3'.codeUnits,
      0,
      ...List<int>.filled(32, 0),
    ]);

    await expectLater(validateSqliteDatabaseFile(file), completes);
  });

  test('database import validation rejects non-SQLite files', () async {
    final directory = await Directory.systemTemp.createTemp(
      'fern-import-test-',
    );
    addTearDown(() => directory.delete(recursive: true));
    final file = File('${directory.path}/not-a-database.txt');
    await file.writeAsString('this is not a sqlite database');

    await expectLater(
      validateSqliteDatabaseFile(file),
      throwsA(isA<FormatException>()),
    );
  });

  test('database import validation rejects truncated files', () async {
    final directory = await Directory.systemTemp.createTemp(
      'fern-import-test-',
    );
    addTearDown(() => directory.delete(recursive: true));
    final file = File('${directory.path}/truncated.sqlite');
    await file.writeAsBytes('SQLite'.codeUnits);

    await expectLater(
      validateSqliteDatabaseFile(file),
      throwsA(isA<FormatException>()),
    );
  });
}
