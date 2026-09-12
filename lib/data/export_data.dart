import 'dart:io';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../logging.dart';
import '../services/app_backup.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/backup_password_dialog.dart';

class ExportData extends StatelessWidget {
  final AppState state;

  const ExportData({super.key, required this.state});

  Future<void> _exportFullBackup(
    BuildContext pageContext,
    BuildContext sheetContext,
  ) async {
    final messenger = ScaffoldMessenger.of(pageContext);
    Navigator.pop(sheetContext);
    try {
      final password = await showBackupPasswordDialog(
        pageContext,
        creating: true,
      );
      if (password == null) return;
      final backup = await createFernBackup(state: state, password: password);
      final date = DateTime.now().toIso8601String().substring(0, 10);
      final fileName = 'fern-$date.zip';

      if (Platform.isAndroid || Platform.isIOS) {
        await SharePlus.instance.share(
          ShareParams(files: [XFile(backup.path, name: fileName)]),
        );
      } else {
        await FilePicker.saveFile(
          fileName: fileName,
          bytes: await backup.readAsBytes(),
          type: FileType.custom,
          allowedExtensions: const ['zip'],
        );
      }
      talker.info('Created encrypted full Fern backup');
      if (messenger.mounted) {
        messenger.showSnackBar(
          const SnackBar(content: Text('Full Fern backup created')),
        );
      }
    } catch (e, stackTrace) {
      talker.handle(e, stackTrace, 'Creating full Fern backup failed');
      if (messenger.mounted) {
        messenger.showSnackBar(
          SnackBar(content: Text('Failed to create Fern backup: $e')),
        );
      }
    }
  }

  Future<void> _exportCategoryRules(BuildContext context) async {
    Navigator.pop(context);
    final rules = await state.db.loadCategoryRules();
    final List<List<dynamic>> data = [
      ['id', 'matchText', 'categoryName', 'categoryGroup', 'createdAt'],
    ];
    for (final rule in rules) {
      data.add([
        rule.id,
        rule.matchText,
        rule.categoryName,
        rule.categoryGroup ?? '',
        rule.createdAt.toIso8601String(),
      ]);
    }
    final csv = CsvEncoder(lineDelimiter: '\n').convert(data);
    await _saveCsv('category_rules.csv', csv);
  }

  Future<void> _exportTransactions(BuildContext context) async {
    Navigator.pop(context);
    final transactions = await state.db.select(state.db.transactions).get();
    final List<List<dynamic>> data = [
      [
        'id',
        'accountId',
        'date',
        'description',
        'amount',
        'balance',
        'type',
        'merchantName',
        'categoryName',
        'categoryGroup',
      ],
    ];
    for (final t in transactions) {
      data.add([
        t.id,
        t.accountId,
        t.date,
        t.description,
        t.amount,
        t.balance ?? '',
        t.type,
        t.merchantName ?? '',
        t.categoryName ?? '',
        t.categoryGroup ?? '',
      ]);
    }
    final csv = CsvEncoder(lineDelimiter: '\n').convert(data);
    await _saveCsv('transactions.csv', csv);
  }

  Future<void> _saveCsv(String fileName, String csv) async {
    final bytes = Uint8List.fromList(csv.codeUnits);
    await FilePicker.saveFile(
      fileName: fileName,
      bytes: bytes,
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );
  }

  @override
  Widget build(BuildContext context) {
    final fern = context.fern;
    final pageContext = context;
    return ListTile(
      title: const Text(
        'Export data',
        style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        'Create a full backup or export selected data',
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
                    leading: const Icon(Icons.backup_outlined),
                    title: const Text('Full Fern backup'),
                    subtitle: const Text(
                      'Encrypted .zip — database, files, settings and login',
                    ),
                    onTap: () => _exportFullBackup(pageContext, sheetContext),
                  ),
                  ListTile(
                    leading: const Icon(Icons.rule),
                    title: const Text('Category rules'),
                    onTap: () => _exportCategoryRules(sheetContext),
                  ),
                  ListTile(
                    leading: const Icon(Icons.receipt_long),
                    title: const Text('Transactions'),
                    onTap: () => _exportTransactions(sheetContext),
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
