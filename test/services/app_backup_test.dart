import 'dart:io';

import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import 'package:fern/services/app_backup.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('full backup archives only Fern-owned document files', () async {
    final root = await Directory.systemTemp.createTemp('fern-backup-scope-');
    addTearDown(() => root.delete(recursive: true));

    await File(
      '${root.path}/unrelated-private-document.pdf',
    ).writeAsString('must never be backed up');
    await File('${root.path}/backup_settings.json').writeAsString('{}');
    final images = Directory('${root.path}/txn_images');
    await images.create();
    await File('${images.path}/merchant.jpg').writeAsBytes([1, 2, 3, 4]);

    final archive = Archive();
    await addFernDocumentsToArchiveForTesting(archive, root);

    final names = archive.map((entry) => entry.name).toSet();
    expect(names, contains('documents/backup_settings.json'));
    expect(names, contains('documents/txn_images/merchant.jpg'));
    expect(names, isNot(contains('documents/unrelated-private-document.pdf')));

    final encoded = ZipEncoder(password: 'password1').encodeBytes(archive);
    final decoded = ZipDecoder().decodeBytes(encoded, password: 'password1');
    expect(
      decoded.map((entry) => entry.name),
      contains('documents/txn_images/merchant.jpg'),
    );
  });

  test('restore replaces only Fern-owned files', () async {
    final source = await Directory.systemTemp.createTemp(
      'fern-restore-source-',
    );
    final destination = await Directory.systemTemp.createTemp(
      'fern-restore-destination-',
    );
    addTearDown(() => source.delete(recursive: true));
    addTearDown(() => destination.delete(recursive: true));

    await File('${source.path}/fern_cache.sqlite').writeAsString('new-db');
    await File(
      '${source.path}/backup_settings.json',
    ).writeAsString('new-settings');
    final sourceImages = Directory('${source.path}/txn_images');
    await sourceImages.create();
    await File('${sourceImages.path}/new.jpg').writeAsString('new-image');
    await File('${source.path}/should-not-copy.txt').writeAsString('ignore me');

    await File('${destination.path}/fern_cache.sqlite').writeAsString('old-db');
    await File(
      '${destination.path}/backup_settings.json',
    ).writeAsString('old-settings');
    final destinationImages = Directory('${destination.path}/txn_images');
    await destinationImages.create();
    await File('${destinationImages.path}/old.jpg').writeAsString('old-image');
    final unrelated = File('${destination.path}/drivers-license.jpg');
    await unrelated.writeAsString('keep me');

    await replaceFernDocumentsForTesting(
      source: source,
      destination: destination,
    );

    expect(await unrelated.readAsString(), 'keep me');
    expect(
      await File('${destination.path}/fern_cache.sqlite').readAsString(),
      'new-db',
    );
    expect(
      await File('${destination.path}/backup_settings.json').readAsString(),
      'new-settings',
    );
    expect(await File('${destinationImages.path}/old.jpg').exists(), isFalse);
    expect(
      await File('${destinationImages.path}/new.jpg').readAsString(),
      'new-image',
    );
    expect(
      await File('${destination.path}/should-not-copy.txt').exists(),
      isFalse,
    );
  });
}
