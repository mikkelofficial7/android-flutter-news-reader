import 'package:flutter/material.dart';
import 'package:flutter_news_reader/_supabase_firebase/base/firebase_authentication.dart';
import 'package:flutter_news_reader/_supabase_firebase/user_auth.dart';
import 'package:flutter_news_reader/constant/color.dart';
import 'package:flutter_news_reader/constant/language.dart';
import 'package:flutter_news_reader/main.dart';
import 'package:flutter_news_reader/route/base/base_navigation_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  Future<void> onLoginWithGoogle(BuildContext context) async {
    final loginData = await FirebaseAuthentication().doSignInWithGoogle();

    if (loginData != null) {
      var isUserOnDb =
          await UserAuth.checkDbUserExist(loginData.user?.email ?? "");

      if (!isUserOnDb) {
        List<String> arrayName = (loginData.user?.displayName ?? "").split(" ");
        String firstName = arrayName.isNotEmpty ? arrayName[0] : "";
        String lastName = arrayName.length > 1 ? arrayName[1] : "";
        String email = loginData.user?.email ?? "";
        String phone = loginData.user?.phoneNumber ?? "";
        String photoUrl = loginData.user?.photoURL ?? "";

        await UserAuth.insertUserData(
            email, phone, firstName, lastName, photoUrl);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(loginSuccess)),
        );

        await Future.delayed(const Duration(milliseconds: 1500));

        NavigationService.navigateTo(ParentApp());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(loginSuccess)),
        );

        await Future.delayed(const Duration(milliseconds: 1500));

        NavigationService.navigateTo(ParentApp());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "${welcomeTo} ${appNameShort}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                loginOrRegister,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: secondaryColor),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () => onLoginWithGoogle(context),
                icon: Image.asset(
                  'assets/images/google_logo.png',
                  height: 24,
                  width: 24,
                ),
                label: const Text(continueWithGoogle),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                  backgroundColor: white,
                  foregroundColor: black,
                  textStyle: const TextStyle(fontSize: 16),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: lightGray),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
