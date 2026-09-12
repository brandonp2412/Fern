import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db/app_database.dart';
import '../state/app_state.dart';
import 'secure_store.dart';

const fernBackupFormat = 'fern-full-backup';
const fernBackupVersion = 1;
const fernBackupDatabasePath = 'documents/fern_cache.sqlite';

class FernBackupRestoreResult {
  final int accounts;
  final int transactions;
  final int customImages;

  const FernBackupRestoreResult({
    required this.accounts,
    required this.transactions,
    required this.customImages,
  });
}

Future<File> createFernBackup({
  required AppState state,
  required String password,
}) async {
  if (password.length < 8) {
    throw const FormatException(
      'Backup password must be at least 8 characters',
    );
  }

  final documents = await getApplicationDocumentsDirectory();
  final temporary = await getTemporaryDirectory();
  final stamp = DateTime.now().toUtc().toIso8601String().replaceAll(':', '-');
  final snapshot = File(p.join(temporary.path, 'fern-backup-$stamp.sqlite'));
  final output = File(p.join(temporary.path, 'fern-backup-$stamp.zip'));

  if (await snapshot.exists()) await snapshot.delete();
  if (await output.exists()) await output.delete();

  await _snapshotDatabase(state.db, snapshot);

  final archive = Archive();
  archive.add(
    ArchiveFile.string(
      'manifest.json',
      jsonEncode({
        'format': fernBackupFormat,
        'version': fernBackupVersion,
        'createdAt': DateTime.now().toUtc().toIso8601String(),
        'databaseSchemaVersion': state.db.schemaVersion,
        'encrypted': true,
      }),
    ),
  );
  archive.add(
    ArchiveFile.bytes(fernBackupDatabasePath, await snapshot.readAsBytes()),
  );

  await _addDocumentsToArchive(
    archive,
    documents,
    skipBasenames: const {
      'fern_cache.sqlite',
      'fern_cache.sqlite-shm',
      'fern_cache.sqlite-wal',
    },
  );

  final preferences = await _readPreferences();
  archive.add(
    ArchiveFile.string('state/preferences.json', jsonEncode(preferences)),
  );
  archive.add(
    ArchiveFile.string(
      'state/credentials.json',
      jsonEncode({
        'userToken': await SecureStore.userToken,
        'appToken': await SecureStore.appToken,
      }),
    ),
  );

  final bytes = ZipEncoder(password: password).encodeBytes(archive);
  await output.writeAsBytes(bytes, flush: true);
  await snapshot.delete();
  return output;
}

Future<FernBackupRestoreResult> restoreFernBackup({
  required File backupFile,
  required String password,
  required AppState state,
  required Future<void> Function(bool credentialsChanged) restart,
}) async {
  if (!await backupFile.exists()) {
    throw const FileSystemException('Selected backup does not exist');
  }
  if (password.isEmpty) {
    throw const FormatException('Backup password is required');
  }

  final temporary = await getTemporaryDirectory();
  final documents = await getApplicationDocumentsDirectory();
  final nonce = DateTime.now().microsecondsSinceEpoch;
  final staging = Directory(p.join(temporary.path, 'fern-restore-$nonce'));
  final rollback = Directory(p.join(temporary.path, 'fern-rollback-$nonce'));
  await staging.create(recursive: true);
  await rollback.create(recursive: true);

  final oldPreferences = await _readPreferences();
  final oldUserToken = await SecureStore.userToken;
  final oldAppToken = await SecureStore.appToken;
  var databaseClosed = false;

  try {
    final archive = ZipDecoder().decodeBytes(
      await backupFile.readAsBytes(),
      password: password,
    );
    final manifest = _readJsonEntry(archive, 'manifest.json');
    if (manifest['format'] != fernBackupFormat ||
        manifest['version'] != fernBackupVersion) {
      throw const FormatException('Unsupported Fern backup format');
    }

    _validateArchivePaths(archive);
    await _extractDocuments(archive, staging);
    final stagedDatabase = File(
      p.join(staging.path, 'documents', 'fern_cache.sqlite'),
    );
    await validateFernDatabase(stagedDatabase);

    await _snapshotCurrentDocuments(state.db, documents, rollback);
    await state.closeDatabaseForImport();
    databaseClosed = true;

    await _replaceDocuments(
      source: Directory(p.join(staging.path, 'documents')),
      destination: documents,
    );
    await _remapImagePaths(documents);

    final preferences = _readJsonEntry(archive, 'state/preferences.json');
    await _writePreferences(preferences);

    final credentials = _readJsonEntry(archive, 'state/credentials.json');
    final userToken = credentials['userToken'] as String?;
    final appToken = credentials['appToken'] as String?;
    if ((userToken ?? '').isEmpty || (appToken ?? '').isEmpty) {
      await SecureStore.clear();
    } else {
      await SecureStore.saveCredentials(
        userToken: userToken!,
        appToken: appToken!,
      );
    }

    final restoredDatabase = AppDatabase(
      NativeDatabase(File(p.join(documents.path, 'fern_cache.sqlite'))),
    );
    final counts = await Future.wait<int>([
      restoredDatabase
          .select(restoredDatabase.accounts)
          .get()
          .then((v) => v.length),
      restoredDatabase
          .select(restoredDatabase.transactions)
          .get()
          .then((v) => v.length),
      restoredDatabase.loadImageRules().then((v) => v.length),
    ]);
    await restoredDatabase.close();

    await restart(true);
    await staging.delete(recursive: true);
    await rollback.delete(recursive: true);
    return FernBackupRestoreResult(
      accounts: counts[0],
      transactions: counts[1],
      customImages: counts[2],
    );
  } catch (_) {
    if (databaseClosed) {
      await _replaceDocuments(
        source: Directory(p.join(rollback.path, 'documents')),
        destination: documents,
      );
      await _writePreferences(oldPreferences);
      if ((oldUserToken ?? '').isEmpty || (oldAppToken ?? '').isEmpty) {
        await SecureStore.clear();
      } else {
        await SecureStore.saveCredentials(
          userToken: oldUserToken!,
          appToken: oldAppToken!,
        );
      }
      await restart(true);
    }
    if (await staging.exists()) await staging.delete(recursive: true);
    if (await rollback.exists()) await rollback.delete(recursive: true);
    rethrow;
  }
}

Future<void> validateFernDatabase(File file) async {
  if (!await file.exists()) {
    throw const FileSystemException('Backup database is missing');
  }
  final handle = await file.open();
  try {
    final header = await handle.read(16);
    const sqliteHeader = <int>[
      0x53,
      0x51,
      0x4c,
      0x69,
      0x74,
      0x65,
      0x20,
      0x66,
      0x6f,
      0x72,
      0x6d,
      0x61,
      0x74,
      0x20,
      0x33,
      0x00,
    ];
    if (header.length != sqliteHeader.length) {
      throw const FormatException('Backup database is not SQLite');
    }
    for (var i = 0; i < sqliteHeader.length; i++) {
      if (header[i] != sqliteHeader[i]) {
        throw const FormatException('Backup database is not SQLite');
      }
    }
  } finally {
    await handle.close();
  }
}

Future<void> _snapshotDatabase(AppDatabase db, File destination) async {
  await destination.parent.create(recursive: true);
  if (await destination.exists()) await destination.delete();
  final escapedPath = destination.path.replaceAll("'", "''");
  await db.customStatement("VACUUM INTO '$escapedPath'");
}

Future<void> _addDocumentsToArchive(
  Archive archive,
  Directory root, {
  Set<String> skipBasenames = const {},
}) async {
  if (!await root.exists()) return;
  await for (final entity in root.list(recursive: true, followLinks: false)) {
    if (entity is! File) continue;
    final basename = p.basename(entity.path);
    if (skipBasenames.contains(basename) ||
        basename.endsWith('.importing') ||
        basename.endsWith('.pre-import')) {
      continue;
    }
    final relative = p
        .relative(entity.path, from: root.path)
        .replaceAll('\\', '/');
    archive.add(
      ArchiveFile.bytes('documents/$relative', await entity.readAsBytes()),
    );
  }
}

Map<String, dynamic> _readJsonEntry(Archive archive, String name) {
  final entry = archive.find(name);
  if (entry == null || !entry.isFile) {
    throw FormatException('Fern backup is missing $name');
  }
  final bytes = entry.readBytes();
  if (bytes == null) throw FormatException('Unable to read $name');
  final decoded = jsonDecode(utf8.decode(bytes));
  if (decoded is! Map<String, dynamic>) {
    throw FormatException('Invalid $name');
  }
  return decoded;
}

void _validateArchivePaths(Archive archive) {
  for (final entry in archive) {
    final name = entry.name.replaceAll('\\', '/');
    if (name.startsWith('/') ||
        name.split('/').contains('..') ||
        name.contains('\u0000')) {
      throw const FormatException('Unsafe path in Fern backup');
    }
  }
}

Future<void> _extractDocuments(Archive archive, Directory staging) async {
  for (final entry in archive) {
    if (!entry.isFile || !entry.name.startsWith('documents/')) continue;
    final relative = entry.name.substring('documents/'.length);
    if (relative.isEmpty) continue;
    final destination = File(p.join(staging.path, 'documents', relative));
    await destination.parent.create(recursive: true);
    final bytes = entry.readBytes();
    if (bytes == null) throw FormatException('Unable to read ${entry.name}');
    await destination.writeAsBytes(bytes, flush: true);
  }
}

Future<void> _snapshotCurrentDocuments(
  AppDatabase db,
  Directory documents,
  Directory rollback,
) async {
  final rollbackDocuments = Directory(p.join(rollback.path, 'documents'));
  await rollbackDocuments.create(recursive: true);
  await _snapshotDatabase(
    db,
    File(p.join(rollbackDocuments.path, 'fern_cache.sqlite')),
  );
  if (!await documents.exists()) return;
  await for (final entity in documents.list(
    recursive: true,
    followLinks: false,
  )) {
    if (entity is! File) continue;
    final basename = p.basename(entity.path);
    if (basename == 'fern_cache.sqlite' ||
        basename == 'fern_cache.sqlite-shm' ||
        basename == 'fern_cache.sqlite-wal') {
      continue;
    }
    final relative = p.relative(entity.path, from: documents.path);
    final destination = File(p.join(rollbackDocuments.path, relative));
    await destination.parent.create(recursive: true);
    await entity.copy(destination.path);
  }
}

Future<void> _replaceDocuments({
  required Directory source,
  required Directory destination,
}) async {
  if (!await source.exists()) {
    throw const FormatException('Backup documents are missing');
  }
  if (await destination.exists()) {
    await for (final entity in destination.list(followLinks: false)) {
      await entity.delete(recursive: true);
    }
  } else {
    await destination.create(recursive: true);
  }
  await for (final entity in source.list(recursive: true, followLinks: false)) {
    if (entity is! File) continue;
    final relative = p.relative(entity.path, from: source.path);
    final target = File(p.join(destination.path, relative));
    await target.parent.create(recursive: true);
    await entity.copy(target.path);
  }
}

Future<void> _remapImagePaths(Directory documents) async {
  final databaseFile = File(p.join(documents.path, 'fern_cache.sqlite'));
  final imagesDirectory = Directory(p.join(documents.path, 'txn_images'));
  if (!await imagesDirectory.exists()) return;

  final db = AppDatabase(NativeDatabase(databaseFile));
  try {
    final rules = await db.loadImageRules();
    for (final rule in rules) {
      final restored = File(
        p.join(imagesDirectory.path, p.basename(rule.imagePath)),
      );
      if (!await restored.exists()) continue;
      await db.customStatement(
        'UPDATE image_rules SET image_path = ? WHERE id = ?',
        [restored.path, rule.id],
      );
    }
  } finally {
    await db.close();
  }
}

Future<Map<String, dynamic>> _readPreferences() async {
  final preferences = await SharedPreferences.getInstance();
  final values = <String, dynamic>{};
  for (final key in preferences.getKeys()) {
    values[key] = preferences.get(key);
  }
  return values;
}

Future<void> _writePreferences(Map<String, dynamic> values) async {
  final preferences = await SharedPreferences.getInstance();
  await preferences.clear();
  for (final entry in values.entries) {
    final value = entry.value;
    if (value is bool) {
      await preferences.setBool(entry.key, value);
    } else if (value is int) {
      await preferences.setInt(entry.key, value);
    } else if (value is double) {
      await preferences.setDouble(entry.key, value);
    } else if (value is String) {
      await preferences.setString(entry.key, value);
    } else if (value is List) {
      await preferences.setStringList(entry.key, value.cast<String>());
    }
  }
}
