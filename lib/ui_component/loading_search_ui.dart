import 'package:flutter/material.dart';
import 'package:flutter_news_reader/constant/language.dart';

class LoadingSearchUi extends StatelessWidget {
  const LoadingSearchUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Text(
          loading,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
