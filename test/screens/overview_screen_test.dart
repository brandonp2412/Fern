import 'package:fern/screens/overview_screen.dart';
import 'package:fern/state/app_state.dart';
import 'package:fern/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fixtures.dart';

Future<void> _pump(
  WidgetTester tester,
  AppState state, {
  Brightness brightness = Brightness.light,
  Color seed = Fern.green,
}) async {
  tester.view.physicalSize = const Size(800, 2000);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(() {
    tester.view.physicalSize = const Size(800, 600);
    tester.view.devicePixelRatio = 1.0;
  });
  await tester.pumpWidget(
    MaterialApp(
      theme: Fern.buildTheme(brightness: brightness, seed: seed),
      home: OverviewScreen(state: state),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
}

Color _composite(Color foreground, Color background) {
  final alpha = foreground.a;
  return Color.from(
    alpha: 1,
    red: foreground.r * alpha + background.r * (1 - alpha),
    green: foreground.g * alpha + background.g * (1 - alpha),
    blue: foreground.b * alpha + background.b * (1 - alpha),
  );
}

double _contrast(Color foreground, Color background) {
  final actual = foreground.a < 1
      ? _composite(foreground, background)
      : foreground;
  final foregroundLuminance = actual.computeLuminance();
  final backgroundLuminance = background.computeLuminance();
  final lighter = foregroundLuminance > backgroundLuminance
      ? foregroundLuminance
      : backgroundLuminance;
  final darker = foregroundLuminance > backgroundLuminance
      ? backgroundLuminance
      : foregroundLuminance;
  return (lighter + 0.05) / (darker + 0.05);
}

double _worstGradientContrast(Color foreground, List<Color> colors) {
  var worst = double.infinity;
  for (var segment = 0; segment < colors.length - 1; segment++) {
    for (var step = 0; step <= 100; step++) {
      final background = Color.lerp(
        colors[segment],
        colors[segment + 1],
        step / 100,
      )!;
      final ratio = _contrast(foreground, background);
      if (ratio < worst) worst = ratio;
    }
  }
  return worst;
}

void main() {
  setUpAll(mockNetworkImages);

  testWidgets(
    'shows the real net position, account names and a recent McDonald\'s tile',
    (tester) async {
      final state = await seededState(
        tester: tester,
        accounts: [
          anzEveryday(balance: 2450.32),
          asbStreamline(balance: 8120.11),
        ],
        transactions: [mcdonaldsBurger()],
      );
      await _pump(tester, state);

      expect(find.text('ANZ Everyday'), findsOneWidget);
      expect(find.text('ASB Streamline'), findsOneWidget);
      expect(find.text("McDonald's"), findsOneWidget);
      expect(find.text('2 accounts'), findsOneWidget);
    },
  );

  testWidgets(
    'tapping the ASB Streamline account card shows its transaction history',
    (tester) async {
      final state = await seededState(
        tester: tester,
        accounts: [anzEveryday(), asbStreamline()],
        transactions: [netflixSubscription()],
      );
      await _pump(tester, state);

      await tester.tap(find.text('ASB Streamline'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('ASB Streamline'), findsOneWidget);
      expect(find.text('Transactions'), findsOneWidget);
    },
  );

  testWidgets('opening Spending this month shows categorization controls', (
    tester,
  ) async {
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      transactions: [mcdonaldsBurger()],
    );
    await _pump(tester, state);

    expect(find.text('Spending this month'), findsOneWidget);
    await tester.tap(find.byTooltip('Categorize spending'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Categorize spending'), findsOneWidget);
  });

  testWidgets(
    'a transaction just after local midnight on the 1st still counts as spending this month',
    (tester) async {
      final now = DateTime.now();
      final localFirstOfMonth = DateTime(now.year, now.month, 1, 0, 30);
      final state = await seededState(
        tester: tester,
        accounts: [anzEveryday()],
        transactions: [
          mcdonaldsBurger(date: localFirstOfMonth.toUtc().toIso8601String()),
        ],
      );
      await _pump(tester, state);

      expect(find.text('No spending this month'), findsNothing);
      expect(find.text('Lifestyle'), findsOneWidget);
    },
  );

  testWidgets('the spend card breaks down real category groups', (
    tester,
  ) async {
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday()],
      transactions: [
        mcdonaldsBurger(date: DateTime.now().toUtc().toIso8601String()),
        bpFuel(date: DateTime.now().toUtc().toIso8601String()),
      ],
    );
    await _pump(tester, state);

    expect(find.text('Lifestyle'), findsOneWidget);
    expect(find.text('Transport'), findsOneWidget);
  });

  testWidgets('net position stays readable on the dark gradient', (
    tester,
  ) async {
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday(balance: 2450.32)],
    );
    await _pump(tester, state, brightness: Brightness.dark);

    final label = tester.widget<Text>(find.text('Net position'));
    final amount = tester
        .widgetList<Text>(find.textContaining(r'$2,450'))
        .firstWhere((text) => text.style?.fontSize == 36);
    final context = tester.element(find.text('Net position'));
    final palette = Theme.of(context).extension<FernPalette>()!;

    expect(label.style?.color, palette.onDeep);
    expect(amount.style?.color, palette.onDeep);
  });

  testWidgets('overview debt label keeps AA contrast across every palette', (
    tester,
  ) async {
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday(balance: 2450.32), amexCreditCard(owing: 512.40)],
    );

    for (final seed in FernSeed.values) {
      for (final brightness in Brightness.values) {
        await _pump(tester, state, brightness: brightness, seed: seed.color);

        final debt = tester.widget<Text>(find.text('Debt'));
        final hero = tester
            .widgetList<Container>(find.byType(Container))
            .firstWhere((container) {
              final decoration = container.decoration;
              return decoration is BoxDecoration &&
                  decoration.gradient is LinearGradient &&
                  decoration.borderRadius == BorderRadius.circular(24);
            });
        final gradient =
            (hero.decoration! as BoxDecoration).gradient! as LinearGradient;

        expect(
          _worstGradientContrast(debt.style!.color!, gradient.colors),
          greaterThanOrEqualTo(4.5),
          reason: '${seed.name} ${brightness.name} debt label',
        );
      }
    }
  });

  testWidgets('hiding balances masks the net position figure', (tester) async {
    final settings = await testSettings();
    await settings.setHideBalances(true);
    final state = await seededState(
      tester: tester,
      accounts: [anzEveryday(balance: 2450.32)],
      settings: settings,
    );
    await _pump(tester, state);

    expect(find.text('••••'), findsWidgets);
    expect(find.textContaining('\$2,450'), findsNothing);
  });
}
