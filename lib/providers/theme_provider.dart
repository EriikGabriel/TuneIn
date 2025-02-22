import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_final/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends StateNotifier<ThemeData> {
  ThemeProvider() : super(darkTheme) {
    _loadPrimaryColor();
  }

  Future<void> _loadPrimaryColor() async {
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getInt('primaryColor');
    if (colorValue != null) {
      final color = Color(colorValue);
      setPrimaryColor(color);
    }
  }

  void toggleTheme() {
    if (state.brightness == Brightness.dark) {
      state = lightTheme.copyWith(
        primaryColor: state.primaryColor,
        colorScheme: lightTheme.colorScheme.copyWith(
          primary: state.primaryColor,
        ),
      );
    } else {
      state = darkTheme.copyWith(
        primaryColor: state.primaryColor,
        colorScheme: darkTheme.colorScheme.copyWith(
          primary: state.primaryColor,
        ),
      );
    }
  }

  void setTheme(bool isDarkMode) {
    if (isDarkMode) {
      state = darkTheme.copyWith(
        primaryColor: state.primaryColor,
        colorScheme: darkTheme.colorScheme.copyWith(
          primary: state.primaryColor,
        ),
      );
    } else {
      state = lightTheme.copyWith(
        primaryColor: state.primaryColor,
        colorScheme: lightTheme.colorScheme.copyWith(
          primary: state.primaryColor,
        ),
      );
    }
  }

  void setPrimaryColor(Color color) async {
    if (state.brightness == Brightness.dark) {
      state = darkTheme.copyWith(
        primaryColor: color,
        colorScheme: darkTheme.colorScheme.copyWith(primary: color),
      );
    } else {
      state = lightTheme.copyWith(
        primaryColor: color,
        colorScheme: lightTheme.colorScheme.copyWith(primary: color),
      );
    }
  }
}

final themeProvider = StateNotifierProvider<ThemeProvider, ThemeData>((ref) {
  return ThemeProvider();
});
