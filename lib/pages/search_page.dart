import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_final/components/header.dart';
import 'package:projeto_final/components/music_genre_card.dart';
import 'package:projeto_final/components/music_item_card.dart';
import 'package:projeto_final/models/auth_model.dart';
import 'package:projeto_final/models/firebase_model.dart';
import 'package:projeto_final/models/spotify_model.dart';
import 'package:projeto_final/theme/app_theme.dart';
import 'package:projeto_final/types/musical_genre.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFieldFocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  List<dynamic> _searchResult = [];
  bool _searched = false;

  @override
  void dispose() {
    _textController.dispose();
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildBrowseTitle(primaryColor, secondaryColor),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: _buildContent(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Header(title: "Search", searchBar: _buildSearchBar()),
    );
  }

  Widget _buildBrowseTitle(Color primaryColor, Color secondaryColor) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: GradientText(
          'Browse all',
          style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold),
          colors: [primaryColor, secondaryColor],
          gradientDirection: GradientDirection.ltr,
          gradientType: GradientType.linear,
        ),
      ),
    );
  }

  Widget _buildContent() {
    return _searched ? _buildSearchResult() : _buildGenreGrid();
  }

  Widget _buildSearchBar() {
    final secondaryBackground =
        Theme.of(context).colorScheme.secondaryBackground;
    final primaryText = Theme.of(context).colorScheme.primaryText;
    final secondaryText = Theme.of(context).colorScheme.secondaryText;

    return TextField(
      controller: _textController,
      focusNode: _textFieldFocusNode,
      decoration: InputDecoration(
        isDense: true,
        hintText: "What do you want to play?",
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: secondaryText,
        ),
        enabledBorder: _inputBorder(),
        focusedBorder: _inputBorder(),
        filled: true,
        fillColor: secondaryBackground,
        prefixIcon: Icon(Icons.search, color: secondaryText),
      ),
      style: TextStyle(color: primaryText),
      cursorColor: primaryText,
      onSubmitted: _onSearchSubmitted,
    );
  }

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(8),
    );
  }

  void _onSearchSubmitted(String query) {
    setState(() {
      _isLoading = true;
      _searched = true;
    });
    _searchTracks(query);
  }

  Future<void> _searchTracks(String query) async {
    try {
      final result = await SpotifyModel().searchTracks(query);
      if (mounted) {
        setState(() {
          _searchResult = result;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error during search: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Widget _buildSearchResult() {
    final user = ref.watch(userProvider);

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_searchResult.isEmpty) {
      return const Center(child: Text('No results.'));
    }

    return FutureBuilder<List<bool>>(
      future: Future.wait(
        _searchResult.map<Future<bool>>((item) {
          var artist = item['artist'];
          var trackName = item['name'];
          return FirebaseModel().isSongInPlaylist(artist, trackName, user!);
        }),
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final statusList = snapshot.data!;
        return ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: _searchResult.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final item = _searchResult[index];
            return MusicItemCard(
              artist: item['artist'],
              trackName: item['name'],
              imageUrl: item['imageUrl'],
              showFavoriteIcon: statusList[index],
            );
          },
        );
      },
    );
  }

  Widget _buildGenreGrid() {
    return Stack(
      children: [
        GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2,
          ),
          itemCount: MusicalGenre.values.length,
          itemBuilder: (context, i) {
            final genre = MusicalGenre.values[i];
            return GestureDetector(
              onTap: () => _onGenreTap(genre),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: MusicGenreCard(
                  genreName: getGenreName(genre),
                  icon: musicalGenreIcons[genre] ?? Icons.music_note,
                  backgroundColor:
                      Colors.primaries[i % Colors.primaries.length],
                  textColor: Colors.white,
                ),
              ),
            );
          },
        ),
        _buildGradientOverlay(),
      ],
    );
  }

  void _onGenreTap(MusicalGenre genre) async {
    setState(() {
      _isLoading = true;
      _searched = true;
    });

    final spotifyreq = SpotifyModel();
    _searchResult = await spotifyreq.searchTracksByGenre(getGenreName(genre));

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildGradientOverlay() {
    return Positioned.fill(
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).scaffoldBackgroundColor.withAlpha(153),
                Colors.transparent,
                Theme.of(context).scaffoldBackgroundColor.withAlpha(153),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
