import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_news_reader/bloc/search_page/bloc.dart';
import 'package:flutter_news_reader/bloc/search_page/event_state.dart';
import 'package:flutter_news_reader/constant/enum.dart';
import 'package:flutter_news_reader/constant/language.dart';
import 'package:flutter_news_reader/constant/util_constant.dart';
import 'package:flutter_news_reader/extension/context_ext.dart';
import 'package:flutter_news_reader/pages/search/bottom_view.dart';
import 'package:flutter_news_reader/pages/search/bottom_view_search.dart';
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

  SearchApiBloc searchApiBloc = SearchApiBloc();

  final List<NewsCategory> relatedTopic = (NewsCategory.values.toList()
        ..shuffle())
      .take(UtilConstant.maxOtherNews)
      .toList();

  bool isFocused = false;
  Timer? debounce;

  @override
  void initState() {
    super.initState();

    List.generate(relatedTopic.length, (index) {
      listApiBloc[index].add(SearchApiEvent(relatedTopic[index].query));
    });
  }

  void onEditTextFocus(bool isFocus) {
    setState(() {
      isFocused = isFocus;
    });
  }

  void onTypingChanged(String value) {
    if (debounce?.isActive ?? false) debounce!.cancel();

    debounce = Timer(const Duration(milliseconds: 2000), () {
      if (value.isNotEmpty && value.length >= 3) {
        if (!searchApiBloc.isClosed) {
          searchApiBloc.add(SearchApiEvent(value));
        }
      } else if (value.isNotEmpty) {
        context.showSnackbar(seachMinimum);
      }
    });
  }

  @override
  void dispose() {
    searchApiBloc.close();
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (searchApiBloc.isClosed) searchApiBloc = SearchApiBloc();

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
            onEditTextFocus: onEditTextFocus,
            onTypingChanged: onTypingChanged,
          ),
          if (isFocused)
            BottomViewSearch(searchApiBloc: searchApiBloc)
          else
            BottomView(
              relatedTopic: relatedTopic,
              listApiBloc: listApiBloc,
            )
        ],
      ),
    );
  }
}
