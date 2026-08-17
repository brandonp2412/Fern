import 'dart:io';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../state/app_state.dart';
import '../theme.dart';

class ExportData extends StatelessWidget {
  final AppState state;

  const ExportData({super.key, required this.state});

  Future<void> _exportDatabase(BuildContext context) async {
    Navigator.pop(context);
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'fern_cache.sqlite'));
    if (Platform.isAndroid || Platform.isIOS) {
      await SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
      return;
    }
    final bytes = await file.readAsBytes();
    final result = await FilePicker.saveFile(
      fileName: 'fern_cache.sqlite',
      bytes: bytes,
      type: FileType.custom,
      allowedExtensions: ['sqlite'],
    );
    if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      if (result != null) await file.copy(result);
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
    return ListTile(
      title: const Text(
        'Export data',
        style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        'Save your database, category rules, or transactions',
        style: TextStyle(fontSize: 12, color: fern.slate),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
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
                    onTap: () => _exportDatabase(context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.rule),
                    title: const Text('Category rules'),
                    onTap: () => _exportCategoryRules(context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.receipt_long),
                    title: const Text('Transactions'),
                    onTap: () => _exportTransactions(context),
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
