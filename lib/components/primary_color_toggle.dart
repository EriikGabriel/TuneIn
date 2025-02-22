import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_final/providers/theme_provider.dart';
import 'package:projeto_final/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrimaryColorToggle extends ConsumerStatefulWidget {
  const PrimaryColorToggle({super.key});

  @override
  ConsumerState<PrimaryColorToggle> createState() => PrimaryColorToggleState();
}

class PrimaryColorToggleState extends ConsumerState<PrimaryColorToggle> {
  final List<Color> colors = [
    const Color(0xFF1ED760),
    const Color(0xFF9C1ED7),
    const Color(0xFFD7811E),
  ];

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadPrimaryColor();
  }

  Future<void> _loadPrimaryColor() async {
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getInt('primaryColor');
    if (colorValue != null) {
      final color = Color(colorValue);
      final index = colors.indexWhere((element) => element == color);
      if (index != -1) setState(() => selectedIndex = index);
      ref.read(themeProvider.notifier).setPrimaryColor(color);
    }
  }

  Future<void> _selectColor(int index) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedIndex = index;
      prefs.setInt('primaryColor', colors[index].value);
    });
    ref.read(themeProvider.notifier).setPrimaryColor(colors[index]);
  }

  @override
  Widget build(BuildContext context) {
    final primaryTextColor =
        Theme.of(context).colorScheme.primaryText; // Cor do texto primário

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(colors.length, (index) {
        final color = colors[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: GestureDetector(
            onTap: () => _selectColor(index),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    color,
                    color.withValues(alpha: 0.5),
                  ], // Degradê para todas as bolinhas
                ),
                border: Border.all(
                  color:
                      index == selectedIndex
                          ? primaryTextColor
                          : Colors.transparent, // Borda colorida se selecionado
                  width: 2,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
