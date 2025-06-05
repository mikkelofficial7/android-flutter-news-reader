import 'package:flutter/material.dart';
import 'package:flutter_news_reader/constant/color.dart';
import 'package:flutter_news_reader/constant/language.dart';

class TopView extends StatefulWidget {
  @override
  TopViewState createState() => TopViewState();
}

class TopViewState extends State<TopView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 70,
        padding: EdgeInsets.all(10),
        child: TextField(
          style: TextStyle(color: black),
          decoration: InputDecoration(
            hintText: searchNews,
            hintStyle: TextStyle(color: secondaryColor),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: secondaryColor,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: secondaryColor), // Normal state
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: secondaryColor), // On focus
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
