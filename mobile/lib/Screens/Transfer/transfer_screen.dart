import 'package:cakrawala_mobile/Screens/Transfer/components/body.dart';
import "package:flutter/material.dart";

import '../../components/choose_account_table1.dart';
import '../../components/custom_app_bar.dart';
import '../../constants.dart';

class TransferScreen extends StatelessWidget {
  final User choosenUser;
  const TransferScreen({Key? key, required this.choosenUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        currentUser = User(-1, "Unknown", "-1", -1, "Unknown");
        return true;
      },
      child: Scaffold(
        backgroundColor: deepSkyBlue,
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(text: "Transfer"),
        body: Body(choosenUser: choosenUser)
      ),
    );
  }
}