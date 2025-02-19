import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_final/types/login.dart';

class Authenticate {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> sign({
    required String email,
    required LoginMode mode,
    required String password,
  }) async {
    try {
      if (mode == LoginMode.signIn) {
        UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        return result.user;
      } else if (mode == LoginMode.signUp) {
        UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        return result.user;
      } else {
        throw Exception('Invalid mode: $mode');
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication errors here
      print('Error: ${e.message}');
      return null;
    }
  }
}
