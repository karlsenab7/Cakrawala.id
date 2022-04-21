import 'package:flutter/material.dart';

class UserInfoText extends StatelessWidget {
  final String attribute;
  final String value;
  const UserInfoText({
    Key? key,
    required this.attribute,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          attribute,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        Text (
          value,
          style:
          const TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black
          ),
        )
      ],
    );
  }
}
