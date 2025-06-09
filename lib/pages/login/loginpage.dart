import 'package:flutter/material.dart';
import 'package:flutter_news_reader/_supabase_firebase/firebase_authentication.dart';
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(loginSuccess)),
      );

      await Future.delayed(const Duration(milliseconds: 1500));

      NavigationService.navigateTo(ParentApp());
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
