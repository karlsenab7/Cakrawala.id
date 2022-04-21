import 'dart:convert';
import 'dart:developer';

import 'package:cakrawala_mobile/Screens/Payment/transaction_successful.dart';
import 'package:cakrawala_mobile/components/bottom_confirm_button.dart';
import 'package:cakrawala_mobile/components/choose_merchant_table.dart';
import 'package:cakrawala_mobile/components/formatter.dart';
import 'package:cakrawala_mobile/components/text_account_template.dart';
import 'package:cakrawala_mobile/components/white_text_field_container.dart';
import 'package:cakrawala_mobile/constants.dart';
import 'package:cakrawala_mobile/utils/payment-api.dart';
import 'package:cakrawala_mobile/utils/points-api.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../components/blurry-dialog.dart';

class BodyConfirmPayment extends StatefulWidget {
  final Merchant choosenMerchant;
  const BodyConfirmPayment({
    Key? key,
    required this.choosenMerchant
  }) : super(key: key);

  @override
  State<BodyConfirmPayment> createState() => _BodyConfirmPaymentState();
}

class _BodyConfirmPaymentState extends State<BodyConfirmPayment> {
  int amount = 0;
  getCurrentTime() {
    DateTime now = DateTime.now();
    DateFormatter formatted = DateFormatter(now.day, now.month, now.year, now.hour, now.minute, now.second);
    return formatted.toString();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        SizedBox(height: .05 * size.width),
        Center(
          child: Container(
            width: .68 * size.width,
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
                  text: "INPUT AMOUNT",
                  align: TextAlign.center,
                  weight: FontWeight.bold,
                  size: 14,
                  color: Color(0xFF565656),
                ),
                SizedBox(
                  height: .01 * size.height,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: .08 * size.width,
                    ),
                    Container(
                      width: .4 * size.width,
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
                          amount = value == "" ? 0 : int.parse(value); // TODO
                        },
                      ),
                    ),
                    Container(
                      width: .08 * size.width,
                      child: const TextAccountTemplate(
                        text: "IDR",
                        align: TextAlign.center,
                        weight: FontWeight.w400,
                        size: 16,
                        color: black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: .018 * size.height,
                ),
                const TextAccountTemplate(
                  text: "You will get bonus points!",
                  align: TextAlign.center,
                  weight: FontWeight.w400,
                  size: 14,
                  color: Color(0xFF565656),
                ),
                SizedBox(
                  height: .02 * size.height,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: .03 * size.width,
        ),
        Column (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const TextAccountTemplate(
              text: "Address",
              align: TextAlign.left,
              weight: FontWeight.w400,
              size: 15,
            ),
            WhiteFieldContainer(
              round: 5,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: TextAccountTemplate(
                  text: widget.choosenMerchant.alamat,
                  align: TextAlign.left,
                  weight: FontWeight.w400,
                  size: 15,
                  color: black,
                ),
              )
            ),
            const TextAccountTemplate(
              text: "Account Number",
              align: TextAlign.left,
              weight: FontWeight.w400,
              size: 15,
            ),
            WhiteFieldContainer(
                round: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextAccountTemplate(
                    text: "${widget.choosenMerchant.no_rek} a/n ${widget.choosenMerchant.name}",
                    align: TextAlign.left,
                    weight: FontWeight.w400,
                    size: 15,
                    color: black,
                  ),
                )
            ),
          ],
        ),
        ButtonConfirmButton(
            text: "Finish Payment",
            press: () {
              // cek amount > 0
              if(amount<=0) {
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

              // pop up dialog
              showConfirmDialog(context, () async {
                int points = await PointsAPI.payCalculatePoints(amount);
                log("points: $points");
                var resp = await PembayaranAPI.payToMerchant(
                    widget.choosenMerchant.id, amount, widget.choosenMerchant.alamat, widget.choosenMerchant.no_rek);
                if(resp.status == 200) {
                  log(resp.data['data']['id'].toString());
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TransactionSuccessfulScreen(
                        id: resp.data['data']['id'],
                        namaMerchant: widget.choosenMerchant.name,
                        nominal: amount,
                        points: points,
                        time: getCurrentTime(),
                      )
                      )
                  );
                  // reset current merchant
                  currentMerchant = Merchant(-1, "Unknown", "Unknown", "-1");
                } else {
                  log('resp message: ${resp.message}');
                  var msg = json.decode(resp.message) as Map<String, dynamic>;
                  var temp = msg['message'];
                  _showDialog(context, "Gagal melakukan pembayaran", temp, null);
                }
              });

            })
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
      title: const Text("Payment Confirmation"),
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
