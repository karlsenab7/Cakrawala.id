// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'dart:developer';

import 'package:cakrawala_mobile/Screens/Homepage/homepage_screen.dart';
import 'package:cakrawala_mobile/components/bottom_confirm_button.dart';
// import 'package:cakrawala_mobile/components/choose_account_table2.dart';
import 'package:cakrawala_mobile/components/circle_profile_icon.dart';
import 'package:cakrawala_mobile/components/enter_amount_input.dart';
import 'package:cakrawala_mobile/components/user_profile_container.dart';
import 'package:cakrawala_mobile/components/white_text_field_container.dart';
import 'package:cakrawala_mobile/utils/transfer-api.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';

import '../../../components/blurry-dialog.dart';
import '../../../components/choose_account_table1.dart';
import '../../../constants.dart';

class Body extends StatefulWidget {
  final User choosenUser;
  const Body({Key? key, required this.choosenUser}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int amount = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width

    return Column (
        children: <Widget>[
          SizedBox(
            height: size.height * 0.05,
          ),
          CircleIcon(
            textName: widget.choosenUser.name,
            press: () {},
            textColor: Colors.white,
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          WhiteFieldContainer(
            child: UserProfileContainer(
              name: widget.choosenUser.name,
              phone: widget.choosenUser.phone,
              email: widget.choosenUser.email
            )
          ),
          SizedBox(
            height: size.height * 0.005,
          ),
          EnterAmountInput(
            hintText: "Enter the amount to transfers",
            onChanged: (value) {amount = value == "" ? 0 : int.parse(value);},
          ),
          ButtonConfirmButton(
            text: "Confirm Transfer",
            press: (){
              if (amount == 0) {
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
              }
              // pop up dialog
              showConfirmDialog(context, () async {
                var resp = await TransferAPI.transfer(widget.choosenUser.id, amount);
                if(resp.data) {
                  _showDialog(context, "Berhasil", "Transfer sebesar $amount ke ${widget.choosenUser.name} telah berhasil", (){
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) => const Homepage()),
                        ModalRoute.withName('/') // Replace this with your root screen's route name (usually '/')
                    );
                  });
                  // reset current user
                  currentUser = User(-1, "Unknown", "-1", -1, "Unknown");
                } else {
                  log('resp message: ${resp.message}');
                  var msg = json.decode(resp.message) as Map<String, dynamic>;
                  var temp = msg['message'];
                  _showDialog(context, "Gagal melakukan transfer", temp, null);
                }
              });
            }),
        ],
    );
  }

  _showDialog(BuildContext context, title, content, callback) {
    BlurryDialog bd = BlurryDialog(title, content, callback);

    showDialog(context: context, builder: (BuildContext context) {
      return bd;
    });
  }

  showConfirmDialog(BuildContext context, VoidCallback pressContinue) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: const Text("Cancel",
        style: TextStyle(
            color: black,
            fontWeight: FontWeight.w600
        ),
      ),
      onPressed:  () => Navigator.pop(context),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(color: black, width: 0.8)
              )
          )
      ),
    );
    Widget continueButton = ElevatedButton(
        child: const Text(
            "Continue",
            style: TextStyle(
                color: white,
                fontWeight: FontWeight.w600
            )
        ),
        onPressed: pressContinue,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(black),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(color: black),
                )
            )
        )
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      title: const Text("Transfer Confirmation"),
      content: const Text("Are you sure you want to continue?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
