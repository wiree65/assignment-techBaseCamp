import 'package:flutter/material.dart';

import 'constants.dart';

class HeaderWithButton extends StatelessWidget {
  final headerTitle;
  final buttonTitle;

  // ignore: use_key_in_widget_constructors
  const HeaderWithButton({
    this.headerTitle,
    this.buttonTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Text(
                  headerTitle,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: blackPrimaryFont),
                )),
            SizedBox(
              width: 100,
              height: 30,
              child: OutlinedButton(
                onPressed: () {},
                child: Text(
                  buttonTitle,
                  style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'Quicksand',
                      color: blackPrimaryFont),
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
            )
          ],
        ));
  }
}
