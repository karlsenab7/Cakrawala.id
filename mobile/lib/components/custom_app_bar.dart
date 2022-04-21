import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget{
  final String text;
  final Color color, textColor;
  final bool center;
  final bool backButton;
  const CustomAppBar(
      {Key? key,
        required this.text,
        this.center = false,
        this.backButton = true,
        this.color = primaryColor,
        this.textColor = Colors.white})
      : super(key: key);

  Widget addBackButton(double width) {
    if (backButton == true) {
      return Padding(
          padding: EdgeInsets.symmetric(horizontal: .05 * width),
          child: const BackButton(),
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size; // Screen height and width

    return AppBar(
      centerTitle: center,
      automaticallyImplyLeading: false,
      // automaticallyImplyLeading: false,
      title:
      Container(
        padding: EdgeInsets.only(left: .065 * size.width),
        child: Text (
          text,
          style: TextStyle(fontWeight: FontWeight.w900,
              color: Colors.white,
              fontSize: 20),
        ),
      ),
      backgroundColor: deepSkyBlue,
      elevation: 0,
      actions: <Widget>[
        addBackButton(size.width)
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}