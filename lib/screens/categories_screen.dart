import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/akahu_api.dart';
import '../theme.dart';
import '../widgets/common.dart';

class CategoriesScreen extends StatefulWidget {
  final AkahuApi api;

  const CategoriesScreen({super.key, required this.api});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<NzfccCategory>? _categories;
  String? _error;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final categories = await widget.api.getCategories();
      if (mounted) setState(() => _categories = categories);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: TextField(
              onChanged: (v) => setState(() => _query = v.trim().toLowerCase()),
              decoration: const InputDecoration(
                hintText: 'Search categories…',
                prefixIcon: Icon(Icons.search, size: 20),
              ),
            ),
          ),
        ),
      ),
      body: _categories == null && _error == null
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? ErrorState(error: _error!, onRetry: _load)
              : _list(),
    );
  }

  Widget _list() {
    final filtered = _categories!
        .where((c) =>
            _query.isEmpty ||
            c.name.toLowerCase().contains(_query) ||
            (c.groupName ?? '').toLowerCase().contains(_query))
        .toList();
    final byGroup = <String, List<NzfccCategory>>{};
    for (final c in filtered) {
      byGroup.putIfAbsent(c.groupName ?? 'Other', () => []).add(c);
    }
    final groups = byGroup.keys.toList()..sort();
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: groups.length,
      itemBuilder: (context, i) {
        final group = groups[i];
        final cats = byGroup[group]!..sort((a, b) => a.name.compareTo(b.name));
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(group),
            Card(
              child: Column(
                children: [
                  for (var j = 0; j < cats.length; j++) ...[
                    if (j > 0) const Divider(indent: 52, height: 1),
                    ListTile(
                      dense: true,
                      leading: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Fern.mist,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.label_outline,
                            size: 16, color: Fern.green),
                      ),
                      title: Text(cats[j].name,
                          style: const TextStyle(
                              fontSize: 13.5, fontWeight: FontWeight.w600)),
                      subtitle: Text(cats[j].id,
                          style: const TextStyle(
                              fontSize: 10.5, color: Fern.slate)),
                    ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
