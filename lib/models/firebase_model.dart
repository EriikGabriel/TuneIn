import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseModel {
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  Future<void> addSong(
    String artist,
    String trackName,
    String imageUrl,
    User user,
  ) async {
    final snapshot =
        await _database
            .collection('users')
            .doc(user.uid)
            .collection('playlists')
            .get();

    final order = snapshot.docs.length;

    await _database
        .collection('users')
        .doc(user.uid)
        .collection('playlists')
        .add({
          'artist': artist,
          'track-name': trackName,
          'image-url': imageUrl,
          'order': order,
        });
  }

  Future<List<Map<String, dynamic>>> getUserPlaylist(User user) async {
    try {
      final snapshot =
          await _database
              .collection('users')
              .doc(user.uid)
              .collection('playlists')
              .orderBy('order')
              .get();

      if (snapshot.docs.isEmpty) return [];

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'artist': data['artist'],
          'name': data['track-name'],
          'imageUrl': data['image-url'],
        };
      }).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> removeSong(String artist, String trackName, User user) async {
    try {
      final snapshot =
          await _database
              .collection('users')
              .doc(user.uid)
              .collection('playlists')
              .where('artist', isEqualTo: artist)
              .where('track-name', isEqualTo: trackName)
              .get();

      if (snapshot.docs.isNotEmpty) {
        await snapshot.docs.first.reference.delete();
      }
    } catch (e) {
      print("Error removing song: $e");
    }
  }

  Future<bool> isSongInPlaylist(
    String artist,
    String trackName,
    User user,
  ) async {
    try {
      final snapshot =
          await _database
              .collection('users')
              .doc(user.uid)
              .collection('playlists')
              .where('artist', isEqualTo: artist)
              .where('track-name', isEqualTo: trackName)
              .get();

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<void> updateUserPlaylistOrder(
    User user,
    List<Map<String, dynamic>> newOrder,
  ) async {
    try {
      WriteBatch batch = _database.batch();

      for (var i = 0; i < newOrder.length; i++) {
        final song = newOrder[i];
        final doc =
            await _database
                .collection('users')
                .doc(user.uid)
                .collection('playlists')
                .where('artist', isEqualTo: song['artist'])
                .where('track-name', isEqualTo: song['name'])
                .limit(1)
                .get();

        if (doc.docs.isNotEmpty) {
          batch.update(doc.docs.first.reference, {'order': i});
        }
      }

      await batch.commit();
    } catch (e) {
      print("Error updating playlist order: $e");
    }
  }
}
