import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_reader/constant/color.dart';
import 'package:flutter_news_reader/constant/language.dart';
import 'package:flutter_news_reader/network/model/news_model.dart';
import 'package:intl/intl.dart';

class CardItemListNews extends StatelessWidget {
  final NewsModel newsModel;

  const CardItemListNews({required this.newsModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                constraints: BoxConstraints(maxWidth: 100),
                child: CachedNetworkImage(
                  imageUrl: newsModel.urlToImage.toString(),
                  width: 100,
                  height: 170,
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/no_image.jpg',
                    height: 170,
                    fit: BoxFit.cover,
                  ),
                  placeholder: (context, url) => Image.asset(
                    'assets/images/no_image.jpg',
                    height: 170,
                    fit: BoxFit.cover,
                  ),
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  newsModel.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(newsModel.content,
                    maxLines: 3, overflow: TextOverflow.ellipsis),
                SizedBox(height: 4),
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      "${publishedAt} ${newsModel.publishedAt.convertISO8601_toDateTime()}",
                      maxLines: 1,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 12, // size in logical pixels
                      ),
                    )),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

extension on String {
  String convertISO8601_toDateTime() {
    try {
      if (isEmpty) return '0000-00-00';
      String normalized = trim();
      DateTime? dateTime = DateTime.tryParse(normalized);
      if (dateTime == null) {
        return '0000-00-00';
      }

      return DateFormat('dd-MM-yyyy').format(dateTime.toLocal());
    } catch (e) {
      return '0000-00-00';
    }
  }
}
