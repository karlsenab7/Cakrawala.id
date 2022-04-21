import 'package:cakrawala_mobile/constants.dart';
import "package:flutter/material.dart";

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;
  final double fontSize;
  final double height;
  final double width;
  final bool padding;
  const RoundedButton(
      {Key? key,
      required this.text,
      required this.press,
      this.color = white,
      this.textColor = black,
      this.fontSize = 14,
      this.height = 0,
      this.width = 0,
      this.padding = true
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: width == 0 ? size.width * 0.8 : width,
      height: height == 0 ? 60 : height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
            padding: padding == true ? const EdgeInsets.symmetric(vertical: 20, horizontal: 40) : EdgeInsets.zero,
            color: color,
            onPressed: press,
            child: Text(
              text,
              style: TextStyle(color: textColor, fontSize: fontSize),
            )),
      ),
    );
  }
}
