import 'package:flutter/material.dart';

class WhiteFieldContainer extends StatelessWidget {
  final Widget child;
  final double round;
  const WhiteFieldContainer({
    Key? key,
    required this.child,
    this.round = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      width: size.width * 0.9,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(round)),
      child: child,
    );
  }
}
