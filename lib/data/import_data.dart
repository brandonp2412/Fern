import 'dart:io';

import 'package:csv/csv.dart';
import 'package:drift/drift.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../db/app_database.dart';
import '../main.dart';
import '../screens/home_shell.dart';
import '../state/app_state.dart';

class ImportData extends StatelessWidget {
  final AppState state;

  const ImportData({super.key, required this.state});

  void _restart(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (routeContext) => SetupScreen(
          settings: state.settings,
          onConnected: (newState) => Navigator.of(routeContext).pushReplacement(
            MaterialPageRoute(builder: (_) => HomeShell(state: newState)),
          ),
        ),
      ),
      (_) => false,
    );
  }

  Future<void> _importDatabase(BuildContext context) async {
    Navigator.pop(context);
    try {
      final result = await FilePicker.pickFiles();
      if (result == null) return;
      final path = result.files.single.path;
      if (path == null) return;
      final sourceFile = File(path);
      if (!await sourceFile.exists()) {
        throw Exception('Selected file does not exist');
      }

      final dbFolder = await getApplicationDocumentsDirectory();
      await state.db.close();
      await sourceFile.copy(p.join(dbFolder.path, 'fern_cache.sqlite'));

      if (!context.mounted) return;
      _restart(context);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to import database: $e')));
    }
  }

  Future<void> _importCategoryRules(BuildContext context) async {
    Navigator.pop(context);
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

      if (!context.mounted) return;
      _restart(context);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to import category rules: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          useRootNavigator: true,
          builder: (context) {
            return SafeArea(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.storage),
                    title: const Text('Database'),
                    onTap: () => _importDatabase(context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.rule),
                    title: const Text('Category rules'),
                    onTap: () => _importCategoryRules(context),
                  ),
                ],
              ),
            );
          },
        );
      },
      icon: const Icon(Icons.upload),
      label: const Text('Import data'),
    );
  }
}
