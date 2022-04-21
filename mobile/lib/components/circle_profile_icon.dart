import 'package:cakrawala_mobile/constants.dart';
import "package:flutter/material.dart";

class CircleIcon extends StatelessWidget {
  final String textName;
  final VoidCallback press;
  final Color color, textColor;

  const CircleIcon(
      {Key? key,
      required this.textName,
      required this.press,
      this.color = primaryColor,
      this.textColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width

    return Column(children: <Widget>[
      Container(
        alignment: Alignment.center,
        width: size.height * 0.1,
        height: size.height * 0.1,
        decoration: new BoxDecoration(
          color: slateGray,
          shape: BoxShape.circle,
        ),
        child: Text(
          textName[0],
          style: TextStyle(
              color: textColor, fontWeight: FontWeight.w900, fontSize: 24),
        ),
      ),
      Container(
        alignment: Alignment.center,
        width: size.width,
        height: 20,
        child: Text(
          textName,
          style: TextStyle(
              color: textColor, fontWeight: FontWeight.w700, fontSize: 16),
        ),
      )
    ]);
  }
}