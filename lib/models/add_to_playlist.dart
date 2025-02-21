import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BackendPlayList {
    final FirebaseFirestore dataBase = FirebaseFirestore.instance;

    Future<void> addSong(String artist, String trackName, String imageUrl, User user) async {
      await dataBase.collection('users').doc(user.uid).collection('playlists').add({'artist': artist, 'track-name': trackName, 'image-url': imageUrl});
    
    }


  Future<List<Map<String, dynamic>>> getUserPlaylist(User user) async {
    try {
      final snapshot = await dataBase.collection('users').doc(user.uid).collection('playlists').get();

      if (snapshot.docs.isEmpty) {
        print("User has no playlist");
        return [];
      }

      return snapshot.docs.map((doc) {
        final data = doc.data(); 

        return {
          'artist': data['artist'],
          'name': data['track-name'],
          'imageUrl': data['image-url'],
        };
      }).toList();

    } catch (e) {
      print("Error getting users playlist: $e");
      return []; 
    }
  }
}