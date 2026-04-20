import 'package:flutter/material.dart';

class MoveTheme {
  static const Color background = Color(0xFF040404);
  static const Color panel = Color(0xFF0B0B0B);
  static const Color panelAlt = Color(0xFF121212);
  static const Color panelRaised = Color(0xFF161616);
  static const Color stroke = Color(0xFF4D3712);
  static const Color primary = Color(0xFFD4A94D);
  static const Color secondary = Color(0xFFF2D389);
  static const Color softGold = Color(0xFF9F7623);
  static const Color highlight = Color(0xFFFFE5A6);
  static const Color textMuted = Color(0xFFAEA58F);
  static const Color danger = Color(0xFFC8902C);
  static const Color success = Color(0xFFD4A94D);
  static const Color warning = Color(0xFFF2D389);

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
      iconTheme: const IconThemeData(color: primary),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return background;
          }
          return const Color(0xFF9C927E);
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return primary;
          }
          return const Color(0xFF312513);
        }),
      ),
      sliderTheme: base.sliderTheme.copyWith(
        activeTrackColor: primary,
        inactiveTrackColor: const Color(0xFF312513),
        thumbColor: highlight,
        overlayColor: primary.withValues(alpha: 0.16),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF0B0B0B),
        selectedItemColor: primary,
        unselectedItemColor: Color(0xFF8D846F),
        selectedIconTheme: IconThemeData(color: primary),
        unselectedIconTheme: IconThemeData(color: Color(0xFF8D846F)),
      ),
    );
  }
}
