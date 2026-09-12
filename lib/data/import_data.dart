import 'dart:io';

import 'package:csv/csv.dart';
import 'package:drift/drift.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../db/app_database.dart';
import '../logging.dart';
import '../services/app_backup.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/backup_password_dialog.dart';

Future<void> validateSqliteDatabaseFile(File file) =>
    validateFernDatabase(file);

class ImportData extends StatelessWidget {
  final AppState state;
  final Future<void> Function(bool credentialsChanged)? onDatabaseImported;

  const ImportData({super.key, required this.state, this.onDatabaseImported});

  Future<void> _importFullBackup(
    BuildContext pageContext,
    BuildContext sheetContext,
  ) async {
    final messenger = ScaffoldMessenger.of(pageContext);
    Navigator.pop(sheetContext);
    try {
      final restart = onDatabaseImported;
      if (restart == null) {
        throw StateError('Database import restart handler is unavailable');
      }
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: const ['zip'],
      );
      if (result == null) return;
      final path = result.files.single.path;
      if (path == null) return;
      if (!pageContext.mounted) return;
      final password = await showBackupPasswordDialog(
        pageContext,
        creating: false,
      );
      if (password == null) return;

      final restored = await restoreFernBackup(
        backupFile: File(path),
        password: password,
        state: state,
        restart: restart,
      );
      talker.info(
        'Restored full Fern backup: ${restored.accounts} accounts, '
        '${restored.transactions} transactions, '
        '${restored.customImages} image rules',
      );
      if (messenger.mounted) {
        messenger.showSnackBar(
          SnackBar(
            content: Text(
              'Restored ${restored.accounts} account${restored.accounts == 1 ? '' : 's'}, '
              '${restored.transactions} transactions and '
              '${restored.customImages} custom image${restored.customImages == 1 ? '' : 's'}',
            ),
          ),
        );
      }
    } catch (e, stackTrace) {
      talker.handle(e, stackTrace, 'Restoring full Fern backup failed');
      if (messenger.mounted) {
        messenger.showSnackBar(
          SnackBar(content: Text('Failed to restore Fern backup: $e')),
        );
      }
    }
  }

  Future<void> _importDatabase(
    BuildContext pageContext,
    BuildContext sheetContext,
  ) async {
    final messenger = ScaffoldMessenger.of(pageContext);
    Navigator.pop(sheetContext);
    try {
      final result = await FilePicker.pickFiles();
      if (result == null) return;
      final path = result.files.single.path;
      if (path == null) return;
      final sourceFile = File(path);
      await validateSqliteDatabaseFile(sourceFile);

      final restart = onDatabaseImported;
      if (restart == null) {
        throw StateError('Database import restart handler is unavailable');
      }

      final dbFolder = await getApplicationDocumentsDirectory();
      final targetFile = File(p.join(dbFolder.path, 'fern_cache.sqlite'));
      final stagedFile = File('${targetFile.path}.importing');
      final previousFile = File('${targetFile.path}.pre-import');

      if (await stagedFile.exists()) await stagedFile.delete();
      await sourceFile.copy(stagedFile.path);
      await validateSqliteDatabaseFile(stagedFile);

      await state.closeDatabaseForImport();
      if (await previousFile.exists()) await previousFile.delete();
      if (await targetFile.exists()) {
        await targetFile.rename(previousFile.path);
      }

      try {
        await stagedFile.rename(targetFile.path);
      } catch (_) {
        if (await previousFile.exists() && !await targetFile.exists()) {
          await previousFile.rename(targetFile.path);
        }
        rethrow;
      }

      talker.info('Imported legacy database backup');
      await restart(false);
      if (await previousFile.exists()) await previousFile.delete();

      if (messenger.mounted) {
        messenger.showSnackBar(
          const SnackBar(
            content: Text('Legacy database imported successfully'),
          ),
        );
      }
    } catch (e, stackTrace) {
      talker.handle(e, stackTrace, 'Importing database backup failed');
      if (messenger.mounted) {
        messenger.showSnackBar(
          SnackBar(content: Text('Failed to import database: $e')),
        );
      }
    }
  }

  Future<void> _importCategoryRules(
    BuildContext pageContext,
    BuildContext sheetContext,
  ) async {
    final messenger = ScaffoldMessenger.of(pageContext);
    Navigator.pop(sheetContext);
    try {
      final result = await FilePicker.pickFiles();
      if (result == null) return;
      final path = result.files.single.path;
      if (path == null) return;
      final content = await File(path).readAsString();
      final rows = const CsvDecoder().convert(content);
      if (rows.length < 2) return;

      final rules = <CategoryRulesCompanion>[];
      for (final row in rows.skip(1)) {
        final categoryGroup = row.elementAtOrNull(3)?.toString().trim();
        rules.add(
          CategoryRulesCompanion.insert(
            id: row[0].toString().trim(),
            matchText: row[1].toString().trim(),
            categoryName: row[2].toString().trim(),
            categoryGroup: Value(
              categoryGroup == null || categoryGroup.isEmpty
                  ? null
                  : categoryGroup,
            ),
            createdAt:
                DateTime.tryParse(row[4].toString().trim()) ?? DateTime.now(),
          ),
        );
      }

      await state.db.transaction(() async {
        await state.db.delete(state.db.categoryRules).go();
        await state.db.batch(
          (batch) => batch.insertAll(state.db.categoryRules, rules),
        );
      });
      talker.info('Imported ${rules.length} category rules');

      final restart = onDatabaseImported;
      if (restart != null) await restart(false);
      if (messenger.mounted) {
        messenger.showSnackBar(
          SnackBar(content: Text('Imported ${rules.length} category rules')),
        );
      }
    } catch (e, stackTrace) {
      talker.handle(e, stackTrace, 'Importing category rules failed');
      if (messenger.mounted) {
        messenger.showSnackBar(
          SnackBar(content: Text('Failed to import category rules: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final fern = context.fern;
    final pageContext = context;
    return ListTile(
      title: const Text(
        'Import data',
        style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        'Restore a full Fern backup or import legacy data',
        style: TextStyle(fontSize: 12, color: fern.slate),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        showModalBottomSheet(
          context: context,
          useRootNavigator: true,
          builder: (sheetContext) {
            return SafeArea(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.settings_backup_restore),
                    title: const Text('Full Fern backup'),
                    subtitle: const Text(
                      'Encrypted .zip — app state and files',
                    ),
                    onTap: () => _importFullBackup(pageContext, sheetContext),
                  ),
                  ListTile(
                    leading: const Icon(Icons.storage),
                    title: const Text('Legacy database'),
                    subtitle: const Text('.sqlite — database only'),
                    onTap: () => _importDatabase(pageContext, sheetContext),
                  ),
                  ListTile(
                    leading: const Icon(Icons.rule),
                    title: const Text('Category rules'),
                    onTap: () =>
                        _importCategoryRules(pageContext, sheetContext),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
