import 'dart:convert';

import 'package:flutter_news_reader/constant/api_constant.dart';
import 'package:flutter_news_reader/constant/enum.dart';
import 'package:flutter_news_reader/network/model/base_model.dart';
import 'package:flutter_news_reader/network/model/news_model.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  Future<BaseResponse<List<NewsModel>>> getListNews(String query) async {
    try {
      if (query == NewsCategory.hotnews.query) {
        Uri uri = Uri.https(ApiConstant.baseUrl, ApiConstant.pathHeadline,
            {'category': query, 'apiKey': ApiConstant.apiKey});

        final result = await http.get(uri);

        return BaseResponse<List<NewsModel>>.fromJson(
            json.decode(result.body),
            (json) =>
                (json as List).map((e) => NewsModel.fromJson(e)).toList());
      } else {
        Uri uri = Uri.https(ApiConstant.baseUrl, ApiConstant.pathEverything,
            {'q': query, 'apiKey': ApiConstant.apiKey});

        final result = await http.get(uri);

        return BaseResponse<List<NewsModel>>.fromJson(
            json.decode(result.body),
            (json) =>
                (json as List).map((e) => NewsModel.fromJson(e)).toList());
      }
    } catch (error) {
      return BaseResponse(totalResults: 0, status: "empty", articles: []);
    }
  }
}
