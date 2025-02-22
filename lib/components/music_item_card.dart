import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_final/models/auth_model.dart';
import 'package:projeto_final/models/firebase_model.dart';
import 'package:projeto_final/providers/user_provider.dart';
import 'package:projeto_final/theme/app_theme.dart';

class MusicItemCard extends ConsumerStatefulWidget {
  final String trackName;
  final String artist;
  final String imageUrl;
  final bool showFavoriteIcon;
  final EdgeInsetsGeometry favPadding;

  const MusicItemCard({
    super.key,
    required this.trackName,
    required this.artist,
    required this.imageUrl,
    this.showFavoriteIcon = false,
    this.favPadding = const EdgeInsets.all(0),
  });

  @override
  ConsumerState<MusicItemCard> createState() => _MusicItemCardState();
}

class _MusicItemCardState extends ConsumerState<MusicItemCard> {
  bool isFavorite = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkIfSongIsFavorite();
  }

  Future<void> _checkIfSongIsFavorite() async {
    final user = ref.read(userProvider);
    if (user != null) {
      final favoriteStatus = await FirebaseModel().isSongInPlaylist(
        widget.artist,
        widget.trackName,
        user,
      );
      if (mounted) {
        setState(() {
          isFavorite = favoriteStatus;
        });
      }
    }
  }

  Future<void> _toggleFavorite() async {
    final user = ref.read(userProvider);
    if (user != null) {
      if (isFavorite) {
        await FirebaseModel().removeSong(widget.artist, widget.trackName, user);
      } else {
        await FirebaseModel().addSong(
          widget.artist,
          widget.trackName,
          widget.imageUrl,
          user,
        );
      }
      if (mounted) {
        setState(() {
          isFavorite = !isFavorite;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 90,
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.primaryBackground),
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
                      builder:
                          (context) => Scaffold(
                            appBar: AppBar(
                              backgroundColor: theme.primary,
                              leading: IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: theme.primaryText,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                            body: Center(
                              child: Hero(
                                tag: 'imageTag',
                                child: InteractiveViewer(
                                  child: Image.network(
                                    widget.imageUrl,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                    ),
                  );
                },
                child: Hero(
                  tag: 'imageTag',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: widget.imageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.trackName,
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: theme.primaryText,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.explicit_rounded,
                        size: 24,
                        color: theme.secondaryText,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.artist,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: theme.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: widget.favPadding,
            child: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite_rounded : Icons.add,
                color: isFavorite ? theme.primary : theme.info,
                size: 30,
              ),
              onPressed: _toggleFavorite,
            ),
          ),
        ],
      ),
    );
  }
}
