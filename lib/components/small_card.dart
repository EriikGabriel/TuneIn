import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_final/theme/app_theme.dart';

class SmallCard extends StatefulWidget {
  const SmallCard({super.key});

  @override
  State<SmallCard> createState() => _SmallCardState();
}

class _SmallCardState extends State<SmallCard> {
  @override
  Widget build(BuildContext context) {
    final primaryBackground = Theme.of(context).colorScheme.primaryBackground;
    final secondaryBackground =
        Theme.of(context).colorScheme.secondaryBackground;

    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: secondaryBackground,
        border: Border.all(color: primaryBackground),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Colors.black.withValues(
              alpha: 0.2,
            ), // Aproximadamente 0x33000000
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(8),
      ),

      child: Row(
        spacing: 10,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://picsum.photos/seed/63/600',
              width: MediaQuery.of(context).size.width * 0.05,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Text(
            "My Playlist/Music",
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color:
                  Theme.of(
                    context,
                  ).colorScheme.primaryText, // ou outra cor definida no tema
            ),
          ),
        ],
      ),
    );
  }
}
