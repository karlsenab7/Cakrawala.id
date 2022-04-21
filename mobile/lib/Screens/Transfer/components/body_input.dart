import 'package:fluttertoast/fluttertoast.dart';
import 'package:cakrawala_mobile/components/bottom_confirm_button.dart';
import "package:flutter/material.dart";

import '../../../components/text_account_template.dart';
import '../../../constants.dart';
import '../choose_transfer_screen.dart';

class BodyInput extends StatefulWidget {
  const BodyInput({Key? key}) : super(key: key);

  @override
  State<BodyInput> createState() => _BodyInput();
}

class _BodyInput extends State<BodyInput> {
  String phoneNumber = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column (
      children: <Widget>[
        // ChooseAccountTable(),
        SizedBox(height: .08 * size.width),
        Container(
          width: .7 * size.width,
          height: 140,
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
                text: "RECEIVER'S PHONE NUMBER",
                align: TextAlign.center,
                weight: FontWeight.bold,
                size: 14,
                color: Color(0xFF565656),
              ),
              SizedBox(
                height: .01 * size.height,
              ),
              Container(
                width: .5 * size.width,
                alignment: Alignment.center,
                child: TextField(
                  autofocus: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: black
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    phoneNumber = value; // TODO
                  },
                ),
              ),
              SizedBox(
                height: .02 * size.height,
              ),
            ],
          ),
        ),
        ButtonConfirmButton(
          text: "Continue",
          press: () {
            if (phoneNumber == "") {
              Fluttertoast.showToast(
                  msg: "Field cannot be empty",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black54,
                  textColor: Colors.white,
                  fontSize: 14.0
              );
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChooseTransferScreen(phone: phoneNumber,)
                  )
              );
            }
          },
        )
      ],
    );
  }
}