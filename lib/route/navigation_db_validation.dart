import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_news_reader/_supabase_firebase/firebase_authentication.dart';
import 'package:flutter_news_reader/_supabase_firebase/supabase_db.dart';
import 'package:flutter_news_reader/pages/login/loginpage.dart';
import 'package:flutter_news_reader/route/base/base_navigation_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRoute {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  static bool isUserLoginByGoogle() {
    return FirebaseAuthentication().dataLoggedInWithGoogle() != null;
  }

  static void checkUserLoginStatus(void Function() onLoginValid) {
    final isGoogleUser = isUserLoginByGoogle();

    if (isGoogleUser) {
      onLoginValid();
    } else {
      NavigationService.navigateTo(LoginPage());
    }
  }

  static Future<void> checkUserExist(void Function() onLoginValid) async {
    final result = await SupabaseDb().getUserEmailExist();

    final count = result.count ?? 0;

    if (count > 0) {
      onLoginValid();
    } else {
      NavigationService.navigateTo(LoginPage());
    }
  }
}
