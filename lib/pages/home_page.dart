import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_final/components/header.dart';
import 'package:projeto_final/components/music_item_card.dart';
import 'package:projeto_final/components/small_card.dart';
import 'package:projeto_final/models/spotify_model.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Map<String, dynamic>>> _recommendationsFuture;

  @override
  void initState() {
    super.initState();
    _recommendationsFuture = SpotifyModel().getRecommendations();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                _buildSectionTitle('Recents', theme.primary, theme.secondary),
                _buildRecentsGrid(),
                const SizedBox(height: 40),
                _buildSectionTitle(
                  'Explore new music',
                  theme.primary,
                  theme.secondary,
                ),
                const SizedBox(height: 10),
                _buildRecommendations(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: const Header(title: 'Home'),
  );

  Widget _buildSectionTitle(String title, Color primary, Color secondary) =>
      Padding(
        padding: const EdgeInsets.all(20),
        child: Align(
          alignment: Alignment.centerLeft,
          child: GradientText(
            title,
            style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold),
            colors: [primary, secondary],
            gradientDirection: GradientDirection.ltr,
            gradientType: GradientType.linear,
          ),
        ),
      );

  Widget _buildRecentsGrid() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    child: GridView.builder(
      padding: const EdgeInsets.only(top: 2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 6,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      itemBuilder: (_, __) => const SmallCard(),
    ),
  );

  Widget _buildRecommendations() => FutureBuilder<List<Map<String, dynamic>>>(
    future: _recommendationsFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      }
      final recommendations = snapshot.data ?? [];
      if (recommendations.isEmpty) {
        return const Center(child: Text('No recommendations available.'));
      }
      return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: recommendations.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, index) {
          final item = recommendations[index];
          return MusicItemCard(
            artist: item['artist'],
            trackName: item['name'],
            imageUrl: item['imageUrl'],
            showFavoriteIcon: false,
          );
        },
      );
    },
  );
}
