import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../models/transaction.dart';
import '../services/akahu_api.dart';
import '../services/auto_categorizer.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../utils/category_colors.dart';
import '../utils/format.dart';
import '../widgets/common.dart';

void showTxnDetail(BuildContext context, AppState state, Transaction tx) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => TxnDetailSheet(state: state, tx: tx),
  );
}

class TxnDetailSheet extends StatefulWidget {
  final AppState state;
  final Transaction tx;

  const TxnDetailSheet({super.key, required this.state, required this.tx});

  @override
  State<TxnDetailSheet> createState() => _TxnDetailSheetState();
}

class _TxnDetailSheetState extends State<TxnDetailSheet> {
  @override
  void initState() {
    super.initState();
    widget.state.addListener(_onStateChanged);
  }

  @override
  void dispose() {
    widget.state.removeListener(_onStateChanged);
    super.dispose();
  }

  void _onStateChanged() {
    if (mounted) setState(() {});
  }

  Future<void> _clearOverride() async {
    await widget.state.clearCategoryOverride(widget.tx.id);
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
    );
    if (picked == null) return;
    final dir = await getApplicationDocumentsDirectory();
    final imagesDir = Directory('${dir.path}/txn_images');
    await imagesDir.create(recursive: true);
    final ext = picked.path.split('.').last;
    final savedPath = '${imagesDir.path}/${widget.tx.id}.$ext';
    await File(picked.path).copy(savedPath);
    await FileImage(File(savedPath)).evict();
    if (!mounted) return;
    final matchText = (widget.tx.merchant?.name ?? widget.tx.title)
        .trim()
        .toLowerCase();
    await widget.state.saveTransactionImage(
      widget.tx,
      savedPath,
      exact: false,
      matchText: matchText,
    );
  }

  Future<void> _clearImage() async {
    await widget.state.clearTransactionImage(widget.tx);
  }

  void _pickCategory() {
    final known = AutoCategorizer.categoriesByGroup;
    final currentName = widget.state.categoryNameFor(widget.tx);

    final akahuCats = <String>[];
    for (final t in widget.state.transactions) {
      if (t.category?.name != null &&
          !known.values.any((list) => list.contains(t.category!.name)) &&
          !akahuCats.contains(t.category!.name)) {
        akahuCats.add(t.category!.name);
      }
    }

    final matchLabel = widget.tx.merchant?.name ?? widget.tx.title;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => CategoryPicker(
        known: known,
        extra: akahuCats,
        current: currentName,
        matchLabel: matchLabel.isNotEmpty ? matchLabel : null,
        onPick: (cat, applyToFuture) {
          if (cat == 'Uncategorised') {
            widget.state.clearCategoryOverride(widget.tx.id);
          } else {
            widget.state.saveCategoryOverride(
              widget.tx.id,
              cat,
              applyToFuture: applyToFuture,
              matchText: matchLabel,
            );
          }
          Navigator.of(ctx).pop();
        },
      ),
    );
  }

  Future<void> _report(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => _ReportDialog(api: widget.state.api, tx: widget.tx),
    );
    if (result != null && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final fern = context.fern;
    final tx = widget.tx;
    final meta = tx.meta;
    final conversion = meta?.conversion;
    final state = widget.state;
    final categoryName = state.categoryNameFor(tx) ?? 'Uncategorised';
    final categoryGroup = state.categoryGroupFor(tx);
    final overridden = state.hasOverride(tx.id);
    final autoGuess = state.isAutoCategory(tx);
    return DraggableScrollableSheet(
      initialChildSize: 0.62,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      expand: false,
      builder: (context, scroll) => ListView(
        controller: scroll,
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: fern.slate.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    LogoAvatar(
                      url: meta?.logo,
                      filePath: state.imagePathFor(tx),
                      color: colorForCategory(categoryGroup ?? 'Uncategorised'),
                      size: 46,
                    ),
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: fern.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: fern.cream, width: 1.5),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          size: 11,
                          color: fern.onGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tx.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${longDate(tx.date)} · ${txTypeLabel(tx.type)}',
                      style: TextStyle(color: fern.slate, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              money(tx.amount, sign: true),
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w800,
                letterSpacing: -1,
                color: tx.amount > 0 ? fern.green : fern.ink,
              ),
            ),
          ),
          if (conversion != null) ...[
            const SizedBox(height: 4),
            Center(
              child: Text(
                '${money(conversion.amount, currency: conversion.currency ?? '')} @ ${conversion.rate}',
                style: TextStyle(color: fern.slate, fontSize: 13),
              ),
            ),
          ],
          const SizedBox(height: 20),
          Card(
            child: Column(
              children: [
                if (tx.description.isNotEmpty && tx.description != tx.title)
                  _row(Icons.notes, 'Statement description', tx.description),
                if (tx.merchant?.name != null)
                  _row(Icons.storefront, 'Merchant', tx.merchant!.name!),
                if (tx.merchant?.website != null)
                  _row(Icons.language, 'Website', tx.merchant!.website!),
                InkWell(
                  onTap: _pickCategory,
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.category_outlined,
                          size: 18,
                          color: fern.moss,
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 118,
                          child: Text(
                            'Category',
                            style: TextStyle(color: fern.slate, fontSize: 13),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${categoryGroup != null ? '$categoryGroup · ' : ''}$categoryName${overridden
                                ? ' (edited)'
                                : autoGuess
                                ? ' (auto)'
                                : ''}',
                            style: const TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Icon(Icons.edit_outlined, size: 16, color: fern.slate),
                      ],
                    ),
                  ),
                ),
                if (meta?.particulars != null)
                  _row(Icons.tag, 'Particulars', meta!.particulars!),
                if (meta?.code != null) _row(Icons.code, 'Code', meta!.code!),
                if (meta?.reference != null)
                  _row(Icons.numbers, 'Reference', meta!.reference!),
                if (meta?.otherAccount != null)
                  _row(
                    Icons.account_balance_outlined,
                    'Other account',
                    meta!.otherAccount!,
                  ),
                if (meta?.cardSuffix != null)
                  _row(Icons.credit_card, 'Card', '•••• ${meta!.cardSuffix}'),
                if (tx.balance != null)
                  _row(
                    Icons.account_balance_wallet_outlined,
                    'Balance after',
                    money(tx.balance),
                  ),
                _row(Icons.fingerprint, 'Transaction ID', tx.id),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (overridden) ...[
            const SizedBox(height: 10),
            TextButton.icon(
              onPressed: _clearOverride,
              icon: Icon(Icons.undo, size: 18, color: fern.slate),
              label: Text(
                'Revert to original category',
                style: TextStyle(color: fern.slate),
              ),
            ),
          ],
          if (state.imagePathFor(tx) != null) ...[
            const SizedBox(height: 10),
            TextButton.icon(
              onPressed: _clearImage,
              icon: Icon(Icons.undo, size: 18, color: fern.slate),
              label: Text(
                'Remove custom image',
                style: TextStyle(color: fern.slate),
              ),
            ),
          ],
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: () => _report(context),
            icon: const Icon(Icons.flag_outlined, size: 18),
            label: const Text('Report an issue'),
          ),
        ],
      ),
    );
  }

  Widget _row(IconData icon, String label, String value) {
    final fern = context.fern;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: fern.moss),
          const SizedBox(width: 12),
          SizedBox(
            width: 118,
            child: Text(
              label,
              style: TextStyle(color: fern.slate, fontSize: 13),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportDialog extends StatefulWidget {
  final AkahuApi api;
  final Transaction tx;

  const _ReportDialog({required this.api, required this.tx});

  @override
  State<_ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<_ReportDialog> {
  String _type = 'DUPLICATE';
  final _otherIdCtrl = TextEditingController();
  final _fieldsCtrl = TextEditingController();
  final _commentCtrl = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _otherIdCtrl.dispose();
    _fieldsCtrl.dispose();
    _commentCtrl.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    setState(() => _sending = true);
    try {
      await widget.api.reportTransaction(
        widget.tx.id,
        type: _type,
        otherId: _type == 'DUPLICATE' && _otherIdCtrl.text.isNotEmpty
            ? _otherIdCtrl.text.trim()
            : null,
        fields: _type != 'DUPLICATE' && _fieldsCtrl.text.isNotEmpty
            ? _fieldsCtrl.text.split(',').map((e) => e.trim()).toList()
            : null,
        comment: _commentCtrl.text.isNotEmpty ? _commentCtrl.text.trim() : null,
      );
      if (mounted) Navigator.of(context).pop('Thanks — report sent to Akahu');
    } catch (e) {
      setState(() => _sending = false);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Report an issue'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              initialValue: _type,
              decoration: const InputDecoration(labelText: 'Issue type'),
              items: const [
                DropdownMenuItem(
                  value: 'DUPLICATE',
                  child: Text('Duplicate transaction'),
                ),
                DropdownMenuItem(
                  value: 'ENRICHMENT_ERROR',
                  child: Text('Wrong enrichment'),
                ),
                DropdownMenuItem(
                  value: 'ENRICHMENT_SUGGESTION',
                  child: Text('Suggest enrichment'),
                ),
              ],
              onChanged: (v) => setState(() => _type = v!),
            ),
            if (_type == 'DUPLICATE') ...[
              const SizedBox(height: 12),
              TextField(
                controller: _otherIdCtrl,
                decoration: const InputDecoration(
                  labelText: 'Duplicate transaction ID',
                  hintText: 'trans_…',
                ),
              ),
            ] else ...[
              const SizedBox(height: 12),
              TextField(
                controller: _fieldsCtrl,
                decoration: const InputDecoration(
                  labelText: 'Fields (comma separated)',
                  hintText: 'merchant.name, category',
                ),
              ),
            ],
            const SizedBox(height: 12),
            TextField(
              controller: _commentCtrl,
              decoration: const InputDecoration(labelText: 'Comment'),
              maxLines: 2,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _sending ? null : _send,
          style: FilledButton.styleFrom(minimumSize: const Size(90, 44)),
          child: const Text('Send'),
        ),
      ],
    );
  }
}
