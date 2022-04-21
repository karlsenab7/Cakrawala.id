import 'package:cakrawala_mobile/components/text_account_template.dart';
import "package:flutter/material.dart";

class TextName extends StatelessWidget {
  final String text;
  const TextName({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width
    return Container(
      width: 0.18 * size.width,
      child: TextAccountTemplate(
        text: text,
        align: TextAlign.left,
        weight: FontWeight.w800,
        size: 16),
    );
  }
}

class TextPhone extends StatelessWidget {
  final String text;
  const TextPhone({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width
    return Container(
      width: 0.27 * size.width,
      child: TextAccountTemplate(
          text: text,
          align: TextAlign.left,
          weight: FontWeight.w700,
          size: 13),
    );
  }
}

class TextExp extends StatelessWidget {
  final String text;
  const TextExp({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextAccountTemplate(
          text: text,
          align: TextAlign.right,
          weight: FontWeight.w700,
          size: 14),
    );
  }
}
