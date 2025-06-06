import 'package:flutter/material.dart';
import 'package:flutter_news_reader/bloc/search_page/bloc.dart';
import 'package:flutter_news_reader/bloc/search_page/event_state.dart';
import 'package:flutter_news_reader/constant/enum.dart';
import 'package:flutter_news_reader/constant/util_constant.dart';
import 'package:flutter_news_reader/pages/search/search_first/bottom_view.dart';
import 'package:flutter_news_reader/pages/search/search_second/search_list.dart';
import 'package:flutter_news_reader/pages/search/top_view.dart';
import 'package:flutter_news_reader/ui_component/toolbar.dart';

class SearchPage extends StatefulWidget {
  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final List<SearchApiBloc> listApiBloc = [
    SearchApiBloc(),
    SearchApiBloc(),
    SearchApiBloc()
  ];

  final List<NewsCategory> relatedTopic = (NewsCategory.values.toList()
        ..shuffle())
      .take(UtilConstant.maxOtherNews)
      .toList();

  @override
  void initState() {
    super.initState();

    List.generate(relatedTopic.length, (index) {
      listApiBloc[index].add(SearchApiEvent(relatedTopic[index].query));
    });
  }

  void onClick() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Searchlist()),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
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
          TopView(
            isFocusable: false,
            showBackButton: false,
            onClick: onClick,
          ),
          BottomView(
            relatedTopic: relatedTopic,
            listApiBloc: listApiBloc,
          )
        ],
      ),
    );
  }
}
