import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_final/components/music_item_card.dart';
import 'package:projeto_final/models/add_to_playlist.dart';
import 'package:projeto_final/models/authenticate.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';


class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFieldFocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();


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
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: _buildList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
  
  _buildList(){
    var user = ProviderScope.containerOf(context).read(userProvider);

    return FutureBuilder<List<Map<String, dynamic>>>(
        future: BackendPlayList().getUserPlaylist(user!),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          else if(!snapshot.hasData){
            return Center(child: Text('You dont have songs on your playlist. Search and add some!'));
          }
          final data = snapshot.data;

          return ListView.builder(
            itemCount: data!.length,
            itemBuilder: (context, index) {
              final playlist = data[index];

              return MusicItemCard(trackName: playlist['name'], artist: playlist['artist'], imageUrl: playlist['imageUrl']);
            },
          );
        },
      );
  }
}
