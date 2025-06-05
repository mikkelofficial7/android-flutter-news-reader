import 'package:flutter/material.dart';
import 'package:flutter_news_reader/constant/color.dart';

extension StringExtensions on BuildContext {
  void showSnackbar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: secondaryColor,
        content: Text(message),
      ),
    );
  }
}
