import 'dart:async';

import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../services/auto_categorizer.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../utils/format.dart';
import '../widgets/common.dart';

class RecategorizeScreen extends StatefulWidget {
  final AppState state;
  final DateTime? start;
  final DateTime? end;
  final Set<String>? catFilter;

  const RecategorizeScreen({
    super.key,
    required this.state,
    this.start,
    this.end,
    this.catFilter,
  });

  @override
  State<RecategorizeScreen> createState() => _RecategorizeScreenState();
}

class _RecategorizeScreenState extends State<RecategorizeScreen> {
  final _searchCtrl = TextEditingController();
  String _query = '';
  Timer? _debounce;
  late Set<String> _selectedCategories;

  @override
  void initState() {
    super.initState();
    _selectedCategories = {...?widget.catFilter};
    widget.state.addListener(_onChange);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchCtrl.dispose();
    widget.state.removeListener(_onChange);
    super.dispose();
  }

  void _onChange() {
    if (mounted) setState(() {});
  }

  void _setQuery(String v) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () {
      if (!mounted) return;
      setState(() => _query = v.trim());
    });
  }

  bool _txMatches(Transaction tx) {
    if (_query.isEmpty) return true;
    final q = _query.toLowerCase();
    final hay = [
      tx.title,
      tx.description,
      tx.category?.name ?? '',
      tx.category?.groupName ?? '',
    ].join(' ').toLowerCase();
    return hay.contains(q);
  }

  bool _inDateRange(Transaction tx) {
    if (widget.start == null && widget.end == null) return true;
    final parsed = DateTime.tryParse(tx.date);
    if (parsed == null) return true;
    final local = parsed.toLocal();
    final d = DateTime(local.year, local.month, local.day);
    if (widget.start != null && d.isBefore(widget.start!)) return false;
    if (widget.end != null && d.isAfter(widget.end!)) return false;
    return true;
  }

  Set<String> get _availableCategories {
    final cats = <String>{};
    for (final tx in widget.state.transactions) {
      if (tx.amount >= 0) continue;
      if (!_inDateRange(tx)) continue;
      cats.add(widget.state.categoryGroupFor(tx) ?? 'Uncategorised');
    }
    return cats;
  }

  Map<String, List<Transaction>> _groupTxns() {
    final groups = <String, List<Transaction>>{};
    for (final tx in widget.state.transactions) {
      if (tx.amount >= 0) continue;
      if (!_txMatches(tx)) continue;
      if (!_inDateRange(tx)) continue;
      final group = widget.state.categoryGroupFor(tx) ?? 'Uncategorised';
      if (_selectedCategories.isNotEmpty && !_selectedCategories.contains(group)) continue;
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
    final txCount = widget.state.transactions.where((tx) => tx.amount < 0).length;
    final hasTxns = txCount > 0;

    return Scaffold(
      appBar: AppBar(title: const Text('Categorize spending')),
      body: !hasTxns
          ? const EmptyState(
              icon: Icons.category_outlined,
              title: 'Nothing to categorize',
              message: 'No spending transactions yet.',
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: TextField(
                    controller: _searchCtrl,
                    onChanged: _setQuery,
                    decoration: InputDecoration(
                      hintText: 'Search merchants, categories…',
                      prefixIcon: const Icon(Icons.search, size: 20),
                      suffixIcon: _query.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.close, size: 18),
                              onPressed: () {
                                _searchCtrl.clear();
                                _debounce?.cancel();
                                setState(() => _query = '');
                              },
                            )
                          : null,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [_categoryButton()],
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: grouped.isEmpty
                      ? const EmptyState(
                          icon: Icons.search_off,
                          title: 'No matches',
                          message: 'Try a different search.',
                        )
                      : ListView(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                          children: [
                            for (final e in grouped.entries) ...[
                              _groupSection(e.key, e.value),
                            ],
                          ],
                        ),
                ),
              ],
            ),
    );
  }

  Widget _categoryButton() {
    final count = _selectedCategories.length;
    final label = count == 0 ? 'Categories' : 'Categories ($count)';
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: count > 0,
        avatar: const Icon(Icons.filter_list, size: 16),
        onSelected: (_) => _openCategoryModal(),
        showCheckmark: false,
        labelStyle: TextStyle(
          color: count > 0 ? context.fern.onGreen : context.fern.ink,
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _openCategoryModal() {
    final cats = _availableCategories.toList()
      ..sort((a, b) {
        if (a == 'Uncategorised') return 1;
        if (b == 'Uncategorised') return -1;
        return a.compareTo(b);
      });
    var pending = {..._selectedCategories};
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setModalState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (cats.isNotEmpty)
                          TextButton(
                            onPressed: () => setModalState(() {
                              pending = pending.length == cats.length
                                  ? {}
                                  : cats.toSet();
                            }),
                            child: Text(
                              pending.length == cats.length
                                  ? 'Clear'
                                  : 'Select all',
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (cats.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text('No categories yet'),
                      )
                    else
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final cat in cats)
                            FilterChip(
                              label: Text(cat),
                              selected: pending.contains(cat),
                              showCheckmark: false,
                              labelStyle: TextStyle(
                                color: pending.contains(cat)
                                    ? context.fern.onGreen
                                    : context.fern.ink,
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                              ),
                              onSelected: (val) {
                                setModalState(() {
                                  if (val) {
                                    pending = {...pending, cat};
                                  } else {
                                    pending = {...pending}..remove(cat);
                                  }
                                });
                              },
                            ),
                        ],
                      ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          setState(() => _selectedCategories = pending);
                          Navigator.of(ctx).pop();
                        },
                        child: const Text('Apply'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
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

    final matchLabel = tx.merchant?.name ?? tx.title;

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
            widget.state.clearCategoryOverride(tx.id);
          } else {
            widget.state.saveCategoryOverride(
              tx.id,
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
}

