import 'package:flutter/material.dart';

class Fern {
  static const deep = Color(0xFF10382A);
  static const green = Color(0xFF1D5C45);
  static const moss = Color(0xFF3E7C5F);
  static const fern = Color(0xFF69A87D);
  static const sprout = Color(0xFFA8D5B0);
  static const mist = Color(0xFFE7F0E6);
  static const cream = Color(0xFFF5F7F0);
  static const ink = Color(0xFF14201A);
  static const slate = Color(0xFF5A6B60);
  static const clay = Color(0xFFC65D3B);
  static const sand = Color(0xFFEFE9DC);

  static ThemeData buildTheme({
    required Brightness brightness,
    Color seed = green,
  }) {
    final scheme = ColorScheme.fromSeed(seedColor: seed, brightness: brightness);
    final palette = FernPalette.fromScheme(scheme);
    final base = ThemeData(brightness: brightness, useMaterial3: true);
    final text = base.textTheme.apply(
      bodyColor: palette.ink,
      displayColor: palette.ink,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: palette.cream,
      textTheme: text,
      extensions: [palette],
      appBarTheme: AppBarTheme(
        backgroundColor: palette.cream,
        foregroundColor: palette.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: palette.ink,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.4,
        ),
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: scheme.outlineVariant),
        ),
        margin: EdgeInsets.zero,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: palette.mist,
        elevation: 0,
        height: 68,
        labelTextStyle: WidgetStateProperty.resolveWith((states) => TextStyle(
              fontSize: 11,
              fontWeight:
                  states.contains(WidgetState.selected) ? FontWeight.w700 : FontWeight.w500,
              color: states.contains(WidgetState.selected) ? palette.green : palette.slate,
            )),
        iconTheme: WidgetStateProperty.resolveWith((states) => IconThemeData(
              color: states.contains(WidgetState.selected) ? palette.green : palette.slate,
            )),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: palette.green,
          foregroundColor: palette.onGreen,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: palette.green,
          side: BorderSide(color: palette.green),
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: palette.green, width: 1.6),
        ),
        labelStyle: TextStyle(color: palette.slate),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: palette.mist,
        selectedColor: palette.green,
        labelStyle: TextStyle(color: palette.ink, fontSize: 13),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: palette.deep,
        contentTextStyle: TextStyle(color: palette.onGreen),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: palette.cream,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: palette.cream,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: palette.green),
    );
  }
}

/// Named seed colors offered in the settings color picker.
enum FernSeed {
  green('Fern green', Fern.green),
  moss('Moss', Fern.moss),
  ocean('Ocean blue', Color(0xFF3D6FE0)),
  violet('Violet', Color(0xFF7C5CC7)),
  clay('Clay', Fern.clay),
  teal('Teal', Color(0xFF1B8E8E)),
  blossom('Blossom', Color(0xFFD1568C));

  final String label;
  final Color color;
  const FernSeed(this.label, this.color);

  static FernSeed fromColor(Color color) =>
      FernSeed.values.firstWhere((s) => s.color.toARGB32() == color.toARGB32(),
          orElse: () => FernSeed.green);
}

/// Semantic palette derived from the active [ColorScheme], so custom widgets
/// can read theme/brightness/seed-aware colors via `context.fern` instead of
/// hardcoding the light-only [Fern] constants.
@immutable
class FernPalette extends ThemeExtension<FernPalette> {
  final Color ink;
  final Color slate;
  final Color mist;
  final Color cream;
  final Color deep;
  final Color green;
  final Color moss;
  final Color sprout;
  final Color clay;
  final Color sand;
  final Color onGreen;

  const FernPalette({
    required this.ink,
    required this.slate,
    required this.mist,
    required this.cream,
    required this.deep,
    required this.green,
    required this.moss,
    required this.sprout,
    required this.clay,
    required this.sand,
    required this.onGreen,
  });

  factory FernPalette.fromScheme(ColorScheme scheme) {
    final dark = scheme.brightness == Brightness.dark;
    return FernPalette(
      ink: scheme.onSurface,
      slate: scheme.onSurfaceVariant,
      mist: scheme.surfaceContainerHighest,
      cream: dark ? scheme.surface : const Color(0xFFF5F7F0),
      deep: Color.lerp(scheme.primary, Colors.black, dark ? 0.65 : 0.5)!,
      green: scheme.primary,
      moss: Color.lerp(scheme.primary, dark ? Colors.white : Colors.black, 0.2)!,
      sprout: dark ? Color.lerp(scheme.primary, Colors.white, 0.6)! : Color.lerp(scheme.primary, Colors.white, 0.55)!,
      clay: scheme.error,
      sand: dark ? scheme.surfaceContainerHigh : const Color(0xFFEFE9DC),
      onGreen: scheme.onPrimary,
    );
  }

  @override
  FernPalette copyWith({
    Color? ink,
    Color? slate,
    Color? mist,
    Color? cream,
    Color? deep,
    Color? green,
    Color? moss,
    Color? sprout,
    Color? clay,
    Color? sand,
    Color? onGreen,
  }) {
    return FernPalette(
      ink: ink ?? this.ink,
      slate: slate ?? this.slate,
      mist: mist ?? this.mist,
      cream: cream ?? this.cream,
      deep: deep ?? this.deep,
      green: green ?? this.green,
      moss: moss ?? this.moss,
      sprout: sprout ?? this.sprout,
      clay: clay ?? this.clay,
      sand: sand ?? this.sand,
      onGreen: onGreen ?? this.onGreen,
    );
  }

  @override
  FernPalette lerp(ThemeExtension<FernPalette>? other, double t) {
    if (other is! FernPalette) return this;
    return FernPalette(
      ink: Color.lerp(ink, other.ink, t)!,
      slate: Color.lerp(slate, other.slate, t)!,
      mist: Color.lerp(mist, other.mist, t)!,
      cream: Color.lerp(cream, other.cream, t)!,
      deep: Color.lerp(deep, other.deep, t)!,
      green: Color.lerp(green, other.green, t)!,
      moss: Color.lerp(moss, other.moss, t)!,
      sprout: Color.lerp(sprout, other.sprout, t)!,
      clay: Color.lerp(clay, other.clay, t)!,
      sand: Color.lerp(sand, other.sand, t)!,
      onGreen: Color.lerp(onGreen, other.onGreen, t)!,
    );
  }
}

extension FernContext on BuildContext {
  FernPalette get fern => Theme.of(this).extension<FernPalette>()!;
}
