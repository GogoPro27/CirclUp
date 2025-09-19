import 'dart:io' show Platform;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Stream<User?> get authStateChanges => _auth.authStateChanges();

  static Future<UserCredential> signInWithGoogle() async {
    // Mobile (Android/iOS)
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    if (gUser == null) {
      throw Exception('Sign-in aborted by user');
    }
    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: gAuth.idToken,
      accessToken: gAuth.accessToken,
    );
    return await _auth.signInWithCredential(credential);
  }

  static Future<void> signOut() async {
    try {
      // Sign out Google (if used) then Firebase
      final google = GoogleSignIn();
      if (await google.isSignedIn()) {
        await google.signOut();
      }
    } catch (_) {}
    await _auth.signOut();
  }
}