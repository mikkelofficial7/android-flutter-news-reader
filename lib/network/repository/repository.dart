import 'package:flutter_news_reader/network/api/api.dart';
import 'package:flutter_news_reader/network/model/base_model.dart';
import 'package:flutter_news_reader/network/model/news_model.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<BaseResponse<List<NewsModel>>> getListNews(String query) {
    return apiProvider.getListNews(query);
  }
}
