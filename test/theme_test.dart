import 'package:fern/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

double _contrast(Color foreground, Color background) {
  final foregroundLuminance = foreground.computeLuminance();
  final backgroundLuminance = background.computeLuminance();
  final lighter = foregroundLuminance > backgroundLuminance
      ? foregroundLuminance
      : backgroundLuminance;
  final darker = foregroundLuminance > backgroundLuminance
      ? backgroundLuminance
      : foregroundLuminance;
  return (lighter + 0.05) / (darker + 0.05);
}

void main() {
  test('snackbar text and actions keep AA contrast across every palette', () {
    for (final seed in FernSeed.values) {
      for (final brightness in Brightness.values) {
        final theme = Fern.buildTheme(brightness: brightness, seed: seed.color);
        final snackBar = theme.snackBarTheme;
        final background = snackBar.backgroundColor!;
        final content = snackBar.contentTextStyle!.color!;
        final action = snackBar.actionTextColor!;

        expect(
          _contrast(content, background),
          greaterThanOrEqualTo(4.5),
          reason: '${seed.name} ${brightness.name} snackbar content',
        );
        expect(
          _contrast(action, background),
          greaterThanOrEqualTo(4.5),
          reason: '${seed.name} ${brightness.name} snackbar action',
        );
      }
    }
  });
}
