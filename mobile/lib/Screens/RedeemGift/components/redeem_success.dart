import 'package:cakrawala_mobile/constants.dart';
import 'package:flutter/material.dart';

import 'package:cakrawala_mobile/Screens/RedeemGift/components/body_redeem_success.dart';

class RedeemSuccessfulScreen extends StatelessWidget {
  final int nominal;
  final String namaGift;
  final String time;
  const RedeemSuccessfulScreen({
    Key? key,
    required this.nominal,
    required this.namaGift,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: deepSkyBlue,
        body: BodyRedeemSuccessful(
          nominal: nominal,
          namaGift: namaGift,
          time: time,
        ),
      ),
    );
  }
}
