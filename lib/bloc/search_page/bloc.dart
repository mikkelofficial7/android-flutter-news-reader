import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_reader/bloc/search_page/event_state.dart';
import 'package:flutter_news_reader/network/repository/repository.dart';

class SearchApiBloc extends Bloc<SearchApiEvent, SearchApiState> {
  SearchApiBloc() : super(SearchApiLoading()) {
    final Repository repository = Repository();

    on<SearchApiEvent>((event, emit) async {
      try {
        final mList = await repository.getListNews(event.query);

        if (mList.articles == null || mList.articles?.isEmpty == true) {
          emit(SearchApiSuccess([]));
        } else {
          emit(SearchApiSuccess(mList.articles));
        }
      } on Exception catch (e) {
        emit(SearchApiError([]));
      }
    });
  }
}
