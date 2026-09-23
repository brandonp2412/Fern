import 'package:fern/theme.dart';
import 'package:fern/widgets/common.dart';
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
  testWidgets('StatusChip text stays AA-readable across every theme palette', (
    tester,
  ) async {
    for (final seed in FernSeed.values) {
      for (final brightness in Brightness.values) {
        await tester.pumpWidget(
          MaterialApp(
            theme: Fern.buildTheme(brightness: brightness, seed: seed.color),
            home: Scaffold(
              body: Builder(
                builder: (context) =>
                    Center(child: StatusChip('Inactive', context.fern.clay)),
              ),
            ),
          ),
        );

        final text = tester.widget<Text>(find.text('Inactive'));
        final chip = tester
            .widgetList<Container>(find.byType(Container))
            .firstWhere((container) {
              final decoration = container.decoration;
              return decoration is BoxDecoration &&
                  decoration.color != null &&
                  decoration.borderRadius == BorderRadius.circular(20);
            });
        final background = (chip.decoration! as BoxDecoration).color!;

        expect(
          background.a,
          1,
          reason: '${seed.name} ${brightness.name} chip is opaque',
        );
        expect(
          _contrast(text.style!.color!, background),
          greaterThanOrEqualTo(4.5),
          reason: '${seed.name} ${brightness.name} status chip',
        );
      }
    }
  });

  testWidgets('EmptyState stays overflow-free when height collapses', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: Fern.buildTheme(brightness: Brightness.light, seed: Fern.green),
        home: const Scaffold(
          body: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 500,
              height: 5,
              child: EmptyState(
                icon: Icons.receipt_long_outlined,
                title: 'No transactions',
                message: 'Try another filter.',
              ),
            ),
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('No transactions'), findsOneWidget);
  });
}
