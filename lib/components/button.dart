import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final onPress;
  final title;
  final color;
  final textColor;
  final fontsize;
  final width;
  final height;
  final radius;

  const Button(
      {Key? key,
      this.color,
      this.onPress,
      this.title,
      this.textColor,
      this.fontsize,
      this.height = 50.0,
      this.width = 325.0,
      this.radius = 8.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPress,
        child: Text(
          title,
          style: TextStyle(
              fontSize: fontsize, fontFamily: 'Quicksand', color: textColor),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) return color;
              return color; // Use the component's default.
            },
          ),
        ),
      ),
    );
  }
}
