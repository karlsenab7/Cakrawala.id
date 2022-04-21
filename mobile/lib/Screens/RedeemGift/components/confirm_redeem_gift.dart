import 'package:cakrawala_mobile/Screens/RedeemGift/components/body_confirm_gift.dart';
import 'package:cakrawala_mobile/components/choose_gift_table.dart';
import 'package:flutter/material.dart';

import '../../../components/custom_app_bar.dart';
import '../../../constants.dart';

class ConfirmRedeemGiftScreen extends StatelessWidget {
  final Gift choosenGift;
  const ConfirmRedeemGiftScreen(
      {Key? key,
        required this.choosenGift,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepSkyBlue,
      appBar: const CustomAppBar(text: "Confirm Redeem Gift"),
      body: BodyConfirmRedeemGift(
        choosenGift: choosenGift,
      )
    );
  }
}
