import 'package:flutter/material.dart';

/// Shared category accent palette, also used for the Stats pie chart.
const kCategoryColors = [
  Color(0xFF2A78D6),
  Color(0xFFEB6834),
  Color(0xFF1BAF7A),
  Color(0xFFEDA100),
  Color(0xFFE87BA4),
  Color(0xFF008300),
  Color(0xFF4A3AA7),
];

/// Deterministic color for a category/group name, stable across the app.
Color colorForCategory(String name) {
  if (name.isEmpty) return kCategoryColors[0];
  return kCategoryColors[name.hashCode.abs() % kCategoryColors.length];
}
