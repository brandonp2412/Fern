import 'package:flutter/material.dart';

import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';

class CategoryRulesScreen extends StatefulWidget {
  final AppState state;

  const CategoryRulesScreen({super.key, required this.state});

  @override
  State<CategoryRulesScreen> createState() => _CategoryRulesScreenState();
}

class _CategoryRulesScreenState extends State<CategoryRulesScreen> {
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

  @override
  Widget build(BuildContext context) {
    final fern = context.fern;
    final rules = widget.state.categoryRules;
    return Scaffold(
      appBar: AppBar(title: const Text('Auto-categorize rules')),
      body: rules.isEmpty
          ? const EmptyState(
              icon: Icons.rule_outlined,
              title: 'No rules yet',
              message:
                  'Pick "Auto-categorize future transactions" when '
                  'categorizing a transaction to create one.',
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: rules.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final rule = rules[i];
                return Card(
                  child: ListTile(
                    title: Text(
                      rule.matchText,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      '→ ${rule.categoryName}',
                      style: TextStyle(fontSize: 12, color: fern.slate),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_outline, color: fern.clay),
                      onPressed: () => widget.state.deleteCategoryRule(rule.id),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
