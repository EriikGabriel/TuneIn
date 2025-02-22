import 'package:flutter/material.dart';

extension CustomColorScheme on ColorScheme {
  // Brand Colors
  Color get primary => const Color(0xFF1ED760);
  Color get secondary => const Color(0xFF39D2C0);
  Color get tertiary => const Color(0xFFEE8B60);
  Color get alternate => const Color(0xFF262D34);

  // Utility Colors
  Color get primaryText =>
      brightness == Brightness.dark
          ? const Color(0xFFFFFFFF) // Cor do texto primário no tema escuro
          : const Color(0xFF000000); // Cor do texto primário no tema claro

  Color get secondaryText =>
      brightness == Brightness.dark
          ? const Color(0xFF95A1AC) // Cor do texto secundário no tema escuro
          : const Color(0xFF6B6B6B); // Cor do texto secundário no tema claro

  Color get primaryBackground =>
      brightness == Brightness.dark
          ? const Color(0xFF1D2428) // Cor de fundo primário no tema escuro
          : const Color(0xFFFFFFFF); // Cor de fundo primário no tema claro

  Color get secondaryBackground =>
      brightness == Brightness.dark
          ? const Color(0xFF14181B) // Cor de fundo secundário no tema escuro
          : const Color(0xFFF6F6F6); // Cor de fundo secundário no tema claro

  // Semantic Colors
  Color get success => const Color(0xFF249689);
  Color get error => const Color(0xFFFF5963);
  Color get warning => const Color(0xFFF9CF58);
  Color get info => const Color(0xFFFFFFFF);
}

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF1ED760),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF1ED760),
    onPrimary: Colors.white,
    secondary: Color(0xFF33B0A8),
    onSecondary: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
    error: Color(0xFFD32F2F),
    onError: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 16, color: Colors.black),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF1ED760),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF1ED760),
    onPrimary: Colors.white,
    secondary: Color(0xFF33B0A8),
    onSecondary: Colors.white,
    surface: Color.fromARGB(255, 255, 255, 255),
    onSurface: Colors.white,
    error: Color(0xFFD32F2F),
    onError: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.black,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
  ),
);
