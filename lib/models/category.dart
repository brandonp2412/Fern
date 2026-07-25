import 'transaction.dart';

class NzfccCategory {
  final String id;
  final String name;
  final Map<String, CategoryGroup> groups;

  NzfccCategory({required this.id, required this.name, this.groups = const {}});

  String? get groupName => groups['personal_finance']?.name ??
      (groups.isNotEmpty ? groups.values.first.name : null);

  factory NzfccCategory.fromJson(Map<String, dynamic> json) {
    final rawGroups = json['groups'];
    final groups = <String, CategoryGroup>{};
    if (rawGroups is Map<String, dynamic>) {
      for (final e in rawGroups.entries) {
        if (e.value is Map<String, dynamic>) {
          groups[e.key] = CategoryGroup.fromJson(e.value);
        }
      }
    }
    return NzfccCategory(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      groups: groups,
    );
  }
}
