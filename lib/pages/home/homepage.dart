import 'package:flutter/material.dart';
import 'package:flutter_news_reader/constant/language.dart';
import 'package:flutter_news_reader/pages/home/hot_news_tab.dart';
import 'package:flutter_news_reader/ui_component/toolbar.dart';

class HomePage extends StatelessWidget {
  final List<Widget> listTabButton = [
    Tab(icon: Icon(Icons.whatshot), text: newTab),
    Tab(icon: Icon(Icons.monetization_on), text: financeTab),
    Tab(icon: Icon(Icons.gavel), text: politicTab),
    Tab(icon: Icon(Icons.school_sharp), text: educationTab),
    Tab(icon: Icon(Icons.phone_android), text: technologyTab),
    Tab(icon: Icon(Icons.vaccines), text: healthTab),
    Tab(icon: Icon(Icons.sports_football), text: sportTab),
  ];

  final List<Widget> listTabBarView = [
    HotNewsTab(),
    HotNewsTab(),
    HotNewsTab(),
    HotNewsTab(),
    HotNewsTab(),
    HotNewsTab(),
    HotNewsTab()
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: listTabButton.length,
      child: Column(
        children: [
          CustomAppBar(
            showIconLogo: true,
            showBackArrow: false,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                isScrollable: true,
                tabs: listTabButton,
              )),
          Expanded(
            child: TabBarView(
              children: listTabBarView,
            ),
          ),
        ],
      ),
    );
  }
}
