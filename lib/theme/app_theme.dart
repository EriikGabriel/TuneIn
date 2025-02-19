import 'package:flutter/material.dart';

extension CustomColorScheme on ColorScheme {
  // Brand Colors
  Color get primary => const Color(0xFF1ED760);
  Color get secondary => const Color(0xFF39D2C0);
  Color get tertiary => const Color(0xFFEE8B60);
  Color get alternate => const Color(0xFF262D34);

  // Utility Colors
  Color get primaryText => const Color(0xFFFFFFFF);
  Color get secondaryText => const Color(0xFF95A1AC);
  Color get primaryBackground => const Color(0xFF1D2428);
  Color get secondaryBackground => const Color(0xFF14181B);

  // Accent Colors
  Color get accent1 => const Color(0xFF13803B);
  Color get accent2 => const Color(0xff4d39d2c0);
  Color get accent3 => const Color(0xff4dee8b60);
  Color get accent4 => const Color(0xffb2262d34);

  // Semantic Colors
  Color get success => const Color(0xFF249689);
  Color get error => const Color(0xFFFF5963);
  Color get warning => const Color(0xFFF9CF58);
  Color get info => const Color(0xFFFFFFFF);
}

final ThemeData appThemeData = ThemeData(
  brightness: Brightness.light,

  primaryColor: const Color(0xFF1ED760),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF1ED760), // Primary
    onPrimary: Colors.white,
    secondary: Color(0xFF33B0A8), // Secondary
    onSecondary: Colors.white,
    surface: Color(0xFF14181B), // Secondary Background
    onSurface: Colors.white,
    error: Color(0xFFD32F2F),
    onError: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.black, // Usa o primary background

  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'Oswald',
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Color(0xFF26344A),
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Inter',
      fontSize: 16,
      color: Color(0xFF26344A),
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Inter',
      fontSize: 14,
      color: Color(0xFF26344A),
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF1ED760),
      foregroundColor: Colors.white,
      textStyle: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF1ED760), width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red.shade700, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red.shade700, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);
