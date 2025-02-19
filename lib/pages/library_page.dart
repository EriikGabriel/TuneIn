import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_final/components/playlist_item_card.dart';
import 'package:projeto_final/theme/app_theme.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  // Exemplo de lista de itens da playlist
  final List<String> _playlistItems = List.generate(
    4,
    (index) => 'Playlist ${index + 1}',
  );

  @override
  Widget build(BuildContext context) {
    // Cores e tipografia a partir do Theme
    final primaryColor = Theme.of(context).colorScheme.primary;
    final textColor = Theme.of(context).colorScheme.primaryText;

    return GestureDetector(
      onTap: () {
        // Remove o foco de qualquer campo de entrada
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              // Usando a propriedade spacing para definir gap entre os filhos
              spacing: 20, // Espaço de 20 entre os elementos
              children: [
                // Cabeçalho com avatar e título
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  // A propriedade de padding do Container foi mantida para afastar do bordo da tela
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    spacing: 20,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 20,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              fadeInDuration: const Duration(milliseconds: 500),
                              fadeOutDuration: const Duration(
                                milliseconds: 500,
                              ),
                              imageUrl:
                                  'https://api.dicebear.com/9.x/fun-emoji/svg?seed=Brian',
                              width: 50,
                              height: 50,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text(
                            'Your Library',
                            style: GoogleFonts.inter(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: primaryColor, size: 30),
                        onPressed: () {
                          // Ação para adicionar nova playlist
                          print('Add button pressed');
                        },
                      ),
                    ],
                  ),
                ),
                // Lista de itens da playlist
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _playlistItems.length,
                    separatorBuilder:
                        (context, index) => const Divider(
                          color: Colors.transparent,
                          height: 20,
                        ),
                    itemBuilder: (context, index) {
                      return PlaylistItemCard(
                        title: _playlistItems[index],
                        songCount: 10,
                        onMorePressed: () {
                          // Ação para exibir mais opções
                          print('More options pressed');
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
