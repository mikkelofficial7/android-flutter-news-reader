import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_reader/bloc/search_page/bloc.dart';
import 'package:flutter_news_reader/bloc/search_page/event_state.dart';
import 'package:flutter_news_reader/constant/color.dart';
import 'package:flutter_news_reader/constant/enum.dart';
import 'package:flutter_news_reader/constant/language.dart';
import 'package:flutter_news_reader/constant/util_constant.dart';
import 'package:flutter_news_reader/extension/context_ext.dart';
import 'package:flutter_news_reader/pages/search/search_first/bottom_view.dart';
import 'package:flutter_news_reader/pages/search/search_second/bottom_view_search.dart';
import 'package:flutter_news_reader/pages/search/top_view.dart';
import 'package:flutter_news_reader/ui_component/toolbar.dart';

class Searchlist extends StatefulWidget {
  @override
  SearchlistState createState() => SearchlistState();
}

class SearchlistState extends State<Searchlist> {
  SearchApiBloc searchApiBloc = SearchApiBloc();
  Timer? debounce;

  void onTypingChanged(String value) {
    if (debounce?.isActive ?? false) debounce!.cancel();

    debounce = Timer(const Duration(milliseconds: 1000), () {
      if (value.isNotEmpty && value.length >= 3) {
        searchApiBloc.add(SearchApiEvent(value));
      } else if (value.isNotEmpty) {
        context.showSnackbar(seachMinimum);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TopView(
              showBackButton: true,
              isFocusable: true,
              onTypingChanged: onTypingChanged,
            ),
            BottomViewSearch(
              searchApiBloc: searchApiBloc,
            ),
          ],
        ),
      ),
    );
  }
}
