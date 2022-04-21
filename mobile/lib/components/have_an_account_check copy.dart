import 'package:cakrawala_mobile/constants.dart';
import 'package:flutter/material.dart';

class HaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback press;
  const HaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don't have an Account ? " : "Have an Account ? ",
          style: TextStyle(color: primaryColor),
        ),
        GestureDetector(
          onTap: press,
          child: Text(login ? "Sign Up" : "Sign In",
              style:
                  TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}
