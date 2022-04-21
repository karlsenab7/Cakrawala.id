import 'package:cakrawala_mobile/Screens/Payment/components/body_pay_to_merchant.dart';
import 'package:cakrawala_mobile/components/custom_app_bar.dart';
import 'package:cakrawala_mobile/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PayToMerchantScreen extends StatelessWidget {
  const PayToMerchantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: deepSkyBlue,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        text: "Pay To Merchant",
        center: true,
        backButton: false,
      ),
      body: BodyPayToMerchant(),
    );
  }
}
