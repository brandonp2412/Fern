import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../state/app_state.dart';
import '../theme.dart';
import '../utils/category_colors.dart';
import '../utils/format.dart';
import '../widgets/common.dart';
import 'categorize_spending_screen.dart';

enum _StatsRange { m6, y1, custom, all }

class _MonthBucket {
  final String key;
  final String label;
  const _MonthBucket(this.key, this.label);
}

List<_MonthBucket> _monthsBetween(DateTime start, DateTime end) {
  final result = <_MonthBucket>[];
  var cursor = DateTime(start.year, start.month, 1);
  final last = DateTime(end.year, end.month, 1);
  while (!cursor.isAfter(last) && result.length < 24) {
    final key =
        '${cursor.year.toString().padLeft(4, '0')}-${cursor.month.toString().padLeft(2, '0')}';
    result.add(_MonthBucket(key, DateFormat('MMM').format(cursor)));
    cursor = DateTime(cursor.year, cursor.month + 1, 1);
  }
  return result;
}

class StatsScreen extends StatefulWidget {
  final AppState state;

  const StatsScreen({super.key, required this.state});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  _StatsRange _range = _StatsRange.m6;
  DateTimeRange? _customRange;
  Set<String> _catFilter = {};

  Map<String, (double, double)> _monthly = {};
  Map<String, double> _categoryTotals = {};
  Map<String, double> _weekly = {};
  Map<String, double> _merchants = {};

  StreamSubscription<Map<String, (double, double)>>? _monthlySub;
  StreamSubscription<Map<String, double>>? _catSub;
  StreamSubscription<Map<String, double>>? _weeklySub;
  StreamSubscription<Map<String, double>>? _merchantsSub;

  @override
  void initState() {
    super.initState();
    _subscribe();
    _loadMoreIfNeeded();
  }

  void _loadMoreIfNeeded() {
    final (start, _) = _rangeBounds();
    if (start != null) {
      widget.state.ensureDataSince(start);
    }
  }

  void _subscribe() {
    _unsubscribe();
    final db = widget.state.db;
    final (start, end) = _rangeBounds();
    final cats = _catFilter.isNotEmpty ? _catFilter : null;
    _monthlySub = db
        .queryMonthlyTotals(start: start, end: end, categoryFilter: cats)
        .listen((d) => setState(() => _monthly = d));
    _catSub = db
        .queryCategoryTotals(start: start, end: end, categoryFilter: cats)
        .listen((d) => setState(() => _categoryTotals = d));
    _weeklySub = db
        .queryWeeklyTrend(start: start, end: end, categoryFilter: cats)
        .listen((d) => setState(() => _weekly = d));
    _merchantsSub = db
        .queryTopMerchants(start: start, end: end, categoryFilter: cats)
        .listen((d) => setState(() => _merchants = d));
  }

  void _unsubscribe() {
    _monthlySub?.cancel();
    _catSub?.cancel();
    _weeklySub?.cancel();
    _merchantsSub?.cancel();
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  (DateTime?, DateTime?) _rangeBounds() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    switch (_range) {
      case _StatsRange.m6:
        return (DateTime(today.year, today.month - 6, today.day), null);
      case _StatsRange.y1:
        return (DateTime(today.year - 1, today.month, today.day), null);
      case _StatsRange.custom:
        return (_customRange?.start, _customRange?.end);
      case _StatsRange.all:
        return (null, null);
    }
  }

  Future<void> _pickCustomRange(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 5),
      lastDate: now,
      initialDateRange:
          _customRange ??
          DateTimeRange(
            start: now.subtract(const Duration(days: 30)),
            end: now,
          ),
    );
    if (picked == null) return;
    setState(() {
      _range = _StatsRange.custom;
      _customRange = picked;
    });
    _subscribe();
    _loadMoreIfNeeded();
  }

  void _setRange(_StatsRange option) {
    setState(() => _range = option);
    _subscribe();
    _loadMoreIfNeeded();
  }

  Set<String> get _availableCategories {
    final cats = <String>{};
    for (final tx in widget.state.transactions) {
      cats.add(widget.state.categoryGroupFor(tx) ?? 'Uncategorised');
    }
    return cats;
  }

  List<MonthTotal> _buildMonthlyList() {
    final (rangeStart, rangeEnd) = _rangeBounds();
    final now = DateTime.now();
    final effectiveEnd = rangeEnd ?? now;
    DateTime effectiveStart;

    if (rangeStart != null) {
      effectiveStart = rangeStart;
    } else if (_monthly.isNotEmpty) {
      final sortedKeys = _monthly.keys.toList()..sort();
      final firstKey = sortedKeys.first;
      effectiveStart = DateTime(
        int.parse(firstKey.substring(0, 4)),
        int.parse(firstKey.substring(5, 7)),
        1,
      );
    } else {
      effectiveStart = effectiveEnd;
    }

    if (effectiveStart.isAfter(effectiveEnd)) effectiveStart = effectiveEnd;
    if (effectiveEnd.difference(effectiveStart).inDays > 365 * 2) {
      effectiveStart = DateTime(effectiveEnd.year - 2, effectiveEnd.month, 1);
    }

    final months = _monthsBetween(effectiveStart, effectiveEnd);
    return months.map((m) {
      final vals = _monthly[m.key] ?? (0.0, 0.0);
      return MonthTotal(label: m.label, income: vals.$1, expense: vals.$2);
    }).toList();
  }

  List<CategoryTotal> _buildCategoryList() {
    final entries = _categoryTotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return [
      for (final e in entries) CategoryTotal(name: e.key, amount: e.value),
    ];
  }

  List<WeekTotal> _buildWeeklyList() {
    final keys = _weekly.keys.toList()..sort();
    return [
      for (final k in keys)
        WeekTotal(
          label: DateFormat('d MMM').format(DateTime.parse(k)),
          total: _weekly[k]!,
        ),
    ];
  }

  List<MerchantTotal> _buildMerchantList() {
    final entries = _merchants.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return [
      for (final e in entries.take(5))
        MerchantTotal(name: e.key, amount: e.value),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stats'),
        actions: [
          if (widget.state.refreshing || widget.state.loadingOlder)
            const AppBarSpinner(),
        ],
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: widget.state,
          builder: (context, _) {
            final state = widget.state;

            if (state.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.accounts.isEmpty &&
                state.transactions.isEmpty &&
                state.error != null) {
              return ErrorState(
                error: state.error!,
                onRetry: () => state.load(),
              );
            }
            if (state.transactions.isEmpty) {
              return EmptyState(
                icon: Icons.bar_chart_outlined,
                title: 'Nothing to show yet',
                message:
                    'Once you have some transaction history, your spending trends will appear here.',
                actionLabel: 'Refresh',
                actionIcon: Icons.refresh_rounded,
                onAction: () => state.load(force: true),
              );
            }
            return RefreshIndicator(
              onRefresh: () => state.load(force: true),
              child: _body(context),
            );
          },
        ),
      ),
    );
  }

  Widget _rangeSelector(BuildContext context) {
    final labelFor = {
      _StatsRange.m6: '6 months',
      _StatsRange.y1: '1 year',
      _StatsRange.all: 'All time',
      _StatsRange.custom: _customRange == null
          ? 'Custom'
          : '${DateFormat('d MMM').format(_customRange!.start)} – ${DateFormat('d MMM').format(_customRange!.end)}',
    };
    final cnt = _catFilter.length;
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (final option in [
            _StatsRange.m6,
            _StatsRange.y1,
            _StatsRange.all,
            _StatsRange.custom,
          ])
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(labelFor[option]!),
                selected: _range == option,
                showCheckmark: false,
                onSelected: (_) {
                  if (option == _StatsRange.custom) {
                    _pickCustomRange(context);
                  } else {
                    _setRange(option);
                  }
                },
                labelStyle: TextStyle(
                  color: _range == option
                      ? context.fern.onGreen
                      : context.fern.ink,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          const SizedBox(width: 4),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(cnt == 0 ? 'Categories' : 'Categories ($cnt)'),
              selected: cnt > 0,
              avatar: const Icon(Icons.filter_list, size: 16),
              onSelected: (_) => _openCatModal(),
              showCheckmark: false,
              labelStyle: TextStyle(
                color: cnt > 0 ? context.fern.onGreen : context.fern.ink,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openCatModal() {
    final cats = _availableCategories.toList()
      ..sort((a, b) {
        if (a == 'Uncategorised') return 1;
        if (b == 'Uncategorised') return -1;
        return a.compareTo(b);
      });
    var pending = {..._catFilter};
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
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton(
                              onPressed: () {
                                setModalState(() {
                                  if (pending.length == cats.length) {
                                    pending = {};
                                  } else {
                                    pending = cats.toSet();
                                  }
                                });
                              },
                              child: Text(
                                pending.length == cats.length
                                    ? 'Deselect all'
                                    : 'Select all',
                              ),
                            ),
                            if (pending.isNotEmpty)
                              TextButton(
                                onPressed: () =>
                                    setModalState(() => pending = {}),
                                child: const Text('Clear'),
                              ),
                          ],
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
                          setState(() => _catFilter = pending);
                          _subscribe();
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

  Widget _body(BuildContext context) {
    final monthly = _buildMonthlyList();
    final categories = _buildCategoryList();
    final weekly = _buildWeeklyList();
    final merchants = _buildMerchantList();

    final values = _monthly.values.toList();
    final avgIncome = values.isEmpty
        ? 0.0
        : values.fold(0.0, (s, v) => s + v.$1) / values.length;
    final avgExpense = values.isEmpty
        ? 0.0
        : values.fold(0.0, (s, v) => s + v.$2) / values.length;

    if (monthly.isEmpty &&
        categories.isEmpty &&
        weekly.isEmpty &&
        merchants.isEmpty) {
      return EmptyState(
        icon: Icons.bar_chart_outlined,
        title: 'Nothing to show yet',
        message:
            'Once you have some transaction history, your spending trends will appear here.',
        actionLabel: 'Refresh',
        actionIcon: Icons.refresh_rounded,
        onAction: () => widget.state.load(force: true),
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        _rangeSelector(context),
        const SizedBox(height: 16),
        _summaryRow(context, avgIncome, avgExpense),
        if (monthly.isNotEmpty) ...[
          const SectionHeader('Income vs spending'),
          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 16, 12),
              child: Column(
                children: [
                  SizedBox(
                    height: 180,
                    child: _cashFlowChart(context, monthly),
                  ),
                  const SizedBox(height: 12),
                  _legendRow(context, [
                    (context.fern.green, 'Income'),
                    (context.fern.clay, 'Spending'),
                  ]),
                ],
              ),
            ),
          ),
        ],
        if (weekly.isNotEmpty) ...[
          const SectionHeader('Spending trend'),
          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 16, 16),
              child: SizedBox(height: 160, child: _trendChart(context, weekly)),
            ),
          ),
        ],
        if (categories.isNotEmpty) ...[
          SectionHeader(
            'Spending by category',
            trailing: IconButton(
              icon: Icon(
                Icons.settings_outlined,
                size: 18,
                color: context.fern.slate,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
                final (start, end) = _rangeBounds();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CategorizeSpendingScreen(
                      state: widget.state,
                      start: start,
                      end: end,
                      catFilter: _catFilter.isNotEmpty ? _catFilter : null,
                    ),
                  ),
                );
              },
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(
                    height: 190,
                    child: _categoryChart(context, categories),
                  ),
                  const SizedBox(height: 16),
                  _categoryLegend(context, categories),
                ],
              ),
            ),
          ),
        ],
        if (merchants.isNotEmpty) ...[
          const SectionHeader('Top merchants'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _merchantBars(context, merchants),
            ),
          ),
        ],
      ],
    );
  }

  Widget _summaryRow(
    BuildContext context,
    double avgIncome,
    double avgExpense,
  ) {
    final fern = context.fern;
    return Row(
      children: [
        Expanded(
          child: _statTile(
            context,
            'Avg monthly income',
            avgIncome,
            fern.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statTile(
            context,
            'Avg monthly spending',
            avgExpense,
            fern.clay,
          ),
        ),
      ],
    );
  }

  Widget _statTile(
    BuildContext context,
    String label,
    double value,
    Color color,
  ) {
    final fern = context.fern;
    final masked = widget.state.settings.hideBalances;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: fern.slate, fontSize: 12)),
            const SizedBox(height: 6),
            Text(
              masked ? '••••' : money(value),
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _legendRow(BuildContext context, List<(Color, String)> items) {
    return Wrap(
      spacing: 16,
      runSpacing: 6,
      children: [
        for (final (color, label) in items)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(fontSize: 12.5, color: context.fern.slate),
              ),
            ],
          ),
      ],
    );
  }

  Widget _cashFlowChart(BuildContext context, List<MonthTotal> months) {
    final fern = context.fern;
    final maxY = months
        .expand((m) => [m.income, m.expense])
        .fold<double>(0, (a, b) => b > a ? b : a);
    return BarChart(
      duration: Duration.zero,
      BarChartData(
        maxY: maxY == 0 ? 1 : maxY * 1.2,
        alignment: BarChartAlignment.spaceAround,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (group) => Theme.of(context).colorScheme.primary,
            fitInsideVertically: true,
            fitInsideHorizontally: true,
            getTooltipItem: (group, groupIndex, rod, rodIndex) =>
                BarTooltipItem(
                  money(rod.toY),
                  TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
          ),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final i = value.toInt();
                if (i < 0 || i >= months.length) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    months[i].label,
                    style: TextStyle(fontSize: 11, color: fern.slate),
                  ),
                );
              },
            ),
          ),
        ),
        barGroups: [
          for (var i = 0; i < months.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: months[i].income,
                  color: fern.green,
                  width: 10,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(4),
                  ),
                ),
                BarChartRodData(
                  toY: months[i].expense,
                  color: fern.clay,
                  width: 10,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(4),
                  ),
                ),
              ],
              barsSpace: 4,
            ),
        ],
      ),
    );
  }

  Widget _trendChart(BuildContext context, List<WeekTotal> weeks) {
    final fern = context.fern;
    if (weeks.isEmpty) {
      return Center(
        child: Text(
          'No spending in this period',
          style: TextStyle(color: fern.slate),
        ),
      );
    }
    final maxY = weeks
        .map((w) => w.total)
        .fold<double>(0, (a, b) => b > a ? b : a);
    return LineChart(
      duration: Duration.zero,
      LineChartData(
        minY: 0,
        maxY: maxY == 0 ? 1 : maxY * 1.2,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: maxY == 0 ? 1 : maxY / 3,
          getDrawingHorizontalLine: (_) =>
              FlLine(color: fern.mist, strokeWidth: 1),
        ),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            fitInsideVertically: true,
            fitInsideHorizontally: true,
            getTooltipColor: (group) => Theme.of(context).colorScheme.primary,
            getTooltipItems: (spots) => spots
                .map(
                  (s) => LineTooltipItem(
                    money(s.y),
                    TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: (weeks.length / 4).clamp(1, weeks.length).toDouble(),
              getTitlesWidget: (value, meta) {
                final i = value.toInt();
                if (i < 0 || i >= weeks.length) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    weeks[i].label,
                    style: TextStyle(fontSize: 11, color: fern.slate),
                  ),
                );
              },
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: [
              for (var i = 0; i < weeks.length; i++)
                FlSpot(i.toDouble(), weeks[i].total),
            ],
            isCurved: true,
            curveSmoothness: 0.2,
            color: fern.green,
            barWidth: 2,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: fern.green.withValues(alpha: 0.12),
            ),
          ),
        ],
      ),
    );
  }

  List<_CatEntry> _buildCategoryEntries(List<CategoryTotal> cats) {
    final colors = categoryColors(Theme.of(context).colorScheme);
    final top = cats.take(categoryColorCount).toList();
    final rest = cats.skip(categoryColorCount);
    final otherTotal = rest.fold<double>(0, (s, c) => s + c.amount);
    final result = [
      for (var i = 0; i < top.length; i++)
        _CatEntry(name: top[i].name, amount: top[i].amount, color: colors[i]),
    ];
    if (otherTotal > 0) {
      result.add(
        _CatEntry(name: 'Other', amount: otherTotal, color: context.fern.slate),
      );
    }
    return result;
  }

  Widget _categoryChart(BuildContext context, List<CategoryTotal> cats) {
    final entries = _buildCategoryEntries(cats);
    final total = entries.fold<double>(0, (s, c) => s + c.amount);
    return PieChart(
      duration: Duration.zero,
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 48,
        sections: [
          for (var i = 0; i < entries.length; i++)
            PieChartSectionData(
              value: entries[i].amount,
              color: entries[i].color,
              radius: 46,
              showTitle: total > 0 && (entries[i].amount / total) >= 0.08,
              title: total == 0
                  ? ''
                  : '${(entries[i].amount / total * 100).round()}%',
              titleStyle: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: onCategoryColor(entries[i].color),
              ),
            ),
        ],
      ),
    );
  }

  Widget _categoryLegend(BuildContext context, List<CategoryTotal> cats) {
    final fern = context.fern;
    final masked = widget.state.settings.hideBalances;
    final entries = _buildCategoryEntries(cats);
    return Column(
      children: [
        for (final c in entries)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: c.color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    c.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  masked ? '••••' : money(c.amount),
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: fern.slate,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _merchantBars(BuildContext context, List<MerchantTotal> merchants) {
    final fern = context.fern;
    final masked = widget.state.settings.hideBalances;
    final max = merchants.first.amount;
    return Column(
      children: [
        for (final m in merchants)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                SizedBox(
                  width: 110,
                  child: Text(
                    m.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: max == 0 ? 0 : m.amount / max,
                      minHeight: 10,
                      backgroundColor: fern.mist,
                      valueColor: AlwaysStoppedAnimation(fern.clay),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 72,
                  child: Text(
                    masked ? '••••' : money(m.amount),
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _CatEntry {
  final String name;
  final double amount;
  final Color color;
  const _CatEntry({
    required this.name,
    required this.amount,
    required this.color,
  });
}
