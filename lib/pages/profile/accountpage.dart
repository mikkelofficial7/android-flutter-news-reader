import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_reader/_supabase_firebase/firebase_authentication.dart';
import 'package:flutter_news_reader/constant/color.dart';
import 'package:flutter_news_reader/constant/language.dart';
import 'package:flutter_news_reader/constant/util_constant.dart';
import 'package:flutter_news_reader/main.dart';
import 'package:flutter_news_reader/route/base/base_navigation_service.dart';
import 'package:flutter_news_reader/ui_component/dialog_alert.dart';
import 'package:flutter_news_reader/ui_component/toolbar.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);

  Future<void> doSignOut(BuildContext context) async {
    showAlertDialog(context, logout, askSignOut, yes, no, () async {
      await FirebaseAuthentication().doSignOutByGoogle();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(signOutSuccess)),
      );

      await Future.delayed(const Duration(milliseconds: 1500));

      NavigationService.navigateTo(ParentApp());
    });
  }

  static UserInfo? loggedInData =
      FirebaseAuthentication().dataLoggedInWithGoogle();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(showIconLogo: true, showBackArrow: false),
          Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: Image.network(
                    UtilConstant.backgroundUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(60)),
                  child: CachedNetworkImage(
                    imageUrl: loggedInData?.photoURL.toString() ?? "",
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/no_image.jpg',
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    placeholder: (context, url) => Image.asset(
                      'assets/images/no_image.jpg',
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            loggedInData?.displayName ?? "-",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            loggedInData?.email ?? "-",
            style: TextStyle(
              fontSize: 16,
              color: darkGray,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => doSignOut(context),
            icon: const Icon(
              Icons.logout,
              color: white,
            ),
            label: const Text(logout),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              backgroundColor: red,
              foregroundColor: white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
