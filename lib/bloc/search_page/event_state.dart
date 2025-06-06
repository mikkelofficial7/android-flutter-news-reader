import 'package:equatable/equatable.dart';
import 'package:flutter_news_reader/network/model/news_model.dart';

// Event
class SearchApiEvent extends Equatable {
  final String query;
  const SearchApiEvent(this.query);

  @override
  List<Object> get props => [query];
}

// State
class SearchApiState extends Equatable {
  const SearchApiState();

  @override
  List<Object?> get props => [];
}

// like sealed class for state management
class SearchApiIdle extends SearchApiState {}

class SearchApiLoading extends SearchApiState {}

class SearchApiSuccess extends SearchApiState {
  final List<NewsModel>? listNews;
  const SearchApiSuccess(this.listNews);
}

class SearchApiError extends SearchApiState {
  final List<NewsModel>? listNews;
  const SearchApiError(this.listNews);
}
