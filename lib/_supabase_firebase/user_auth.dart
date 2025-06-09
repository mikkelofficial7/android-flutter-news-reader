import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_news_reader/_supabase_firebase/base/firebase_authentication.dart';
import 'package:flutter_news_reader/_supabase_firebase/base/supabase_db.dart';
import 'package:flutter_news_reader/constant/util_constant.dart';
import 'package:flutter_news_reader/pages/login/loginpage.dart';
import 'package:flutter_news_reader/route/base/base_navigation_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserAuth {
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

  static Future<bool> checkDbUserExist(String email) async {
    final result = await SupabaseDb().getUserEmailExist(email);

    final count = result.count ?? 0;
    return count > 0;
  }

  static Future<bool> insertUserData(String email, String phone,
      String firstName, String lastName, String photoUrl) async {
    await SupabaseDb().insertDataUser(email, phone, firstName, lastName,
        photoUrl, UtilConstant.backgroundUrl);

    return true;
  }

  static Future<PostgrestResponse> getDbUserExist(String email) async {
    final result = await SupabaseDb().getUserEmailExist(email);
    return result;
  }
}
