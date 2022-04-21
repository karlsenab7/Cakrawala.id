import 'package:cakrawala_mobile/Screens/Transfer/input_phone_number.dart';
import 'package:cakrawala_mobile/components/rounded_button.dart';
import 'package:cakrawala_mobile/components/text_account_template.dart';
import "package:flutter/material.dart";

import '../../components/custom_app_bar.dart';
import '../../constants.dart';

class UserNotFoundScreen extends StatelessWidget {
  const UserNotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width
    return WillPopScope(
      onWillPop: () async {
        // int count = 0;
        // Navigator.of(context).popUntil((_)=> count++>= 2);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => const InputPhoneNumberScreen()),
            ModalRoute.withName('/') // Replace this with your root screen's route name (usually '/')
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: deepSkyBlue,
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(text: "Transfer"),
        body: Center(
          child: Container(
            width: .68 * size.width,
            height: .355 * size.height,
            // height: .3 * size.height,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: .015 * size.height,
                ),
                const Icon(
                  Icons.warning_amber_rounded,
                  color: deepSkyBlue,
                  size: 100.0,
                ),
                SizedBox(
                  height: .01* size.height,
                ),
                const TextAccountTemplate(
                  text: "User Not Found!",
                  align: TextAlign.center,
                  weight: FontWeight.w800,
                  size: 19,
                  color: black,
                ),
                SizedBox(
                  height: .018 * size.height,
                ),
                SizedBox(
                  width: .5 * size.width,
                  child: const TextAccountTemplate(
                    text: "Unable to find this recipient. The recipent's number is not valid",
                    align: TextAlign.center,
                    weight: FontWeight.w500,
                    size: 13,
                    color: Colors.black45,
                  ),
                ),
                SizedBox(
                  height: .012 * size.height,
                ),
                RoundedButton(
                  text: "Try Again",
                  press: (){
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) => const InputPhoneNumberScreen()),
                        ModalRoute.withName('/') // Replace this with your root screen's route name (usually '/')
                    );
                  },
                  color: black,
                  width: 120,
                  height: 36,
                  padding: false,
                  textColor: white,
                  fontSize: 12,
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
