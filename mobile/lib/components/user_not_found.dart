import 'package:cakrawala_mobile/components/text_account_template.dart';
import "package:flutter/material.dart";

import '../constants.dart';

class UserNotFound extends StatelessWidget {
  const UserNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width
    return Center(
      child: Container(
        width: .7 * size.width,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: .02 * size.height,
            ),
            const TextAccountTemplate(
              text: "User Not Found",
              align: TextAlign.center,
              weight: FontWeight.bold,
              size: 14,
              color: Color(0xFF565656),
            ),
            SizedBox(
              height: .01 * size.height,
            ),
            SizedBox(
              height: .02 * size.height,
            ),
          ],
        ),
      ),
    );
  }
}
