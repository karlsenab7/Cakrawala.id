import 'dart:async';

import 'package:cakrawala_mobile/Screens/Login/login_screen.dart';
import 'package:cakrawala_mobile/Screens/Signup/components/background.dart';
import 'package:cakrawala_mobile/components/have_an_account_check.dart';
import 'package:cakrawala_mobile/components/rounded_button.dart';
import 'package:cakrawala_mobile/components/rounded_input_field.dart';
import 'package:cakrawala_mobile/components/rounded_password_field.dart';
import 'package:cakrawala_mobile/constants.dart';
import 'package:cakrawala_mobile/utils/authentication-api.dart';
import 'package:flutter/material.dart';

import '../../../components/blurry-dialog.dart';
import '../../Topup/topup_screen.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String email = "";
  String name = "";
  String phone = "";
  String password = "";
  String buttonText = "Register";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size; // Screen height and width

    return Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Register",
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Image.asset(
              "assets/images/signup.png",
              height: size.height * 0.15,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoundedInputField(hintText: "Email", onChanged: (value) {
              email = value.toString();
            }),
            RoundedPasswordField(onChanged: (value) {
              password = value.toString();
            }),
            RoundedInputField(
                hintText: "Full Name", onChanged: (value) {
              name = value.toString();
            }, icon: Icons.person),
            RoundedInputField(
                hintText: "Phone Number",
                onChanged: (value) {
                  phone = value.toString();
                },
                icon: Icons.local_phone_outlined),
            RoundedButton(
              text: buttonText,
              press: () async {
                setState(() {
                  buttonText = "Please Wait...";
                });
                try {
                  var resp = await AuthenticationApi.registerRequest(
                      email, password, name, phone);
                  if(resp.status==200){
                    _showDialog(context, "Berhasil Mendaftar", "Silahkan login dengan akun yang anda daftarkan tadi ya!",(){
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => const LoginScreen()
                      ));
                    });

                  }else{
                    _showDialog(context, "Gagal mendaftar", resp.message, null);
                  }
                } on Exception catch (e) {
                  _showDialog(context, "Terjadi Error", e.toString(), null);
                }
                setState(() {
                  buttonText = "Register";
                });
              },
              textColor: white,
              color: black,
            ),
            HaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginScreen();
                    },
                  ),
                );
              },
            )
          ],
        ));
  }

  _showDialog(BuildContext context, title, content, callback) {
    BlurryDialog bd = BlurryDialog(title, content, callback);

    showDialog(context: context, builder: (BuildContext context) {
      return bd;
    });
  }
}
