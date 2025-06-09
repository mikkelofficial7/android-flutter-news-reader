import 'package:flutter/material.dart';
import 'package:flutter_news_reader/constant/color.dart';
import 'package:flutter_news_reader/constant/enum.dart';
import 'package:flutter_news_reader/pages/home/news_category_tab.dart';
import 'package:flutter_news_reader/ui_component/toolbar.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<Widget> listTabButton = [
    Tab(icon: Icon(Icons.whatshot), text: NewsCategory.hotnews.tabCategory),
    Tab(
        icon: Icon(Icons.monetization_on),
        text: NewsCategory.finance.tabCategory),
    Tab(icon: Icon(Icons.gavel), text: NewsCategory.politic.tabCategory),
    Tab(
        icon: Icon(Icons.school_sharp),
        text: NewsCategory.education.tabCategory),
    Tab(
        icon: Icon(Icons.phone_android),
        text: NewsCategory.technology.tabCategory),
    Tab(icon: Icon(Icons.vaccines), text: NewsCategory.health.tabCategory),
    Tab(
        icon: Icon(Icons.sports_football),
        text: NewsCategory.sports.tabCategory),
  ];

  final List<Widget> listTabBarView = [
    NewsCategoryTab(
        currentTabState: PageStorageKey(NewsCategory.hotnews.name),
        currentTab: NewsCategory.hotnews),
    NewsCategoryTab(
        currentTabState: PageStorageKey(NewsCategory.finance.name),
        currentTab: NewsCategory.finance),
    NewsCategoryTab(
        currentTabState: PageStorageKey(NewsCategory.politic.name),
        currentTab: NewsCategory.politic),
    NewsCategoryTab(
        currentTabState: PageStorageKey(NewsCategory.education.name),
        currentTab: NewsCategory.education),
    NewsCategoryTab(
        currentTabState: PageStorageKey(NewsCategory.technology.name),
        currentTab: NewsCategory.technology),
    NewsCategoryTab(
        currentTabState: PageStorageKey(NewsCategory.health.name),
        currentTab: NewsCategory.health),
    NewsCategoryTab(
        currentTabState: PageStorageKey(NewsCategory.sports.name),
        currentTab: NewsCategory.sports)
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
                labelColor: Colors.blue, // Active tab color
                unselectedLabelColor: black,
                indicatorColor: Colors.transparent,
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
