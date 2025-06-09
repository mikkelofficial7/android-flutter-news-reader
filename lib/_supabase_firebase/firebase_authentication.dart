import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  UserInfo? dataLoggedInWithGoogle() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return null;

    try {
      return user.providerData.firstWhere(
        (provider) => provider.providerId == 'google.com',
      );
    } catch (e) {
      return null;
    }
  }

  Future<UserCredential?> doSignInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      // Google sign-in error
      return null;
    }
  }

  Future<void> doSignOutByGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
