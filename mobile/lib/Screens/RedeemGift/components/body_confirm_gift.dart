import 'dart:convert';
import 'dart:developer';

import 'package:cakrawala_mobile/Screens/RedeemGift/components/redeem_success.dart';
import 'package:cakrawala_mobile/components/bottom_confirm_button.dart';
import 'package:cakrawala_mobile/components/choose_gift_table.dart';
import 'package:cakrawala_mobile/components/formatter.dart';
import 'package:cakrawala_mobile/components/text_account_template.dart';
import 'package:cakrawala_mobile/components/white_text_field_container.dart';
import 'package:cakrawala_mobile/constants.dart';
import 'package:cakrawala_mobile/utils/redeem-api.dart';
import 'package:flutter/material.dart';

import '../../../components/blurry-dialog.dart';

class BodyConfirmRedeemGift extends StatefulWidget {
  final Gift choosenGift;
  const BodyConfirmRedeemGift({
    Key? key,
    required this.choosenGift
  }) : super(key: key);

  @override
  State<BodyConfirmRedeemGift> createState() => _BodyConfirmRedeemGiftState();
}

class _BodyConfirmRedeemGiftState extends State<BodyConfirmRedeemGift> {
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
                  text: "AMOUNT",
                  align: TextAlign.center,
                  weight: FontWeight.w400,
                  size: 16,
                  color: black,
                ),
                SizedBox(
                  height: .01 * size.height,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextAccountTemplate(
                      text: widget.choosenGift.price.toString(),
                      align: TextAlign.center,
                      weight: FontWeight.w800,
                      size: 30,
                      color: black,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 6),
                      child: TextAccountTemplate(
                        text: "points",
                        align: TextAlign.center,
                        weight: FontWeight.w400,
                        size: 13,
                        color: black,
                      ),
                    ),
                  ],
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
              text: "Description",
              align: TextAlign.left,
              weight: FontWeight.w400,
              size: 15,
            ),
            WhiteFieldContainer(
              round: 5,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: TextAccountTemplate(
                  text: widget.choosenGift.name,
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
            text: "Finish Redeem",
            press: () {
              // pop up dialog
              showConfirmDialog(context, () async {
                var resp = await RedeemAPI.redeemGifts(widget.choosenGift.id);
                if(resp.data) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RedeemSuccessfulScreen(
                        namaGift: widget.choosenGift.name,
                        nominal: widget.choosenGift.price,
                        time: getCurrentTime(),
                      )
                    )
                  );
                  // reset current merchant
                  currentGift = Gift(-1, "Unknown", -1, -1);
                } else {
                  log('resp message: ${resp.message}');
                  var msg = json.decode(resp.message) as Map<String, dynamic>;
                  var temp = msg['message'];
                  _showDialog(context, "Gagal melakukan redeem", temp, null);
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
      title: const Text("Redeem Confirmation"),
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
