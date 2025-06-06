import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_reader/bloc/search_page/bloc.dart';
import 'package:flutter_news_reader/bloc/search_page/event_state.dart';
import 'package:flutter_news_reader/constant/language.dart';
import 'package:flutter_news_reader/extension/context_ext.dart';
import 'package:flutter_news_reader/ui_component/empty_ui.dart';
import 'package:flutter_news_reader/ui_component/item_news_linear.dart';
import 'package:flutter_news_reader/ui_component/loading_search_ui.dart';
import 'package:flutter_news_reader/ui_component/loading_ui.dart';

class BottomViewSearch extends StatefulWidget {
  SearchApiBloc searchApiBloc;

  BottomViewSearch({required this.searchApiBloc});

  @override
  BottomViewSearchState createState() => BottomViewSearchState();
}

class BottomViewSearchState extends State<BottomViewSearch> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocProvider(
        create: (context) => widget.searchApiBloc,
        child: BlocConsumer<SearchApiBloc, SearchApiState>(
          buildWhen: (context, state) {
            return state is SearchApiSuccess;
          },
          builder: (context, state) {
            if (state is SearchApiSuccess) {
              if (state.listNews?.isEmpty == true) {
                return EmptyUi();
              } else {
                return ListView(
                  key: PageStorageKey(BottomViewSearch),
                  children: state.listNews
                          ?.map(
                            (news) => CardItemListNews(
                              newsModel: news,
                              otherNews: state.listNews,
                            ),
                          )
                          .toList() ??
                      [],
                );
              }
            } else if (state is SearchApiLoading) {
              return LoadingPage();
            } else {
              return Container();
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
      ),
    );
  }
}
