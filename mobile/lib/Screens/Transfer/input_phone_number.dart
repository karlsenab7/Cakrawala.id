import 'package:cakrawala_mobile/Screens/Homepage/homepage_screen.dart';
import 'package:cakrawala_mobile/Screens/Transfer/components/body_input.dart';
import "package:flutter/material.dart";

import '../../components/choose_account_table1.dart';
import '../../components/custom_app_bar.dart';
import '../../constants.dart';

class InputPhoneNumberScreen extends StatelessWidget {
  const InputPhoneNumberScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => const Homepage()),
            ModalRoute.withName('/') // Replace this with your root screen's route name (usually '/')
        );
        currentUser = User(-1, "Unknown", "-1", -1, "Unknown");
        return false;
      },
      child: const Scaffold(
          backgroundColor: deepSkyBlue,
          appBar: CustomAppBar(text: "Transfer"),
          body: BodyInput()
      ),
    );
  }
}
