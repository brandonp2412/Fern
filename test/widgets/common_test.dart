import 'package:fern/theme.dart';
import 'package:fern/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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
