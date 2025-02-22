import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_final/providers/theme_provider.dart';
import 'package:projeto_final/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeSwitch extends ConsumerStatefulWidget {
  const ThemeSwitch({super.key});

  @override
  ThemeSwitchState createState() => ThemeSwitchState();
}

class ThemeSwitchState extends ConsumerState<ThemeSwitch> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? true;
      ref.read(themeProvider.notifier).setTheme(isDarkMode);
    });
  }

  Future<void> _toggleTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = value;
      prefs.setBool('isDarkMode', isDarkMode);
    });
    ref.read(themeProvider.notifier).toggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final secondaryText = Theme.of(context).colorScheme.secondaryText;
    final switchTrackColor =
        isDarkMode ? primaryColor.withValues(alpha: 0.5) : Colors.grey[300];

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      spacing: 5,
      children: [
        Icon(
          isDarkMode ? Icons.dark_mode : Icons.light_mode,
          color: secondaryText,
        ),
        Switch(
          value: isDarkMode,
          onChanged: _toggleTheme,
          activeColor: secondaryText,
          inactiveTrackColor: switchTrackColor,
          thumbColor: WidgetStateProperty.resolveWith<Color>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.selected)) {
              return Colors.blueGrey;
            }
            return Colors.grey;
          }),
          trackColor: WidgetStateProperty.resolveWith<Color>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.selected)) {
              return Colors.blueGrey.withValues(alpha: 0.5);
            }
            return Colors.grey[300]!;
          }),
        ),
      ],
    );
  }
}
