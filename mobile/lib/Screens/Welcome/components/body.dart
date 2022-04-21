import 'package:cakrawala_mobile/Screens/Login/login_screen.dart';
import 'package:cakrawala_mobile/Screens/Signup/signup_screen.dart';
import 'package:cakrawala_mobile/Screens/Welcome/components/background.dart';
import 'package:cakrawala_mobile/components/rounded_button.dart';
import 'package:cakrawala_mobile/constants.dart';
import "package:flutter/material.dart";
// import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width

    return Background(
        child: SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            Image.asset("assets/images/cakrawala.png"),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "LOGIN",
              color: white,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: black,
              textColor: Colors.white,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            )
          ]),
    ));
  }
}
