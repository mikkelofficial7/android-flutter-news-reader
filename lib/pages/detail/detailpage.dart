import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_reader/constant/color.dart';
import 'package:flutter_news_reader/constant/language.dart';
import 'package:flutter_news_reader/constant/util_constant.dart';
import 'package:flutter_news_reader/extension/string_ext.dart';
import 'package:flutter_news_reader/network/model/news_model.dart';
import 'package:flutter_news_reader/ui_component/external_link_button.dart';

class DetailPage extends StatefulWidget {
  final NewsModel newsModel; // Pass news data to this page

  const DetailPage({super.key, required this.newsModel});

  @override
  DetailPageState createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final news = widget.newsModel;
    final splitContentWithReadMore = news.content
        .replaceRemainContentToReadMore()
        .split(UtilConstant.readMoreTag);

    return Scaffold(
      appBar: AppBar(
        title: Text(news.title, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              child: CachedNetworkImage(
                imageUrl: widget.newsModel.urlToImage.toString(),
                height: 220,
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "By ${news.author}",
                              style: TextStyle(color: darkGray, fontSize: 12),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              news.publishedAt.convertISO8601_toDateTime(
                                  "dd-MMM-yyyy HH:mm"),
                              style: TextStyle(color: darkGray, fontSize: 12),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  SpannedTextFormatForLink(
                    longText: splitContentWithReadMore[0],
                    linkText: readFromOriginalSource,
                    url: news.url.toString(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
