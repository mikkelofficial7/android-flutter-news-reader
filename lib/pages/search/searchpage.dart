import 'package:flutter/cupertino.dart';
import 'package:flutter_news_reader/pages/search/bottom_view.dart';
import 'package:flutter_news_reader/pages/search/top_view.dart';
import 'package:flutter_news_reader/ui_component/toolbar.dart';

class SearchPage extends StatelessWidget {
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
          TopView(),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(10),
            child: BottomView(),
          ))
        ],
      ),
    );
  }
}
