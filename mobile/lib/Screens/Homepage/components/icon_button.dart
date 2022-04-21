import 'package:cakrawala_mobile/constants.dart';
import "package:flutter/material.dart";

class CustomIconButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;
  final IconData icon_;
  const CustomIconButton(
      {Key? key,
      required this.text,
      required this.press,
      this.color = primaryColor,
      this.textColor = Colors.white,
      required this.icon_})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width

    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 5),
      width: size.width * 0.26,
      decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(50)),
      child: TextButton.icon(
        icon: Icon(icon_,color: white),
        label: Text(
          text,
          style: TextStyle(color: textColor, fontFamily: 'Mulish', fontSize: 15, fontWeight: FontWeight.w700)),
        
        onPressed: press,
      ),
    );
  }
}
