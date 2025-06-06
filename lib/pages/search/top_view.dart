import 'package:flutter/material.dart';
import 'package:flutter_news_reader/constant/color.dart';
import 'package:flutter_news_reader/constant/language.dart';
import 'package:flutter_news_reader/extension/context_ext.dart';

class TopView extends StatefulWidget {
  final bool showBackButton;
  final bool isFocusable;
  void Function()? onClick;
  void Function(String)? onTypingChanged;

  TopView(
      {required this.showBackButton,
      required this.isFocusable,
      this.onClick,
      this.onTypingChanged});

  @override
  TopViewState createState() => TopViewState();
}

class TopViewState extends State<TopView> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController controller = TextEditingController();

  final List<String> items = [
    "Trump's regulation",
    "market tariffs",
    "Era of AI",
  ];

  @override
  void initState() {
    super.initState();

    if (widget.isFocusable) {
      // Request focus after the first frame is built
      WidgetsBinding.instance.addPostFrameCallback((_) {
        focusNode.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  // for safety nullable function unit
  void onTypingChanged(String value) {
    widget.onTypingChanged?.call(value);
  }

  // for safety nullable function unit
  void onClick() {
    widget.onClick?.call();
  }

  void onItemClick(String text) {
    setState(() {
      controller.text = text;
      onTypingChanged(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                if (widget.showBackButton)
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: secondaryColor),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                Expanded(
                  child: TextField(
                    focusNode: focusNode,
                    readOnly: !widget.showBackButton,
                    controller: controller,
                    onTap: () async {
                      onClick();
                    },
                    onChanged: (value) {
                      onTypingChanged(value);
                    },
                    style: TextStyle(color: black),
                    decoration: InputDecoration(
                      hintText: searchNews,
                      hintStyle: TextStyle(color: secondaryColor),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: secondaryColor,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: secondaryColor), // Normal state
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: secondaryColor), // On focus
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                )
              ],
            ),
            if (widget.showBackButton)
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 8),
                child: Row(
                  children: [
                    Text(
                      mostSearch,
                      style: TextStyle(color: black, fontSize: 10),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Wrap(
                      spacing: 5,
                      runSpacing: 2,
                      children: items
                          .map((text) => GestureDetector(
                                onTap: () {
                                  onItemClick(text);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: lightGray,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    text,
                                    style:
                                        TextStyle(color: black, fontSize: 10),
                                  ),
                                ),
                              ))
                          .toList(),
                    ))
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
