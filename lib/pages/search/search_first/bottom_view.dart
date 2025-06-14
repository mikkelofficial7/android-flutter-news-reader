import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_reader/bloc/search_page/bloc.dart';
import 'package:flutter_news_reader/bloc/search_page/event_state.dart';
import 'package:flutter_news_reader/constant/color.dart';
import 'package:flutter_news_reader/constant/enum.dart';
import 'package:flutter_news_reader/constant/language.dart';
import 'package:flutter_news_reader/extension/context_ext.dart';
import 'package:flutter_news_reader/ui_component/empty_ui.dart';
import 'package:flutter_news_reader/ui_component/item_news_grid.dart';
import 'package:flutter_news_reader/ui_component/loading_ui.dart';

class BottomView extends StatefulWidget {
  List<NewsCategory> relatedTopic = [];
  List<SearchApiBloc> listApiBloc = [];

  BottomView({required this.relatedTopic, required this.listApiBloc});

  @override
  BottomViewState createState() => BottomViewState();
}

class BottomViewState extends State<BottomView> {
  bool isLoadFinish = false;

  void onFinishLoad(bool isFinish) {
    setState(() {
      isLoadFinish = isFinish;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.transparent,
        child: Column(
          children: List.generate(
              widget.relatedTopic.length,
              (index) => ItemRelatedNewsList(
                    title: widget.relatedTopic[index].tabCategory,
                    apiBloc: widget.listApiBloc[index],
                  )),
        ),
      ),
    ));
  }
}

class ItemRelatedNewsList extends StatefulWidget {
  final SearchApiBloc apiBloc;
  final String title;

  ItemRelatedNewsList({required this.title, required this.apiBloc});

  @override
  ItemRelatedNewsListState createState() => ItemRelatedNewsListState();
}

class ItemRelatedNewsListState extends State<ItemRelatedNewsList> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => widget.apiBloc,
      child: BlocConsumer<SearchApiBloc, SearchApiState>(
        buildWhen: (context, state) {
          return state is SearchApiSuccess;
        },
        builder: (context, state) {
          if (state is SearchApiSuccess) {
            if (state.listNews?.isEmpty == true) {
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                          color: black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  EmptyUi()
                ],
              );
            } else {
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Text(
                      widget.title,
                      style: TextStyle(
                          color: black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: state.listNews
                                ?.map((news) => CardItemGrid(
                                      news: news,
                                      otherNews: state.listNews,
                                    ))
                                .toList() ??
                            []),
                  ),
                ],
              );
            }
          } else {
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                        color: black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                LoadingPage()
              ],
            );
          }
        },
        listenWhen: (context, state) {
          return state is SearchApiError;
        },
        listener: (context, state) {
          if (state is SearchApiError) {
            context.showSnackbar(dataNotFound);
          }
        },
      ),
    );
  }
}
