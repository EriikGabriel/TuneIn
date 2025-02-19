import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_final/theme/app_theme.dart';

class PlaylistItemCard extends StatelessWidget {
  final String title;
  final int songCount;
  final VoidCallback? onMorePressed;

  const PlaylistItemCard({
    super.key,
    required this.title,
    required this.songCount,
    this.onMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    final primaryBackground = Theme.of(context).colorScheme.primaryBackground;
    final secondaryBackground =
        Theme.of(context).colorScheme.secondaryBackground;
    final secondaryText = Theme.of(context).colorScheme.secondaryText;

    return Container(
      width: double.infinity,
      height: 90,
      decoration: BoxDecoration(
        color: secondaryBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: primaryBackground),
      ),
      padding: const EdgeInsets.all(15),
      child: Row(
        spacing: 20, // Define espaçamento entre os widgets filhos
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Informações da Playlist
          Row(
            spacing: 20,
            children: [
              Column(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Playlist • $songCount songs',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: secondaryText,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Botão de Mais Opções
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white, size: 30),
            onPressed: onMorePressed ?? () => print('More options pressed'),
          ),
        ],
      ),
    );
  }
}
