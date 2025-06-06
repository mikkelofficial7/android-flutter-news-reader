import 'package:flutter/material.dart';
import 'package:flutter_news_reader/constant/color.dart';
import 'package:flutter_news_reader/constant/language.dart';

class TopView extends StatefulWidget {
  final void Function(bool) onEditTextFocus;

  TopView({required this.onEditTextFocus});

  @override
  TopViewState createState() => TopViewState();
}

class TopViewState extends State<TopView> {
  final FocusNode focusNode = FocusNode();
  bool isFocus = false;

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      setState(() {
        isFocus = focusNode.hasFocus;
        widget.onEditTextFocus(focusNode.hasFocus);
      });
    });
  }

  void onUnFocusEditText() {
    setState(() {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 70,
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            if (isFocus)
              IconButton(
                icon: Icon(Icons.arrow_back_ios, color: secondaryColor),
                onPressed: () {
                  onUnFocusEditText();
                },
              ),
            Expanded(
                child: TextField(
              focusNode: focusNode,
              style: TextStyle(color: black),
              decoration: InputDecoration(
                hintText: searchNews,
                hintStyle: TextStyle(color: secondaryColor),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: secondaryColor,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: secondaryColor), // Normal state
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: secondaryColor), // On focus
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
