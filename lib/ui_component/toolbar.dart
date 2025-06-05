import 'package:flutter/material.dart';
import 'package:flutter_news_reader/constant/color.dart';
import 'package:flutter_news_reader/constant/language.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const double toolbarHeight = 80; // default is using kToolbarHeight
  bool showIconLogo = false;
  bool showBackArrow = false;

  CustomAppBar(
      {super.key, required this.showIconLogo, required this.showBackArrow});

  @override
  Size get preferredSize => const Size.fromHeight(toolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        toolbarHeight: toolbarHeight,
        backgroundColor: primaryColor,
        leading: showBackArrow
            ? Padding(
                padding: EdgeInsets.only(top: 35.0),
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: white,
                    ),
                  ),
                ),
              )
            : null,
        title: showIconLogo
            ? Padding(
                padding: EdgeInsets.only(top: 35.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    child: Text(
                      appNameShort,
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            : null);
  }
}
