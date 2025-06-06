import 'package:flutter/cupertino.dart';
import 'package:flutter_news_reader/pages/search/bottom_view.dart';
import 'package:flutter_news_reader/pages/search/bottom_view_search.dart';
import 'package:flutter_news_reader/pages/search/top_view.dart';
import 'package:flutter_news_reader/ui_component/toolbar.dart';

class SearchPage extends StatefulWidget {
  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  bool isFocused = false;

  void onEditTextFocus(bool isFocus) {
    setState(() {
      isFocused = isFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          CustomAppBar(
            showBackArrow: false,
            showIconLogo: true,
          ),
          TopView(onEditTextFocus: onEditTextFocus),
          if (isFocused) BottomViewSearch() else BottomView()
        ],
      ),
    );
  }
}
