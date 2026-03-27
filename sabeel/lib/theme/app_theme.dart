import 'package:flutter/material.dart';

/// Centralised theme definitions inspired by Mawaqit's clean aesthetic.
class AppTheme {
  AppTheme._();

  // ── Brand colours ───────────────────────────────────────
  static const Color _primaryGreen = Color(0xFF1B5E20);
  static const Color _accentGold = Color(0xFFD4A843);
  static const Color _darkSurface = Color(0xFF1A1A2E);
  static const Color _darkCard = Color(0xFF16213E);

  // ── Light theme ─────────────────────────────────────────
  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryGreen,
      brightness: Brightness.light,
      primary: _primaryGreen,
      secondary: _accentGold,
    ),
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    appBarTheme: const AppBarTheme(
      backgroundColor: _primaryGreen,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: _primaryGreen,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
    ),
    fontFamily: 'Roboto',
  );

  // ── Dark theme ──────────────────────────────────────────
  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryGreen,
      brightness: Brightness.dark,
      primary: const Color(0xFF4CAF50),
      secondary: _accentGold,
      surface: _darkSurface,
    ),
    scaffoldBackgroundColor: _darkSurface,
    appBarTheme: const AppBarTheme(
      backgroundColor: _darkCard,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      color: _darkCard,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Color(0xFF4CAF50),
      unselectedItemColor: Colors.grey,
      backgroundColor: _darkCard,
      type: BottomNavigationBarType.fixed,
    ),
    fontFamily: 'Roboto',
  );
}