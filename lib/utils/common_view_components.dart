import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showAlertDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // Return the AlertDialog widget
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          // Close button
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}
