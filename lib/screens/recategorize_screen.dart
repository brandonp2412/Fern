import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../services/auto_categorizer.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../utils/format.dart';
import '../widgets/common.dart';

class RecategorizeScreen extends StatefulWidget {
  final AppState state;

  const RecategorizeScreen({super.key, required this.state});

  @override
  State<RecategorizeScreen> createState() => _RecategorizeScreenState();
}

class _RecategorizeScreenState extends State<RecategorizeScreen> {
  @override
  void initState() {
    super.initState();
    widget.state.addListener(_onChange);
  }

  @override
  void dispose() {
    widget.state.removeListener(_onChange);
    super.dispose();
  }

  void _onChange() {
    if (mounted) setState(() {});
  }

  Map<String, List<Transaction>> _groupTxns() {
    final groups = <String, List<Transaction>>{};
    for (final tx in widget.state.transactions) {
      if (tx.amount >= 0) continue;
      final group = widget.state.categoryGroupFor(tx) ?? 'Uncategorised';
      groups.putIfAbsent(group, () => []).add(tx);
    }
    final sorted = groups.entries.toList()
      ..sort((a, b) {
        final aTotal = a.value.fold<double>(0, (s, t) => s + t.amount.abs());
        final bTotal = b.value.fold<double>(0, (s, t) => s + t.amount.abs());
        return bTotal.compareTo(aTotal);
      });
    return {for (final e in sorted) e.key: e.value};
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _groupTxns();

    return Scaffold(
      appBar: AppBar(title: const Text('Categorize spending')),
      body: grouped.isEmpty
          ? const EmptyState(
              icon: Icons.category_outlined,
              title: 'Nothing to categorize',
              message: 'No spending transactions yet.',
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              children: [
                for (final e in grouped.entries) ...[
                  _groupSection(e.key, e.value),
                ],
              ],
            ),
    );
  }

  Widget _groupSection(String group, List<Transaction> txns) {
    final total = txns.fold<double>(0, (s, t) => s + t.amount.abs());
    final fern = context.fern;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 20, 4, 6),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  group,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                    color: fern.ink,
                  ),
                ),
              ),
              Text(
                '${txns.length} txns · ${money(total)}',
                style: TextStyle(fontSize: 12, color: fern.slate),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            children: [
              for (final tx in txns) _txnRow(tx),
            ],
          ),
        ),
      ],
    );
  }

  Widget _txnRow(Transaction tx) {
    final fern = context.fern;
    final catName = widget.state.categoryNameFor(tx);
    final overridden = widget.state.hasOverride(tx.id);

    return InkWell(
      onTap: () => _pickCategory(tx),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tx.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    catName != null
                        ? '${overridden ? "✓ " : ""}$catName'
                        : 'Uncategorised',
                    style: TextStyle(
                      fontSize: 12,
                      color: overridden ? fern.moss : fern.slate,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              money(tx.amount.abs()),
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                color: fern.clay,
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.edit_outlined, size: 17, color: fern.slate),
          ],
        ),
      ),
    );
  }

  void _pickCategory(Transaction tx) {
    final known = AutoCategorizer.categoriesByGroup;
    final currentName = widget.state.categoryNameFor(tx);

    final akahuCats = <String>[];
    for (final t in widget.state.transactions) {
      if (t.category?.name != null &&
          !known.values.any((list) => list.contains(t.category!.name)) &&
          !akahuCats.contains(t.category!.name)) {
        akahuCats.add(t.category!.name);
      }
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => _CategoryPicker(
        known: known,
        extra: akahuCats,
        current: currentName,
        onPick: (cat) {
          if (cat == 'Uncategorised') {
            widget.state.clearCategoryOverride(tx.id);
          } else {
            widget.state.saveCategoryOverride(tx.id, cat);
          }
          Navigator.of(ctx).pop();
        },
      ),
    );
  }
}

class _CategoryPicker extends StatefulWidget {
  final Map<String, List<String>> known;
  final List<String> extra;
  final String? current;
  final ValueChanged<String> onPick;

  const _CategoryPicker({
    required this.known,
    required this.extra,
    required this.current,
    required this.onPick,
  });

  @override
  State<_CategoryPicker> createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<_CategoryPicker> {
  final _searchCtrl = TextEditingController();
  String _q = '';

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(() => setState(() => _q = _searchCtrl.text.toLowerCase()));
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  bool _matches(String cat) => _q.isEmpty || cat.toLowerCase().contains(_q);

  @override
  Widget build(BuildContext context) {
    final fern = context.fern;
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      expand: false,
      builder: (context, scroll) => Column(
        children: [
          const SizedBox(height: 8),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                hintText: 'Search categories...',
                prefixIcon: Icon(Icons.search, size: 20, color: fern.slate),
                filled: true,
                fillColor: fern.mist,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              controller: scroll,
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
              children: [
                if (_matches('Uncategorised'))
                  _catOption('Uncategorised', null, context),
                for (final e in widget.known.entries) ...[
                  if (e.value.any(_matches)) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 14, 4, 4),
                      child: Text(
                        e.key,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: fern.slate,
                        ),
                      ),
                    ),
                    for (final cat in e.value)
                      if (_matches(cat)) _catOption(cat, e.key, context),
                  ],
                ],
                if (widget.extra.any(_matches)) ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 14, 4, 4),
                    child: Text(
                      'From bank',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: fern.slate,
                      ),
                    ),
                  ),
                  for (final cat in widget.extra)
                    if (_matches(cat)) _catOption(cat, null, context),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _catOption(String name, String? group, BuildContext context) {
    final fern = context.fern;
    final selected = widget.current == name;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        tileColor: selected ? fern.green.withValues(alpha: 0.08) : null,
        title: Text(
          name,
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected ? fern.green : null,
          ),
        ),
        trailing: selected
            ? Icon(Icons.check, size: 18, color: fern.green)
            : null,
        onTap: () => widget.onPick(name),
      ),
    );
  }
}
