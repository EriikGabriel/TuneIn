import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
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
      return translate("danceEletronic");
    case MusicalGenre.rock:
      return translate("rock");
    case MusicalGenre.jazz:
      return translate("jazz");
    case MusicalGenre.rhythmAndBlues:
      return translate("r-and-b");
    case MusicalGenre.countryMusic:
      return translate("country-music");
    case MusicalGenre.pop:
      return translate("pop");
    case MusicalGenre.hipHop:
      return translate("hip-hop");
    case MusicalGenre.classicalMusic:
      return translate("classical");
    case MusicalGenre.reggae:
      return translate("reggae");
    case MusicalGenre.bossaNova:
      return translate("bossa-nova");
    case MusicalGenre.samba:
      return translate("samba");
    case MusicalGenre.funk:
      return translate("funk");
  }
}
