import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_reader/constant/color.dart';
import 'package:flutter_news_reader/constant/language.dart';
import 'package:flutter_news_reader/extension/context_ext.dart';
import 'package:flutter_news_reader/extension/string_ext.dart';
import 'package:url_launcher/url_launcher.dart';

class SpannedTextFormatForLink extends StatelessWidget {
  final String longText;
  final String linkText;
  final String url;

  SpannedTextFormatForLink(
      {required this.longText, required this.linkText, required this.url});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
      style: TextStyle(color: black, fontSize: 16),
      children: [
        TextSpan(text: longText.parseHtmlString()),
        TextSpan(
          text: linkText,
          style: TextStyle(
              color: secondaryColor, decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              final uri = Uri.parse(url);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              } else {
                context.showSnackbar(urlBroken);
              }
            },
        ),
      ],
    ));
  }
}
