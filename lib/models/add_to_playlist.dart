import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BackendPlayList {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    Future<void> addSong(Map<String, dynamic> track, User user) async {
      await _firestore.collection('users').doc(user.uid).collection('playlists').add(track);
    }


    Stream<QuerySnapshot> getPlaylist(User user) async* {
      yield* _firestore.collection('users').doc(user.uid).collection('playlist').snapshots();
  }
}