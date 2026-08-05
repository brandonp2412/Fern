import 'dart:async';

import 'package:flutter/material.dart';

import '../db/app_database.dart';
import '../models/transaction.dart';
import '../services/auto_categorizer.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../utils/format.dart';
import '../widgets/common.dart';

class CategorizeSpendingScreen extends StatefulWidget {
  final AppState state;
  final DateTime? start;
  final DateTime? end;
  final Set<String>? catFilter;

  const CategorizeSpendingScreen({
    super.key,
    required this.state,
    this.start,
    this.end,
    this.catFilter,
  });

  @override
  State<CategorizeSpendingScreen> createState() =>
      _CategorizeSpendingScreenState();
}

class _CategorizeSpendingScreenState extends State<CategorizeSpendingScreen> {
  final _searchCtrl = TextEditingController();
  String _query = '';
  Timer? _debounce;
  late Set<String> _selectedCategories;
  StreamSubscription<List<SpendingGroup>>? _groupsSub;
  StreamSubscription<List<String>>? _categoriesSub;
  List<SpendingGroup> _groups = const [];
  List<String> _availableCategories = const [];

  @override
  void initState() {
    super.initState();
    _selectedCategories = {...?widget.catFilter};
    widget.state.addListener(_onChange);
    _subscribeToGroups();
    _categoriesSub = widget.state.db
        .watchSpendingCategories(start: widget.start, end: widget.end)
        .listen((categories) {
          if (mounted) setState(() => _availableCategories = categories);
        });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    unawaited(_groupsSub?.cancel());
    unawaited(_categoriesSub?.cancel());
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
      _subscribeToGroups();
    });
  }

  void _subscribeToGroups() {
    unawaited(_groupsSub?.cancel());
    _groupsSub = widget.state.db
        .watchSpendingGroups(
          start: widget.start,
          end: widget.end,
          query: _query,
          categoryFilter: _selectedCategories,
        )
        .listen((groups) {
          if (mounted) setState(() => _groups = groups);
        });
  }

  @override
  Widget build(BuildContext context) {
    final txCount = widget.state.transactions
        .where((tx) => tx.amount < 0)
        .length;
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
                                _subscribeToGroups();
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
                    children: [
                      _categoryChip(
                        label: 'All',
                        selected: _selectedCategories.isEmpty,
                        onSelected: (_) => _setCategories({}),
                      ),
                      for (final category in _availableCategories)
                        _categoryChip(
                          label: category,
                          selected: _selectedCategories.contains(category),
                          onSelected: (selected) =>
                              _toggleCategory(category, selected),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: _groups.isEmpty
                      ? const EmptyState(
                          icon: Icons.search_off,
                          title: 'No matches',
                          message: 'Try a different search.',
                        )
                      : ListView(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                          children: [
                            for (final group in _groups) ...[
                              _groupSection(group),
                            ],
                          ],
                        ),
                ),
              ],
            ),
    );
  }

  Widget _categoryChip({
    required String label,
    required bool selected,
    required ValueChanged<bool> onSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: onSelected,
        showCheckmark: false,
        labelStyle: TextStyle(
          color: selected ? context.fern.onGreen : context.fern.ink,
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _setCategories(Set<String> categories) {
    setState(() => _selectedCategories = categories);
    _subscribeToGroups();
  }

  void _toggleCategory(String category, bool selected) {
    final categories = {..._selectedCategories};
    if (selected) {
      categories.add(category);
    } else {
      categories.remove(category);
    }
    _setCategories(categories);
  }

  Widget _groupSection(SpendingGroup group) {
    final transactionsById = {
      for (final tx in widget.state.transactions) tx.id: tx,
    };
    final txns = group.transactionIds
        .map((id) => transactionsById[id])
        .whereType<Transaction>()
        .toList();
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
                  group.name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                    color: fern.ink,
                  ),
                ),
              ),
              Text(
                '${group.transactionCount} txns · ${money(group.total)}',
                style: TextStyle(fontSize: 12, color: fern.slate),
              ),
            ],
          ),
        ),
        Card(child: Column(children: [for (final tx in txns) _txnRow(tx)])),
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
