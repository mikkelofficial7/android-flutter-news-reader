import 'dart:core';
import 'package:flutter_news_reader/constant/util_constant.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';

extension Iso8601DateParser on String {
  String convertISO8601_toDateTime(String format) {
    try {
      if (isEmpty) return '0000-00-00';
      String normalized = trim();
      DateTime? dateTime = DateTime.tryParse(normalized);
      if (dateTime == null) {
        return '0000-00-00';
      }

      return DateFormat(format).format(dateTime.toLocal());
    } catch (e) {
      return '0000-00-00';
    }
  }
}

extension StringExtensions on String {
  String replaceRemainContentToReadMore() {
    if (isEmpty) return "";
    return replaceAll(RegExp(r'\[\+\d+\s+chars\]'), UtilConstant.readMoreTag)
        .trim();
  }

  String parseHtmlString() {
    final document = parse(this);
    final String parsedString = document.body?.text ?? "";
    return parsedString;
  }
}
