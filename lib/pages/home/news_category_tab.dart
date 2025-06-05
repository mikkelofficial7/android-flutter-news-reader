import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_reader/bloc/home_page/bloc.dart';
import 'package:flutter_news_reader/bloc/home_page/event_state.dart';
import 'package:flutter_news_reader/constant/enum.dart';
import 'package:flutter_news_reader/constant/language.dart';
import 'package:flutter_news_reader/extension/context_ext.dart';
import 'package:flutter_news_reader/ui_component/empty_ui.dart';
import 'package:flutter_news_reader/ui_component/item_news.dart';
import 'package:flutter_news_reader/ui_component/loading_ui.dart';

class NewsCategoryTab extends StatefulWidget {
  final NewsCategory currentTab;
  final Key currentTabState;

  NewsCategoryTab({required this.currentTabState, required this.currentTab})
      : super(key: currentTabState);

  @override
  NewsCategoryState createState() => NewsCategoryState();
}

class NewsCategoryState extends State<NewsCategoryTab>
    with AutomaticKeepAliveClientMixin {
  final HomeApiBloc apiBloc = HomeApiBloc();

  @override
  void initState() {
    super.initState();

    // access variable from widget to state-widget
    apiBloc.add(HomeApiEvent(widget.currentTab.query));
  }

  // To avoid the tab being recreated every time it's selected (add also 'AutomaticKeepAliveClientMixin')
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => apiBloc,
      child:
          BlocConsumer<HomeApiBloc, HomeApiState>(buildWhen: (context, state) {
        return state is HomeApiSuccess;
      }, builder: (context, state) {
        if (state is HomeApiSuccess) {
          if (state.listNews?.isEmpty == true) {
            return EmptyUi();
          } else {
            return ListView(
              children: state.listNews
                      ?.map((news) => CardItemListNews(
                            newsModel: news,
                          ))
                      .toList() ??
                  [],
            );
          }
        } else {
          return LoadingPage();
        }
      }, listenWhen: (context, state) {
        return state is HomeApiError;
      }, listener: (context, state) {
        if (state is HomeApiError) {
          context.showSnackbar(dataNotFound);
        }
      }),
    );
  }
}
