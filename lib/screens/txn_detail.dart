import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/transaction.dart';
import '../services/akahu_api.dart';
import '../state/app_state.dart';
import '../theme.dart';
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

  Future<void> _recategorize() async {
    final tx = widget.tx;
    List<NzfccCategory> categories;
    try {
      categories = await widget.state.api.getCategories();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
      return;
    }
    if (!mounted) return;
    final chosen = await showModalBottomSheet<NzfccCategory>(
      context: context,
      isScrollControlled: true,
      builder: (context) => _CategoryPicker(categories: categories),
    );
    if (chosen != null) {
      await widget.state.setCategoryOverride(tx.id, chosen);
    }
  }

  Future<void> _clearOverride() async {
    await widget.state.clearCategoryOverride(widget.tx.id);
  }

  Future<void> _report(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) =>
          _ReportDialog(api: widget.state.api, tx: widget.tx),
    );
    if (result != null && context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final fern = context.fern;
    final tx = widget.tx;
    final meta = tx.meta;
    final conversion = meta?.conversion;
    final state = widget.state;
    final categoryName = state.categoryNameFor(tx);
    final categoryGroup = state.categoryGroupFor(tx);
    final overridden = state.hasOverride(tx.id);
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
              LogoAvatar(url: meta?.logo, size: 46),
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
                          letterSpacing: -0.3),
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
                if (categoryName != null)
                  _row(Icons.category_outlined, 'Category',
                      '${categoryGroup != null ? '$categoryGroup · ' : ''}$categoryName${overridden ? ' (edited)' : ''}'),
                if (meta?.particulars != null)
                  _row(Icons.tag, 'Particulars', meta!.particulars!),
                if (meta?.code != null)
                  _row(Icons.code, 'Code', meta!.code!),
                if (meta?.reference != null)
                  _row(Icons.numbers, 'Reference', meta!.reference!),
                if (meta?.otherAccount != null)
                  _row(Icons.account_balance_outlined, 'Other account',
                      meta!.otherAccount!),
                if (meta?.cardSuffix != null)
                  _row(Icons.credit_card, 'Card', '•••• ${meta!.cardSuffix}'),
                if (tx.balance != null)
                  _row(Icons.account_balance_wallet_outlined,
                      'Balance after', money(tx.balance)),
                _row(Icons.fingerprint, 'Transaction ID', tx.id),
              ],
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: _recategorize,
            icon: const Icon(Icons.edit_outlined, size: 18),
            label: const Text('Recategorize'),
          ),
          if (overridden) ...[
            const SizedBox(height: 10),
            TextButton.icon(
              onPressed: _clearOverride,
              icon: Icon(Icons.undo, size: 18, color: fern.slate),
              label: Text('Revert to original category',
                  style: TextStyle(color: fern.slate)),
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
            child: Text(label,
                style: TextStyle(color: fern.slate, fontSize: 13)),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryPicker extends StatefulWidget {
  final List<NzfccCategory> categories;

  const _CategoryPicker({required this.categories});

  @override
  State<_CategoryPicker> createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<_CategoryPicker> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final fern = context.fern;
    final filtered = widget.categories
        .where((c) =>
            _query.isEmpty || c.name.toLowerCase().contains(_query))
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        expand: false,
        builder: (context, scroll) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  const SizedBox(height: 14),
                  const Text('Choose a category',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 10),
                  TextField(
                    onChanged: (v) =>
                        setState(() => _query = v.trim().toLowerCase()),
                    decoration: const InputDecoration(
                      hintText: 'Search categories…',
                      prefixIcon: Icon(Icons.search, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scroll,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: filtered.length,
                itemBuilder: (context, i) {
                  final c = filtered[i];
                  return ListTile(
                    dense: true,
                    title: Text(c.name,
                        style: const TextStyle(
                            fontSize: 13.5, fontWeight: FontWeight.w600)),
                    subtitle: c.groupName != null
                        ? Text(c.groupName!,
                            style:
                                TextStyle(fontSize: 11, color: fern.slate))
                        : null,
                    onTap: () => Navigator.of(context).pop(c),
                  );
                },
              ),
            ),
          ],
        ),
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
        comment:
            _commentCtrl.text.isNotEmpty ? _commentCtrl.text.trim() : null,
      );
      if (mounted) Navigator.of(context).pop('Thanks — report sent to Akahu');
    } catch (e) {
      setState(() => _sending = false);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
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
                    value: 'DUPLICATE', child: Text('Duplicate transaction')),
                DropdownMenuItem(
                    value: 'ENRICHMENT_ERROR',
                    child: Text('Wrong enrichment')),
                DropdownMenuItem(
                    value: 'ENRICHMENT_SUGGESTION',
                    child: Text('Suggest enrichment')),
              ],
              onChanged: (v) => setState(() => _type = v!),
            ),
            if (_type == 'DUPLICATE') ...[
              const SizedBox(height: 12),
              TextField(
                controller: _otherIdCtrl,
                decoration: const InputDecoration(
                    labelText: 'Duplicate transaction ID',
                    hintText: 'trans_…'),
              ),
            ] else ...[
              const SizedBox(height: 12),
              TextField(
                controller: _fieldsCtrl,
                decoration: const InputDecoration(
                    labelText: 'Fields (comma separated)',
                    hintText: 'merchant.name, category'),
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
