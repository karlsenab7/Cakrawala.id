import 'package:cakrawala_mobile/components/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ButtonConfirmButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;
  const ButtonConfirmButton(
      {Key? key,
      required this.text,
      required this.press,
      this.color = primaryColor,
      this.textColor = white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width

    return Expanded(
        child: Align(
      alignment: FractionalOffset.bottomCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.02 * size.height),
        child: RoundedButton(
          text: text,
          press: press,
          color: black,
          textColor: white,
        ),
      ),
    ));
  }
}