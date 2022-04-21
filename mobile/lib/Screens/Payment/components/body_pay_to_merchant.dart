import 'dart:developer';

import 'package:cakrawala_mobile/Screens/Payment/confirm_payment.dart';
import 'package:cakrawala_mobile/components/bottom_confirm_button.dart';
import 'package:cakrawala_mobile/components/choose_merchant_table.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';

import '../../../utils/points-api.dart';

class BodyPayToMerchant extends StatelessWidget {
  const BodyPayToMerchant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 10,bottom: 20),
          child: const Text(
            "Choose the merchant that you want to pay.",
            style: TextStyle(
              color: Color(0xE5E5E5E5),
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ),
        ChooseMerchantTable(),
        ButtonConfirmButton(text: "Continue To Payment", press: () async {
          if (Merchant.getSelectedMerchant().id == -1) {
            log("masuk else");
            Fluttertoast.showToast(
                msg: "Please choose merchant before continue",
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
                    ConfirmPaymentScreen(
                      choosenMerchant: Merchant.getSelectedMerchant(),
                    )
                )
            );
          }
        })
      ],
    );
  }
}
