import 'dart:developer';

import 'package:cakrawala_mobile/Screens/Homepage/homepage_screen.dart';
import 'package:cakrawala_mobile/components/bottom_confirm_button.dart';
import 'package:cakrawala_mobile/components/circle_profile_icon.dart';
import 'package:cakrawala_mobile/components/enter_amount_input.dart';
import 'package:cakrawala_mobile/components/rounded_button.dart';
import 'package:cakrawala_mobile/components/user_info_text.dart';
import 'package:cakrawala_mobile/components/user_profile_container.dart';
import 'package:cakrawala_mobile/components/white_text_field_container.dart';
import 'package:cakrawala_mobile/constants.dart';
import 'package:cakrawala_mobile/utils/topup-api.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';

import '../../../components/blurry-dialog.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.userInfo}) : super(key: key);
  final Map<String, dynamic> userInfo;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int topUpAmount = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width
    const Color blue = Color.fromRGBO(0, 162, 237, 1);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: deepSkyBlue,
      appBar: AppBar(
        titleSpacing: 40,
        title: const Text(
          'Top Up My Account',
          style: TextStyle(
              fontWeight: FontWeight.w900, color: Colors.white, fontSize: 20),
        ),
        backgroundColor: deepSkyBlue,
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.05 * size.width),
            child: BackButton(
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: size.height * 0.05,
          ),
          CircleIcon(
            textName: widget.userInfo["Name"],
            press: () {},
            textColor: Colors.white,
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          WhiteFieldContainer(
              child: UserProfileContainer(
                  name: widget.userInfo["Name"],
                  phone: widget.userInfo["Phone"],
                  email: widget.userInfo["email"])),
          SizedBox(
            height: size.height * 0.005,
          ),
          EnterAmountInput(
            hintText: "Enter the amount to top up",
            onChanged: (value) {
              topUpAmount = value == "" ? 0 : int.parse(value);
            },
          ),
          ButtonConfirmButton(text: "Confirm Top Up", press: () async {
            if(topUpAmount<=0) {
              if (topUpAmount == 0) {
                Fluttertoast.showToast(
                    msg: "Field amount cannot be empty",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    fontSize: 14.0
                );
                return;
              } else {
                Fluttertoast.showToast(
                    msg: "Amount must be positive value",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    fontSize: 14.0
                );
                return;
              }
            }
            var resp = await TopUpAPI.topUp(topUpAmount);
            if(resp.data){
              _showDialog(context, "Berhasil", "Request top-up sebesar $topUpAmount telah berhasil, silahkan tunggu ACC dari admin supaya saldo masuk ke akun anda", (){
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => const Homepage()),
                    ModalRoute.withName('/') // Replace this with your root screen's route name (usually '/')
                );
              });
            }else{
              _showDialog(context, "Gagal melakukan top-up", resp.message, null);
            }
          })
        ],
      ),
    );
  }

  _showDialog(BuildContext context, title, content, callback) {
    BlurryDialog bd = BlurryDialog(title, content, callback);

    showDialog(context: context, builder: (BuildContext context) {
      return bd;
    });
  }
}
