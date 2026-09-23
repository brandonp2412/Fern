import 'package:fern/theme.dart';
import 'package:fern/widgets/txn_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fixtures.dart';

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
  testWidgets('unselected selection ring has 3:1 non-text contrast', (
    tester,
  ) async {
    final tx = mcdonaldsBurger();

    for (final seed in FernSeed.values) {
      for (final brightness in Brightness.values) {
        await tester.pumpWidget(
          MaterialApp(
            theme: Fern.buildTheme(brightness: brightness, seed: seed.color),
            home: Scaffold(
              body: TxnTile(tx: tx, selectionMode: true, selected: false),
            ),
          ),
        );

        final selectionCircle = tester.widget<Container>(
          find.byKey(const ValueKey('txn-selection-indicator')),
        );
        final decoration = selectionCircle.decoration! as BoxDecoration;
        final border = decoration.border! as Border;

        expect(
          _contrast(border.top.color, decoration.color!),
          greaterThanOrEqualTo(3),
          reason: '${seed.name} ${brightness.name} selection ring',
        );
      }
    }
  });
}
