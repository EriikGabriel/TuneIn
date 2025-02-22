import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_final/components/header.dart';
import 'package:projeto_final/components/music_item_card.dart';
import 'package:projeto_final/models/auth_model.dart';
import 'package:projeto_final/models/firebase_model.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final primaryColor = Theme.of(context).colorScheme.primary;
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: Header(title: 'Library'),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GradientText(
                    'Your Playlist',
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    colors: [primaryColor, secondaryColor],
                    gradientDirection: GradientDirection.ltr,
                    gradientType: GradientType.linear,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildReorderableList(user),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReorderableList(User? user) {
    if (user == null) {
      return const Center(
        child: Text(
          'User not logged in. Please log in to see your playlist.',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: FirebaseModel().getUserPlaylist(user),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.white),
            ),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              "You don't have songs in your playlist. Search and add some!",
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        final playlist = List<Map<String, dynamic>>.from(snapshot.data!);

        return StatefulBuilder(
          builder: (context, setState) {
            return ReorderableListView.builder(
              itemCount: playlist.length,
              onReorder: (oldIndex, newIndex) async {
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }

                setState(() {
                  final item = playlist.removeAt(oldIndex);
                  playlist.insert(newIndex, item);
                });

                await FirebaseModel().updateUserPlaylistOrder(user, playlist);
              },
              itemBuilder: (context, index) {
                final item = playlist[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  key: ValueKey(
                    item['id'] ?? '${item['artist']}_${item['name']}_$index',
                  ),
                  child: MusicItemCard(
                    trackName: item['name'],
                    artist: item['artist'],
                    imageUrl: item['imageUrl'],
                    showFavoriteIcon: true,
                    favPadding: const EdgeInsets.only(right: 40),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
