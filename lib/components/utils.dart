import 'package:flutter/material.dart';

class Utils {
  Utils._();

  static showAlertDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white)));
      },
    );
  }
}
