import 'package:cakrawala_mobile/Screens/Payment/invoice.dart';
import 'package:cakrawala_mobile/components/bottom_confirm_button.dart';
import 'package:cakrawala_mobile/constants.dart';
import 'package:flutter/material.dart';

class BodyTransactionSuccessful extends StatelessWidget {
  final int id;
  final int nominal;
  final int points;
  final String namaMerchant;
  final String time;
  const BodyTransactionSuccessful({
    Key? key,
    required this.id,
    required this.nominal,
    required this.points,
    required this.namaMerchant,
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
              "Transaction Successful",
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
                    id: id,
                    namaMerchant: namaMerchant,
                    nominal: nominal,
                    points: points,
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
