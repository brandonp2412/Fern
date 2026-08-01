import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Mirrors the automatic-backup prefs to a small JSON file next to the
/// database so native Android code can read/write them without depending
/// on the shared_preferences plugin's internal storage format.
Future<void> writeBackupSettingsFile({
  required bool automaticBackups,
  String? backupUri,
}) async {
  final dir = await getApplicationDocumentsDirectory();
  final file = File(p.join(dir.path, 'backup_settings.json'));
  await file.writeAsString(jsonEncode({
    'automaticBackups': automaticBackups,
    'backupUri': backupUri,
  }));
}
