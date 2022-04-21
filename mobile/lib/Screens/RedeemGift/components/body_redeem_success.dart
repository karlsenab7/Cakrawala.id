import 'package:cakrawala_mobile/Screens/RedeemGift/components/invoice.dart';
import 'package:cakrawala_mobile/components/bottom_confirm_button.dart';
import 'package:cakrawala_mobile/constants.dart';
import 'package:flutter/material.dart';

class BodyRedeemSuccessful extends StatelessWidget {
  final int nominal;
  final String namaGift;
  final String time;
  const BodyRedeemSuccessful({
    Key? key,
    required this.nominal,
    required this.namaGift,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Expanded(
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Text(
              "Redeem Successful",
              style: TextStyle(
                color: white,
                fontSize: 25,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        ButtonConfirmButton(
            text: "See Invoice",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InvoiceScreen(
                    namaGift: namaGift,
                    nominal: nominal,
                    time: time,
                  )
                )
              );
            },
        )
      ],
    );
  }
}
