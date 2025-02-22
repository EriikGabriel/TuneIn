import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_final/components/primary_color_toggle.dart';
import 'package:projeto_final/components/theme_switch.dart';
import 'package:projeto_final/components/user_menu.dart';

class Header extends StatelessWidget {
  final String title;
  final Widget? searchBar;

  const Header({super.key, required this.title, this.searchBar});

  @override
  Widget build(BuildContext context) {
    final primaryText = Colors.white;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: UserMenu(),
              ),
              const SizedBox(width: 20),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: primaryText,
                ),
              ),
            ],
          ),
          const Spacer(),
          if (searchBar != null)
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: searchBar,
            ),
          const Spacer(),
          // Adicionando o ThemeSwitch no final da linha
          Row(
            spacing: 30,
            children: const [PrimaryColorToggle(), ThemeSwitch()],
          ),
        ],
      ),
    );
  }
}
