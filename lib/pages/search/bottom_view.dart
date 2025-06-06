import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_reader/bloc/search_page/bloc.dart';
import 'package:flutter_news_reader/bloc/search_page/event_state.dart';
import 'package:flutter_news_reader/constant/color.dart';
import 'package:flutter_news_reader/constant/enum.dart';
import 'package:flutter_news_reader/constant/language.dart';
import 'package:flutter_news_reader/constant/util_constant.dart';
import 'package:flutter_news_reader/extension/context_ext.dart';
import 'package:flutter_news_reader/ui_component/empty_ui.dart';
import 'package:flutter_news_reader/ui_component/item_news_grid.dart';
import 'package:flutter_news_reader/ui_component/loading_ui.dart';

class BottomView extends StatefulWidget {
  @override
  BottomViewState createState() => BottomViewState();
}

class BottomViewState extends State<BottomView> {
  final List<SearchApiBloc> listApiBloc = [
    SearchApiBloc(),
    SearchApiBloc(),
    SearchApiBloc()
  ];

  final List<NewsCategory> relatedTopic = (NewsCategory.values.toList()
        ..shuffle())
      .take(UtilConstant.maxOtherNews)
      .toList();

  bool isLoadFinish = false;

  void onFinishLoad(bool isFinish) {
    setState(() {
      isLoadFinish = isFinish;
    });
  }

  @override
  void initState() {
    super.initState();

    List.generate(relatedTopic.length, (index) {
      listApiBloc[index].add(SearchApiEvent(relatedTopic[index].query));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: List.generate(
              relatedTopic.length,
              (index) => ItemRelatedNewsList(
                    title: relatedTopic[index].tabCategory,
                    apiBloc: listApiBloc[index],
                  )),
        ),
      ),
    );
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
        }, builder: (context, state) {
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
                  )
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
        }, listenWhen: (context, state) {
          return state is SearchApiError;
        }, listener: (context, state) {
          if (state is SearchApiError) {
            context.showSnackbar(dataNotFound);
          }
        }));
  }
}
