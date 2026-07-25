import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../state/app_state.dart';
import '../theme.dart';
import '../utils/format.dart';
import '../widgets/common.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stats'),
        actions: [if (widget.state.refreshing) const AppBarSpinner()],
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: widget.state,
          builder: (context, _) {
            final state = widget.state;
            final txns = state.transactions;
            final cold = state.accounts.isEmpty && txns.isEmpty;

            if (cold) {
              if (state.error != null) {
                return ErrorState(error: state.error!, onRetry: () => state.load());
              }
              return const Center(child: CircularProgressIndicator());
            }
            if (txns.isEmpty) {
              return const EmptyState(
                icon: Icons.bar_chart_outlined,
                title: 'Nothing to show yet',
                message: 'Once you have some transaction history, your spending trends will appear here.',
              );
            }
            return RefreshIndicator(
              onRefresh: () => state.load(force: true),
              child: _body(context, state),
            );
          },
        ),
      ),
    );
  }

  Widget _body(BuildContext context, AppState state) {
    final monthly = state.aggMonthly;
    final categories = state.aggCategories;
    final weekly = state.aggWeekly;
    final merchants = state.aggMerchants;

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
                      SizedBox(height: 190, child: _categoryChart(context, categories)),
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

  Widget _trendChart(BuildContext context, List<WeekTotal> weeks) {
    final fern = context.fern;
    if (weeks.isEmpty) {
      return Center(child: Text('No spending in this period', style: TextStyle(color: fern.slate)));
    }
    final maxY = weeks.map((w) => w.total).fold<double>(0, (a, b) => b > a ? b : a);
    return LineChart(
      duration: Duration.zero,
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

  List<_CatEntry> _buildCategoryEntries(List<CategoryTotal> cats) {
    final top = cats.take(_kCategoryColors.length).toList();
    final rest = cats.skip(_kCategoryColors.length);
    final otherTotal = rest.fold<double>(0, (s, c) => s + c.amount);
    final result = [
      for (var i = 0; i < top.length; i++)
        _CatEntry(name: top[i].name, amount: top[i].amount, color: _kCategoryColors[i]),
    ];
    if (otherTotal > 0) {
      result.add(_CatEntry(name: 'Other', amount: otherTotal, color: context.fern.slate));
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
              title: total == 0 ? '' : '${(entries[i].amount / total * 100).round()}%',
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
}

class _CatEntry {
  final String name;
  final double amount;
  final Color color;
  const _CatEntry({required this.name, required this.amount, required this.color});
}
