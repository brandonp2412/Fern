import 'dart:async';

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../services/auto_categorizer.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../utils/format.dart';
import '../widgets/common.dart';
import '../widgets/txn_tile.dart';
import 'txn_detail.dart';

class ActivityScreen extends StatefulWidget {
  final AppState state;

  const ActivityScreen({super.key, required this.state});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final _scroll = ScrollController();
  final _searchCtrl = TextEditingController();
  String _query = '';
  String _direction = 'all';
  String _sortOrder = 'date_desc';
  Set<String> _selectedCategories = {};
  Timer? _debounce;
  bool _selectionMode = false;
  Set<String> _selectedTxnIds = {};

  @override
  void initState() {
    super.initState();
    widget.state.addListener(_onAppStateChange);
    _scroll.addListener(() {
      final state = widget.state;
      if (_scroll.position.pixels > _scroll.position.maxScrollExtent - 300 &&
          state.txnCursor != null) {
        state.loadOlder();
      }
    });
  }

  void _onAppStateChange() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    _debounce?.cancel();
    widget.state.removeListener(_onAppStateChange);
    _scroll.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  void _setQuery(String v) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () {
      if (!mounted) return;
      setState(() => _query = _searchCtrl.text.trim());
    });
  }

  Set<String> get _availableCategories {
    final cats = <String>{};
    for (final tx in widget.state.transactions) {
      cats.add(widget.state.categoryGroupFor(tx) ?? 'Uncategorised');
    }
    return cats;
  }

  List<Transaction> get _filtered {
    final catFilter = _selectedCategories;
    return widget.state.transactions.where((tx) {
      if (_direction == 'in' && tx.amount <= 0) return false;
      if (_direction == 'out' && tx.amount >= 0) return false;
      if (catFilter.isNotEmpty) {
        final cat = widget.state.categoryGroupFor(tx) ?? 'Uncategorised';
        if (!catFilter.contains(cat)) return false;
      }
      if (_query.isNotEmpty) {
        final q = _query.toLowerCase();
        final searchHay = [
          tx.description,
          tx.merchant?.name ?? '',
          tx.category?.name ?? '',
          tx.category?.groupName ?? '',
          txTypeLabel(tx.type),
        ].join(' ').toLowerCase();
        if (!searchHay.contains(q)) return false;
      }
      return true;
    }).toList();
  }

  Map<String, List<Transaction>> get _grouped {
    final map = <String, List<Transaction>>{};
    for (final tx in _filtered) {
      final d = parseDate(tx.date);
      final key = d == null ? 'Unknown' : isoDay(d);
      map.putIfAbsent(key, () => []).add(tx);
    }
    if (_sortOrder == 'amount_desc' || _sortOrder == 'amount_asc') {
      final asc = _sortOrder == 'amount_asc';
      for (final txns in map.values) {
        txns.sort(
          (a, b) =>
              asc ? a.amount.compareTo(b.amount) : b.amount.compareTo(a.amount),
        );
      }
    }
    return map;
  }

  void _enterSelectionMode(String txnId) {
    setState(() {
      _selectionMode = true;
      _selectedTxnIds = {txnId};
    });
  }

  void _toggleSelection(String txnId) {
    setState(() {
      if (_selectedTxnIds.contains(txnId)) {
        _selectedTxnIds = {..._selectedTxnIds}..remove(txnId);
      } else {
        _selectedTxnIds = {..._selectedTxnIds, txnId};
      }
      if (_selectedTxnIds.isEmpty) _selectionMode = false;
    });
  }

  void _exitSelectionMode() {
    setState(() {
      _selectionMode = false;
      _selectedTxnIds = {};
    });
  }

  void _bulkCategorize() {
    final known = AutoCategorizer.categoriesByGroup;
    final akahuCats = <String>[];
    for (final t in widget.state.transactions) {
      if (t.category?.name != null &&
          !known.values.any((list) => list.contains(t.category!.name)) &&
          !akahuCats.contains(t.category!.name)) {
        akahuCats.add(t.category!.name);
      }
    }
    final ids = _selectedTxnIds.toList();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => CategoryPicker(
        known: known,
        extra: akahuCats,
        current: null,
        onPick: (cat, _) async {
          Navigator.of(ctx).pop();
          await widget.state.saveCategoryOverrides(ids, cat);
          if (mounted) _exitSelectionMode();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectionMode
          ? AppBar(
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: _exitSelectionMode,
              ),
              title: Text('${_selectedTxnIds.length} selected'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.category_outlined),
                  tooltip: 'Set category',
                  onPressed: _selectedTxnIds.isEmpty ? null : _bulkCategorize,
                ),
              ],
            )
          : AppBar(
              title: const Text('Activity'),
              actions: [if (widget.state.refreshing) const AppBarSpinner()],
            ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              controller: _searchCtrl,
              onChanged: _setQuery,
              decoration: InputDecoration(
                hintText: 'Search merchants, categories…',
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _searchCtrl,
                  builder: (_, value, _) {
                    if (value.text.isEmpty) return const SizedBox.shrink();
                    return IconButton(
                      icon: const Icon(Icons.close, size: 18),
                      onPressed: () {
                        _searchCtrl.clear();
                        _debounce?.cancel();
                        setState(() => _query = '');
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _chip(
                  'All',
                  _direction == 'all',
                  () => setState(() => _direction = 'all'),
                ),
                _chip(
                  'Money in',
                  _direction == 'in',
                  () => setState(() => _direction = 'in'),
                  icon: Icons.call_received,
                ),
                _chip(
                  'Money out',
                  _direction == 'out',
                  () => setState(() => _direction = 'out'),
                  icon: Icons.call_made,
                ),
                _categoryButton(),
                _sortButton(),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(child: _body()),
        ],
      ),
    );
  }

  Widget _chip(
    String label,
    bool selected,
    VoidCallback onTap, {
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        avatar: icon != null
            ? Icon(
                icon,
                size: 16,
                color: selected ? Colors.white : context.fern.ink,
              )
            : null,
        onSelected: (_) => onTap(),
        showCheckmark: false,
        labelStyle: TextStyle(
          color: selected ? Colors.white : context.fern.ink,
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
        ),
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
          color: count > 0 ? Colors.white : context.fern.ink,
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
                                    ? Colors.white
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

  static const _sortLabels = {
    'date_desc': 'Newest',
    'date_asc': 'Oldest',
    'amount_desc': 'Highest',
    'amount_asc': 'Lowest',
  };

  Widget _sortButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(_sortLabels[_sortOrder]!),
        selected: _sortOrder != 'date_desc',
        avatar: const Icon(Icons.sort, size: 16),
        onSelected: (_) => _openSortModal(),
        showCheckmark: false,
        labelStyle: TextStyle(
          color: _sortOrder != 'date_desc' ? Colors.white : context.fern.ink,
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _openSortModal() {
    var pending = _sortOrder;
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
                    const Text(
                      'Order by',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final entry in _sortLabels.entries)
                          FilterChip(
                            label: Text(entry.value),
                            selected: pending == entry.key,
                            showCheckmark: false,
                            labelStyle: TextStyle(
                              color: pending == entry.key
                                  ? Colors.white
                                  : context.fern.ink,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                            ),
                            onSelected: (_) =>
                                setModalState(() => pending = entry.key),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          setState(() => _sortOrder = pending);
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

  Widget _body() {
    final state = widget.state;
    if (state.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.accounts.isEmpty &&
        state.transactions.isEmpty &&
        state.error != null) {
      return ErrorState(error: state.error!, onRetry: () => state.load());
    }
    final grouped = _grouped;
    if (grouped.isEmpty) {
      return const EmptyState(
        icon: Icons.receipt_long_outlined,
        title: 'No transactions',
        message: 'Try widening your filters or date range.',
      );
    }
    final keys = grouped.keys.toList()
      ..sort(
        (a, b) => _sortOrder == 'date_asc' ? a.compareTo(b) : b.compareTo(a),
      );
    return RefreshIndicator(
      onRefresh: () => state.load(force: true),
      child: ListView.builder(
        controller: _scroll,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        itemCount: keys.length + 1,
        itemBuilder: (context, i) {
          if (i == keys.length) {
            return state.txnCursor != null
                ? const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : const SizedBox(height: 40);
          }
          final fern = context.fern;
          final key = keys[i];
          final dayTxns = grouped[key]!;
          final net = dayTxns.fold<num>(0, (s, t) => s + t.amount);
          final masked = state.settings.hideBalances;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 14, 4, 6),
                child: Row(
                  children: [
                    Text(
                      relativeDate(key),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: fern.slate,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      masked ? '••••' : money(net, sign: true),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: net >= 0 ? fern.green : fern.slate,
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      for (final tx in dayTxns)
                        TxnTile(
                          tx: tx,
                          categoryGroupOverride: state.categoryGroupFor(tx),
                          imagePath: state.imagePathFor(tx),
                          masked: masked,
                          selectionMode: _selectionMode,
                          selected: _selectedTxnIds.contains(tx.id),
                          onTap: () => _selectionMode
                              ? _toggleSelection(tx.id)
                              : showTxnDetail(context, state, tx),
                          onLongPress: _selectionMode
                              ? null
                              : () => _enterSelectionMode(tx.id),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
