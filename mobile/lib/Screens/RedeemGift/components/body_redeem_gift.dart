import 'dart:developer';

import 'package:cakrawala_mobile/Screens/RedeemGift/components/confirm_redeem_gift.dart';
import 'package:cakrawala_mobile/components/bottom_confirm_button.dart';
import 'package:cakrawala_mobile/components/choose_gift_table.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';

import '../../../utils/points-api.dart';

class BodyRedeemGift extends StatelessWidget {
  const BodyRedeemGift({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 10,bottom: 20),
          child: const Text(
            "Choose the gift that you want to redeem.",
            style: TextStyle(
              color: Color(0xE5E5E5E5),
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ),
        ChooseGiftTable(),
        ButtonConfirmButton(text: "Continue To Redeem", press: () async {
          if (Gift.getSelectedGift().id == -1) {
            log("masuk else");
            Fluttertoast.showToast(
                msg: "Please choose gift before continue",
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
                MaterialPageRoute(builder: (context) =>
                    ConfirmRedeemGiftScreen(
                      choosenGift: Gift.getSelectedGift(),
                    )
                )
            );
          }
        })
      ],
    );
  }
}
