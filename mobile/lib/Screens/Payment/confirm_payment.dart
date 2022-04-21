import 'package:cakrawala_mobile/Screens/Payment/components/body_confirm_payment.dart';
import 'package:cakrawala_mobile/components/choose_merchant_table.dart';
import 'package:flutter/material.dart';

import '../../components/custom_app_bar.dart';
import '../../constants.dart';

class ConfirmPaymentScreen extends StatelessWidget {
  final Merchant choosenMerchant;
  const ConfirmPaymentScreen(
      {Key? key,
        required this.choosenMerchant,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepSkyBlue,
      appBar: const CustomAppBar(text: "Confirm Payment"),
      body: BodyConfirmPayment(
        choosenMerchant: choosenMerchant,
      )
    );
  }
}
