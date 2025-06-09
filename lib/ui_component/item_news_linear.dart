import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_reader/constant/color.dart';
import 'package:flutter_news_reader/constant/language.dart';
import 'package:flutter_news_reader/constant/util_constant.dart';
import 'package:flutter_news_reader/extension/context_ext.dart';
import 'package:flutter_news_reader/network/model/news_model.dart';
import 'package:flutter_news_reader/extension/string_ext.dart';
import 'package:flutter_news_reader/pages/detail/detailpage.dart';
import 'package:flutter_news_reader/route/navigation_db_validation.dart';
import 'package:flutter_news_reader/route/base/base_navigation_service.dart';

class CardItemListNews extends StatefulWidget {
  final NewsModel newsModel;
  List<NewsModel>? otherNews = [];

  CardItemListNews({required this.newsModel, this.otherNews});

  @override
  CardItemListNewsState createState() => CardItemListNewsState();
}

class CardItemListNewsState extends State<CardItemListNews> {
  void onClickDetail(NewsModel news, List<NewsModel>? otherNews) {
    setState(() {
      if (news.content.isNotEmpty) {
        UserRoute.checkUserLoginStatus(() {
          NavigationService.navigateTo(DetailPage(
            newsModel: news,
            listRelatedNews: (otherNews!..shuffle())
                .take(UtilConstant.maxOtherNews)
                .toList(),
          ));
        });
      } else {
        context.showSnackbar(cannotOpenDetailPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClickDetail(widget.newsModel, widget.otherNews);
      },
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Container(
          decoration: BoxDecoration(
            color: lightGray,
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
          child: Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                topLeft: Radius.circular(12),
              ),
              child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 100, maxHeight: 200),
                  child: CachedNetworkImage(
                    imageUrl: widget.newsModel.urlToImage.toString(),
                    width: 100,
                    height: 170,
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/no_image.jpg',
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    placeholder: (context, url) => Image.asset(
                      'assets/images/no_image.jpg',
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.newsModel.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(widget.newsModel.description,
                        maxLines: 3, overflow: TextOverflow.ellipsis),
                    SizedBox(height: 4),
                    Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          "${publishedAt} ${widget.newsModel.publishedAt.convertISO8601_toDateTime("dd-MM-yyyy")}",
                          maxLines: 1,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
