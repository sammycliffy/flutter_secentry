import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FlushBarUtils {
  void showErroFlushbar(BuildContext context, String message, String text) {
    Flushbar(
      // There is also a messageText property for when you want to
      // use a Text widget and not just a simple String
      titleText: Text(
        text,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Colors.white,
            fontFamily: "aven"),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
            fontSize: 16.0, color: Colors.white, fontFamily: "aven"),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      // Even the button can be styled to your heart's content
      mainButton: ElevatedButton(
        child: const Text(
          'Got It.',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      duration: const Duration(seconds: 5),
      // Show it with a cascading operator
    ).show(context);
  }
}
