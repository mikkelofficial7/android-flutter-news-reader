import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_reader/bloc/home_page/event_state.dart';
import 'package:flutter_news_reader/network/repository/repository.dart';

class HomeApiBloc extends Bloc<HomeApiEvent, HomeApiState> {
  HomeApiBloc() : super(HomeApiLoading()) {
    final Repository repository = Repository();

    on<HomeApiEvent>((event, emit) async {
      try {
        final mList = await repository.getListNews(event.query);

        if (mList.articles == null || mList.articles?.isEmpty == true) {
          emit(HomeApiSuccess([]));
        } else {
          emit(HomeApiSuccess(mList.articles));
        }
      } on Exception catch (e) {
        emit(HomeApiError([]));
      }
    });
  }
}
