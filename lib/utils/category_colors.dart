import 'package:flutter/material.dart';

const categoryColorCount = 7;

/// Category accents derived from the active theme rather than a fixed rainbow.
///
/// The Material seed generates primary, secondary, tertiary and error families;
/// the intermediate accents keep charts distinguishable while following the
/// selected seed and brightness.
List<Color> categoryColors(ColorScheme scheme) => [
  scheme.primary,
  scheme.tertiary,
  scheme.secondary,
  Color.lerp(scheme.primary, scheme.tertiary, 0.5)!,
  Color.lerp(scheme.tertiary, scheme.error, 0.35)!,
  Color.lerp(scheme.secondary, scheme.primary, 0.5)!,
  scheme.error,
];

/// Deterministic color for a category/group name, stable across the app.
Color colorForCategory(String name, ColorScheme scheme) {
  final colors = categoryColors(scheme);
  if (name.isEmpty) return colors.first;
  return colors[name.hashCode.abs() % colors.length];
}

Color onCategoryColor(Color color) =>
    ThemeData.estimateBrightnessForColor(color) == Brightness.dark
    ? Colors.white
    : Colors.black;
