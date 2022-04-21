import 'package:cakrawala_mobile/Screens/Transfer/components/body_choose.dart';
import "package:flutter/material.dart";

import '../../components/custom_app_bar.dart';
import '../../constants.dart';

class ChooseTransferScreen extends StatelessWidget {
  final String phone;
  const ChooseTransferScreen({Key? key, required this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepSkyBlue,
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(text: "Transfer"),
      body: BodyChoose(phone: phone,)
    );
  }
}