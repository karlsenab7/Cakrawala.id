import 'package:cakrawala_mobile/components/user_info_text.dart';
import 'package:cakrawala_mobile/components/white_text_field_container.dart';
import 'package:cakrawala_mobile/constants.dart';
import "package:flutter/material.dart";

class UserProfileContainer extends StatelessWidget {
  final String name;
  final String phone;
  final String email;
  const UserProfileContainer({
    Key? key,
    required this.name,
    required this.phone,
    required this.email
  }) : super(key: key);
  static const double pad = 0.035;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WhiteFieldContainer(
      child: Column (
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          UserInfoText(attribute: "Name", value: name),
          SizedBox(height: size.height * pad),
          UserInfoText(attribute: "Phone Number", value: phone),
          SizedBox(height: size.height * pad),
          UserInfoText(attribute: "Email", value: email)
        ]
      )
    );
  }
}
