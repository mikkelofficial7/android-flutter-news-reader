import 'package:flutter/material.dart';

void showAlertDialog(
  BuildContext context,
  String title,
  String content,
  String buttonPlus,
  String buttonMinus,
  VoidCallback onConfirm,
) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Close dialog
            },
            child: Text(buttonMinus),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Close dialog
              onConfirm(); // Call the confirm action
            },
            child: Text(buttonPlus),
          ),
        ],
      );
    },
  );
}
