import 'package:cakrawala_mobile/Screens/Topup/components/body.dart';
import "package:flutter/material.dart";

class TopUpScreen extends StatelessWidget {
  const TopUpScreen({Key? key, required this.userInfo}) : super(key: key);
  final Map<String, dynamic> userInfo;

  @override
  Widget build(BuildContext context) {
    return Body(userInfo: userInfo);
  }
}
