import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../utils/format.dart';
import '../widgets/common.dart';

/// Categorical palette for the category breakdown chart, ordered for
/// colorblind-safe adjacency (blue, orange, aqua, yellow, magenta, green,
/// violet, red). "Other" falls back to a neutral grey.
const _kCategoryColors = [
  Color(0xFF2A78D6),
  Color(0xFFEB6834),
  Color(0xFF1BAF7A),
  Color(0xFFEDA100),
  Color(0xFFE87BA4),
  Color(0xFF008300),
  Color(0xFF4A3AA7),
];

class StatsScreen extends StatefulWidget {
  final AppState state;

  const StatsScreen({super.key, required this.state});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  static const _rangeDays = 182;
  static const _monthCount = 6;
  static const _maxPages = 5;

  List<Transaction>? _txns;
  bool _refreshing = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    widget.state.addListener(_onState);
    _load();
  }

  @override
  void dispose() {
    widget.state.removeListener(_onState);
    super.dispose();
  }

  void _onState() {
    if (mounted) setState(() {});
  }

  String get _start => isoDay(DateTime.now().subtract(const Duration(days: _rangeDays)));

  Future<void> _load() async {
    if (_txns == null) {
      final cached = await widget.state.loadCachedTransactions(limit: 1000);
      if (mounted && _txns == null) {
        setState(() => _txns = cached);
      }
    }
    if (mounted) setState(() => _refreshing = true);
    try {
      final all = <Transaction>[];
      String? cursor;
      for (var i = 0; i < _maxPages; i++) {
        final page = await widget.state.api.getTransactions(start: _start, cursor: cursor);
        all.addAll(page.items);
        cursor = page.nextCursor;
        if (cursor == null) break;
      }
      if (mounted) {
        setState(() {
          _txns = all;
          _refreshing = false;
          _error = null;
        });
        widget.state.cacheTransactions(all);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _refreshing = false;
          if (_txns == null) _error = e.toString();
        });
      }
    }
  }

  Future<void> _refresh() => _load();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stats'),
        actions: [if (_refreshing) const AppBarSpinner()],
      ),
      body: SafeArea(
        child: _txns == null
            ? _error != null
                ? ErrorState(error: _error!, onRetry: _load)
                : const Center(child: CircularProgressIndicator())
            : _txns!.isEmpty
                ? const EmptyState(
                    icon: Icons.bar_chart_outlined,
                    title: 'Nothing to show yet',
                    message: 'Once you have some transaction history, your spending trends will appear here.',
                  )
                : RefreshIndicator(
                    onRefresh: _refresh,
                    child: _body(context, _txns!),
                  ),
      ),
    );
  }

  Widget _body(BuildContext context, List<Transaction> txns) {
    final months = _lastMonths(_monthCount);
    final monthly = _monthlyTotals(txns, months);
    final categories = _categoryTotals(txns);
    final weekly = _weeklyTrend(txns, _rangeDays);
    final merchants = _topMerchants(txns, 5);

    final avgIncome = monthly.isEmpty
        ? 0.0
        : monthly.map((m) => m.income).reduce((a, b) => a + b) / monthly.length;
    final avgExpense = monthly.isEmpty
        ? 0.0
        : monthly.map((m) => m.expense).reduce((a, b) => a + b) / monthly.length;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        _summaryRow(context, avgIncome, avgExpense),
        const SectionHeader('Income vs spending'),
        Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 16, 12),
            child: Column(
              children: [
                SizedBox(height: 180, child: _cashFlowChart(context, monthly)),
                const SizedBox(height: 12),
                _legendRow(context, [
                  (context.fern.green, 'Income'),
                  (context.fern.clay, 'Spending'),
                ]),
              ],
            ),
          ),
        ),
        const SectionHeader('Spending trend'),
        Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 16, 16),
            child: SizedBox(height: 160, child: _trendChart(context, weekly)),
          ),
        ),
        const SectionHeader('Spending by category'),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: categories.isEmpty
                ? Text('No spending in this period', style: TextStyle(color: context.fern.slate))
                : Column(
                    children: [
                      SizedBox(height: 190, child: _categoryChart(categories)),
                      const SizedBox(height: 16),
                      _categoryLegend(context, categories),
                    ],
                  ),
          ),
        ),
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

  Widget _summaryRow(BuildContext context, double avgIncome, double avgExpense) {
    final fern = context.fern;
    return Row(
      children: [
        Expanded(
          child: _statTile(context, 'Avg monthly income', avgIncome, fern.green),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statTile(context, 'Avg monthly spending', avgExpense, fern.clay),
        ),
      ],
    );
  }

  Widget _statTile(BuildContext context, String label, double value, Color color) {
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
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: color),
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
              Text(label, style: TextStyle(fontSize: 12.5, color: context.fern.slate)),
            ],
          ),
      ],
    );
  }

  Widget _cashFlowChart(BuildContext context, List<_MonthTotal> months) {
    final fern = context.fern;
    final maxY = months
        .expand((m) => [m.income, m.expense])
        .fold<double>(0, (a, b) => b > a ? b : a);
    return BarChart(
      BarChartData(
        maxY: maxY == 0 ? 1 : maxY * 1.2,
        alignment: BarChartAlignment.spaceAround,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) => BarTooltipItem(
              money(rod.toY),
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
            ),
          ),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                ),
                BarChartRodData(
                  toY: months[i].expense,
                  color: fern.clay,
                  width: 10,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                ),
              ],
              barsSpace: 4,
            ),
        ],
      ),
    );
  }

  Widget _trendChart(BuildContext context, List<_WeekTotal> weeks) {
    final fern = context.fern;
    if (weeks.isEmpty) {
      return Center(child: Text('No spending in this period', style: TextStyle(color: fern.slate)));
    }
    final maxY = weeks.map((w) => w.total).fold<double>(0, (a, b) => b > a ? b : a);
    return LineChart(
      LineChartData(
        minY: 0,
        maxY: maxY == 0 ? 1 : maxY * 1.2,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: maxY == 0 ? 1 : maxY / 3,
          getDrawingHorizontalLine: (_) => FlLine(color: fern.mist, strokeWidth: 1),
        ),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (spots) => spots
                .map((s) => LineTooltipItem(
                      money(s.y),
                      const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
                    ))
                .toList(),
          ),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: (weeks.length / 4).clamp(1, weeks.length).toDouble(),
              getTitlesWidget: (value, meta) {
                final i = value.toInt();
                if (i < 0 || i >= weeks.length) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(weeks[i].label, style: TextStyle(fontSize: 11, color: fern.slate)),
                );
              },
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: [for (var i = 0; i < weeks.length; i++) FlSpot(i.toDouble(), weeks[i].total)],
            isCurved: true,
            curveSmoothness: 0.2,
            color: fern.green,
            barWidth: 2,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(show: true, color: fern.green.withValues(alpha: 0.12)),
          ),
        ],
      ),
    );
  }

  Widget _categoryChart(List<_CategoryTotal> categories) {
    final total = categories.fold<double>(0, (s, c) => s + c.amount);
    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 48,
        sections: [
          for (var i = 0; i < categories.length; i++)
            PieChartSectionData(
              value: categories[i].amount,
              color: categories[i].color,
              radius: 46,
              showTitle: total > 0 && (categories[i].amount / total) >= 0.08,
              title: total == 0 ? '' : '${(categories[i].amount / total * 100).round()}%',
              titleStyle: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }

  Widget _categoryLegend(BuildContext context, List<_CategoryTotal> categories) {
    final fern = context.fern;
    final masked = widget.state.settings.hideBalances;
    return Column(
      children: [
        for (final c in categories)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(color: c.color, shape: BoxShape.circle),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    c.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  masked ? '••••' : money(c.amount),
                  style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: fern.slate),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _merchantBars(BuildContext context, List<_MerchantTotal> merchants) {
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
                    style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
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
                    style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  List<_MonthKey> _lastMonths(int count) {
    final now = DateTime.now();
    return [
      for (var i = count - 1; i >= 0; i--)
        _MonthKey.from(DateTime(now.year, now.month - i, 1)),
    ];
  }

  List<_MonthTotal> _monthlyTotals(List<Transaction> txns, List<_MonthKey> months) {
    final byKey = {for (final m in months) m.key: (income: 0.0, expense: 0.0)};
    for (final tx in txns) {
      final d = parseDate(tx.date);
      if (d == null) continue;
      final key = _MonthKey.from(DateTime(d.year, d.month, 1)).key;
      final cur = byKey[key];
      if (cur == null) continue;
      if (tx.amount >= 0) {
        byKey[key] = (income: cur.income + tx.amount, expense: cur.expense);
      } else {
        byKey[key] = (income: cur.income, expense: cur.expense + tx.amount.abs());
      }
    }
    return [
      for (final m in months)
        _MonthTotal(label: m.label, income: byKey[m.key]!.income, expense: byKey[m.key]!.expense),
    ];
  }

  List<_CategoryTotal> _categoryTotals(List<Transaction> txns) {
    final totals = <String, double>{};
    for (final tx in txns) {
      if (tx.amount >= 0) continue;
      final group = widget.state.categoryGroupFor(tx) ?? 'Uncategorised';
      totals[group] = (totals[group] ?? 0) + tx.amount.abs().toDouble();
    }
    final entries = totals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final top = entries.take(_kCategoryColors.length).toList();
    final rest = entries.skip(_kCategoryColors.length);
    final otherTotal = rest.fold<double>(0, (s, e) => s + e.value);
    final result = [
      for (var i = 0; i < top.length; i++)
        _CategoryTotal(name: top[i].key, amount: top[i].value, color: _kCategoryColors[i]),
    ];
    if (otherTotal > 0) {
      result.add(_CategoryTotal(name: 'Other', amount: otherTotal, color: context.fern.slate));
    }
    return result;
  }

  List<_WeekTotal> _weeklyTrend(List<Transaction> txns, int rangeDays) {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day).subtract(Duration(days: rangeDays));
    final byWeek = <DateTime, double>{};
    for (final tx in txns) {
      if (tx.amount >= 0) continue;
      final d = parseDate(tx.date);
      if (d == null) continue;
      final day = DateTime(d.year, d.month, d.day);
      if (day.isBefore(start)) continue;
      final weekStart = day.subtract(Duration(days: day.weekday - 1));
      byWeek[weekStart] = (byWeek[weekStart] ?? 0) + tx.amount.abs().toDouble();
    }
    final keys = byWeek.keys.toList()..sort();
    return [
      for (final k in keys) _WeekTotal(label: DateFormat('d MMM').format(k), total: byWeek[k]!),
    ];
  }

  List<_MerchantTotal> _topMerchants(List<Transaction> txns, int count) {
    final totals = <String, double>{};
    for (final tx in txns) {
      if (tx.amount >= 0) continue;
      final name = tx.merchant?.name ?? tx.description;
      if (name.isEmpty) continue;
      totals[name] = (totals[name] ?? 0) + tx.amount.abs().toDouble();
    }
    final entries = totals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return [
      for (final e in entries.take(count)) _MerchantTotal(name: e.key, amount: e.value),
    ];
  }
}

class _MonthKey {
  final String key;
  final String label;

  _MonthKey(this.key, this.label);

  factory _MonthKey.from(DateTime d) {
    final key = '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}';
    return _MonthKey(key, DateFormat('MMM').format(d));
  }
}

class _MonthTotal {
  final String label;
  final double income;
  final double expense;

  _MonthTotal({required this.label, required this.income, required this.expense});
}

class _CategoryTotal {
  final String name;
  final double amount;
  final Color color;

  _CategoryTotal({required this.name, required this.amount, required this.color});
}

class _WeekTotal {
  final String label;
  final double total;

  _WeekTotal({required this.label, required this.total});
}

class _MerchantTotal {
  final String name;
  final double amount;

  _MerchantTotal({required this.name, required this.amount});
}
