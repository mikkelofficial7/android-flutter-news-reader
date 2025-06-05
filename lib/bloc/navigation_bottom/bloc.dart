import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_reader/bloc/navigation_bottom/event_state.dart';

class NavigationBottomBloc
    extends Bloc<NavigationBottomEvent, NavigationBottomState> {
  NavigationBottomBloc()
      : super(const NavigationBottomState.defaultPosition()) {
    on<NavigationBottomEvent>((event, emit) {
      emit(NavigationBottomState(
          index: event.index)); // set position to navigation bottom state
    });
  }
}
