import 'package:equatable/equatable.dart';
import 'package:flutter_news_reader/network/model/news_model.dart';

// Event
class HomeApiEvent extends Equatable {
  final String query;
  const HomeApiEvent(this.query);

  @override
  List<Object> get props => [query];
}

// State
class HomeApiState extends Equatable {
  const HomeApiState();

  @override
  List<Object?> get props => [];
}

// like sealed class for state management
class HomeApiLoading extends HomeApiState {}

class HomeApiSuccess extends HomeApiState {
  final List<NewsModel>? listNews;
  const HomeApiSuccess(this.listNews);
}

class HomeApiError extends HomeApiState {
  final List<NewsModel>? listNews;
  const HomeApiError(this.listNews);
}
