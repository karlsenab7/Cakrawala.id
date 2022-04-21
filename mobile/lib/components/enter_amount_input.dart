import 'package:cakrawala_mobile/components/white_text_field_container.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';

class EnterAmountInput extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const EnterAmountInput({
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WhiteFieldContainer(
      child: TextField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>
          [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
        style: const TextStyle(color: Colors.black),
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle:
            const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700
            ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 5),
        ),
      ),
    );
  }
}