import 'package:flutter/material.dart';

class MoveTheme {
  static const Color background = Color(0xFF07070D);
  static const Color panel = Color(0xFF10111A);
  static const Color panelAlt = Color(0xFF151726);
  static const Color stroke = Color(0xFF2C2E46);
  static const Color primary = Color(0xFF9B3DFF);
  static const Color secondary = Color(0xFF00C2FF);
  static const Color danger = Color(0xFFFF4D6D);
  static const Color success = Color(0xFF27D980);
  static const Color warning = Color(0xFFFFA928);

  static ThemeData get darkTheme {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: background,
      colorScheme: base.colorScheme.copyWith(
        surface: panel,
        primary: primary,
        secondary: secondary,
        error: danger,
      ),
      textTheme: base.textTheme.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      cardTheme: const CardThemeData(
        color: panel,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      dividerColor: stroke,
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.white;
          }
          return const Color(0xFF9A9CB3);
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return primary;
          }
          return const Color(0xFF2A2C42);
        }),
      ),
      sliderTheme: base.sliderTheme.copyWith(
        activeTrackColor: primary,
        inactiveTrackColor: const Color(0xFF2A2C42),
        thumbColor: Colors.white,
        overlayColor: primary.withValues(alpha: 0.16),
      ),
    );
  }
}
