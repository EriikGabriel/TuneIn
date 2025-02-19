import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_final/components/music_genre_card.dart';
import 'package:projeto_final/models/spotifyReq.dart';
import 'package:projeto_final/theme/app_theme.dart';
import 'package:projeto_final/types/musical_genre.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GradientText(
                    'Browse all',
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
                child: CachedNetworkImage(
                  fadeInDuration: const Duration(milliseconds: 500),
                  fadeOutDuration: const Duration(milliseconds: 500),
                  imageUrl:
                      'https://api.dicebear.com/9.x/fun-emoji/svg?seed=Brian',
                  width: 50,
                  height: 50,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(width: 20),
              Text(
                'Search',
                style: GoogleFonts.inter(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: primaryText,
                ),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: _buildSearchBar(),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildContent() {
  if (_searched) {
    return _buildSearchResult();
  } else {
    return _buildGrid();
  }
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
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: secondaryBackground,
        prefixIcon: Icon(Icons.search, color: secondaryText),
      ),
      style: TextStyle(color: primaryText),
      cursorColor: primaryText,
      onSubmitted: (query) async {
        setState(() {
          _isLoading = true;
          _searched = true;
        });

        try {
          Spotifyreq spotifyreq = Spotifyreq();

          _searchResult = await spotifyreq.searchTracks(query);

          setState(() {
          _isLoading = false;
          });

        }catch (e) {
          print('Erro durante a busca: $e');
        }
      },
    );
  }

  Widget _buildSearchResult(){
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } 
    else if(_searchResult.isEmpty){
      return Center(child: Text('No results.'),);
    }
    else{
      return ListView.builder(
        itemCount: _searchResult.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_searchResult[index]),
          );
        },
      );
    }
  }

  Widget _buildGrid() {
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
          itemCount: 12,
          itemBuilder: (context, i) {
            final genre = MusicalGenre.values[i];
            return MusicGenreCard(
              genreName: getGenreName(genre),
              icon: musicalGenreIcons[genre] ?? Icons.music_note,
              backgroundColor: Colors.primaries[i % Colors.primaries.length],
              textColor: Colors.white,
            );
          },
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.6), // Mais escuro no topo
                    Colors.transparent, // Transparente no meio
                    Colors.black.withValues(alpha: 0.6), // Mais escuro na base
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
