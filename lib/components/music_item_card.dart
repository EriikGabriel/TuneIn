import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_final/theme/app_theme.dart';

class MusicItemCard extends StatefulWidget {
  const MusicItemCard({super.key});

  @override
  State<MusicItemCard> createState() => _MusicItemCardState();
}

class _MusicItemCardState extends State<MusicItemCard> {
  @override
  Widget build(BuildContext context) {
    final primaryBackground = Theme.of(context).colorScheme.primaryBackground;
    final secondaryBackground =
        Theme.of(context).colorScheme.secondaryBackground;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final infoColor = Theme.of(context).colorScheme.info;
    final primaryText = Theme.of(context).colorScheme.primaryText;
    final secondaryText = Theme.of(context).colorScheme.secondaryText;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 90,
      decoration: BoxDecoration(
        color: secondaryBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: primaryBackground),
      ),
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Scaffold(
                          appBar: AppBar(
                            backgroundColor: Colors.black,
                            leading: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          backgroundColor: Colors.black,
                          body: Center(
                            child: Hero(
                              tag: 'imageTag',
                              child: InteractiveViewer(
                                child: Image.network(
                                  'https://picsum.photos/seed/780/600',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                child: Hero(
                  tag: 'imageTag',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: 'https://picsum.photos/seed/780/600',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              // Dados da música
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Music Name",
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryText,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    spacing: 10,
                    children: [
                      Icon(
                        Icons.explicit_rounded,
                        size: 24,
                        color: secondaryText,
                      ),
                      Text(
                        "Artista 1, Artista 2...",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: secondaryText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // Botões de ação
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.favorite_rounded,
                  color: primaryColor,
                  size: 30,
                ),
                onPressed: () {
                  print('Favorite pressed');
                },
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: Icon(Icons.more_vert, color: infoColor, size: 30),
                onPressed: () {
                  print('More pressed');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
