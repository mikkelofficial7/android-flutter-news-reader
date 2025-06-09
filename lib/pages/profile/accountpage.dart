import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_reader/_supabase_firebase/base/firebase_authentication.dart';
import 'package:flutter_news_reader/_supabase_firebase/user_auth.dart';
import 'package:flutter_news_reader/constant/color.dart';
import 'package:flutter_news_reader/constant/language.dart';
import 'package:flutter_news_reader/constant/util_constant.dart';
import 'package:flutter_news_reader/main.dart';
import 'package:flutter_news_reader/network/model/user_model.dart';
import 'package:flutter_news_reader/route/base/base_navigation_service.dart';
import 'package:flutter_news_reader/ui_component/dialog_alert.dart';
import 'package:flutter_news_reader/ui_component/toolbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  Future<UserModel?> getUserLoginData() async {
    UserInfo? GoogleLogInData =
        FirebaseAuthentication().dataLoggedInWithGoogle();

    final response =
        await UserAuth.getDbUserExist(GoogleLogInData?.email ?? "");

    final dataList = response.data as List<dynamic>;

    if (dataList.isNotEmpty) {
      final userJson = dataList[0] as Map<String, dynamic>;
      return UserModel.fromJson(userJson);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getUserLoginData(),
          builder: (context, snapshot) {
            return Column(
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
                        child: CachedNetworkImage(
                          imageUrl: snapshot.data?.bgTheme ?? "",
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/no_image.jpg',
                            fit: BoxFit.cover,
                            height: 250,
                          ),
                          placeholder: (context, url) => Image.asset(
                            'assets/images/no_image.jpg',
                            fit: BoxFit.cover,
                            height: 250,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                        child: CachedNetworkImage(
                          imageUrl: snapshot.data?.photoUrl ?? "",
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/no_image.jpg',
                            fit: BoxFit.cover,
                            width: 60,
                          ),
                          placeholder: (context, url) => Image.asset(
                            'assets/images/no_image.jpg',
                            fit: BoxFit.cover,
                            width: 60,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.person, color: black),
                    const SizedBox(width: 8),
                    Text(
                      "${snapshot.data?.firstName ?? "-"} ${snapshot.data?.lastName ?? ""}",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.email, color: black, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      snapshot.data?.email ?? "",
                      style: TextStyle(
                        fontSize: 16,
                        color: darkGray,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.phone, color: black, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      (snapshot.data?.phone?.isNotEmpty == true
                              ? snapshot.data!.phone
                              : "+00-0000000000") ??
                          "",
                      style: TextStyle(
                        fontSize: 16,
                        color: darkGray,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ElevatedButton.icon(
                    onPressed: () => doSignOut(context),
                    icon: const Icon(
                      Icons.logout,
                      color: white,
                    ),
                    label: const Text(
                      logout,
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: red,
                      foregroundColor: white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 3,
                      shadowColor: red.withOpacity(0.4),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
