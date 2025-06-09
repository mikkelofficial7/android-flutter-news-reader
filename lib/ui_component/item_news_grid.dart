import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_reader/constant/color.dart';
import 'package:flutter_news_reader/constant/language.dart';
import 'package:flutter_news_reader/constant/util_constant.dart';
import 'package:flutter_news_reader/extension/context_ext.dart';
import 'package:flutter_news_reader/network/model/news_model.dart';
import 'package:flutter_news_reader/pages/detail/detailpage.dart';
import 'package:flutter_news_reader/_supabase_firebase/user_auth.dart';
import 'package:flutter_news_reader/route/base/base_navigation_service.dart';

class CardItemGrid extends StatefulWidget {
  final NewsModel news;
  List<NewsModel>? otherNews = [];

  CardItemGrid({required this.news, this.otherNews});

  @override
  CardItemGridState createState() => CardItemGridState();
}

class CardItemGridState extends State<CardItemGrid> {
  void onClickDetail(NewsModel news, List<NewsModel>? otherNews) {
    setState(() {
      if (news.content.isNotEmpty) {
        UserAuth.checkUserLoginStatus(() {
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
    return Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () => {onClickDetail(widget.news, widget.otherNews)},
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: darkGray, blurRadius: 6)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: CachedNetworkImage(
                  imageUrl: widget.news.urlToImage.toString(),
                  height: 100,
                  width: double.infinity,
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
                ),
              ),
              // Title
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.news.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
