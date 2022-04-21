// ignore_for_file: prefer_const_constructors

import 'package:cakrawala_mobile/Screens/Homepage/homepage_screen.dart';
import 'package:cakrawala_mobile/Screens/Login/components/components.dart';
import 'package:cakrawala_mobile/Screens/Signup/signup_screen.dart';
import 'package:cakrawala_mobile/Screens/Topup/topup_screen.dart';
import 'package:cakrawala_mobile/components/blurry-dialog.dart';
import 'package:cakrawala_mobile/components/have_an_account_check.dart';
import 'package:cakrawala_mobile/components/rounded_button.dart';
import 'package:cakrawala_mobile/components/rounded_input_field.dart';
import 'package:cakrawala_mobile/components/rounded_password_field.dart';
import 'package:cakrawala_mobile/constants.dart';
import 'package:cakrawala_mobile/utils/authentication-api.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;


class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String emailUser = "";
  String passwordUser = "";
  String buttonText = "Login";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width

    return Background(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Login",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Image.asset(
              "assets/images/login.png",
              height: size.height * 0.2,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            RoundedInputField(
              hintText: "Enter Email",
              onChanged: (value) {
                emailUser = value.toString();
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                passwordUser = value.toString();
              },
            ),
            RoundedButton(
              text: buttonText,
              press: () async {
                setState(() {
                  buttonText = "Please Wait...";
                });

                try{
                  var resp = await AuthenticationApi.loginRequest(emailUser, passwordUser);
                  if(resp.status==200){
                    setState((){
                      buttonText = "Login Berhasil!";
                    });
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => Homepage()
                    ));
                  }else{
                    setState((){
                      buttonText = "Login";
                    });
                    _showDialog(context, "Gagal login", "Cek kembali username dan password anda!");
                  }
                }on Exception catch(e){
                  setState((){
                    buttonText = "Login";
                  });
                  _showDialog(context, "Terjadi Error", e.toString());
                }
              },
              color: black,
              textColor: white,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            HaveAnAccountCheck(press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            }),
          ]),
    );
  }

  _showDialog(BuildContext context, title, content){
    BlurryDialog bd = BlurryDialog(title, content, null);

    showDialog(context: context, builder: (BuildContext context){
      return bd;
    });
  }
}
