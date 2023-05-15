import 'package:flutter/material.dart';

import 'constants.dart';

class ButtonGenre extends StatelessWidget {
  final title;

  // ignore: use_key_in_widget_constructors
  const ButtonGenre({
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 30,
      child: OutlinedButton(
        onPressed: () {},
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 15, fontFamily: 'Quicksand', color: blackPrimaryFont),
        ),
        style: ButtonStyle(
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
