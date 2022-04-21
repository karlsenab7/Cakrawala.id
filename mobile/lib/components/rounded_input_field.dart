import 'package:cakrawala_mobile/components/text_field_container.dart';
import 'package:cakrawala_mobile/constants.dart';
import "package:flutter/material.dart";

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.mail_outline,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        style: TextStyle(color: black),
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: black,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: black),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
