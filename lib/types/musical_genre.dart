import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum MusicalGenre {
  danceElectronic,
  rock,
  jazz,
  rhythmAndBlues,
  countryMusic,
  pop,
  hipHop,
  classicalMusic,
  reggae,
  bossaNova,
  samba,
  funk,
}

final musicalGenreIcons = {
  MusicalGenre.danceElectronic:
      FontAwesomeIcons.headphones, // Ícone do Font Awesome
  MusicalGenre.rock: FontAwesomeIcons.guitar, // Ícone do Material Icons
  MusicalGenre.jazz: FontAwesomeIcons.compactDisc, // Ícone do Material Icons
  MusicalGenre.rhythmAndBlues: Icons.mic, // Ícone do Material Icons
  MusicalGenre.countryMusic: FontAwesomeIcons.guitar, // Ícone do Material Icons
  MusicalGenre.pop: Icons.star, // Ícone do Material Icons
  MusicalGenre.hipHop: Icons.speaker, // Ícone do Material Icons
  MusicalGenre.classicalMusic: Icons.piano, // Ícone do Material Icons
  MusicalGenre.reggae: FontAwesomeIcons.leaf, // Ícone do Material Icons
  MusicalGenre.bossaNova: Icons.beach_access, // Ícone do Material Icons
  MusicalGenre.samba: FontAwesomeIcons.drum, // Ícone do Material Icons
  MusicalGenre.funk: FontAwesomeIcons.recordVinyl, // Ícone do Material Icons
};

String getGenreName(MusicalGenre genre) {
  switch (genre) {
    case MusicalGenre.danceElectronic:
      return "Dance/Electronic";
    case MusicalGenre.rock:
      return "Rock";
    case MusicalGenre.jazz:
      return "Jazz";
    case MusicalGenre.rhythmAndBlues:
      return "Rhythm and Blues (R&B)";
    case MusicalGenre.countryMusic:
      return "Country Music";
    case MusicalGenre.pop:
      return "Pop";
    case MusicalGenre.hipHop:
      return "Hip-hop";
    case MusicalGenre.classicalMusic:
      return "Classical Music";
    case MusicalGenre.reggae:
      return "Reggae";
    case MusicalGenre.bossaNova:
      return "Bossa Nova";
    case MusicalGenre.samba:
      return "Samba";
    case MusicalGenre.funk:
      return "Funk";
  }
}
