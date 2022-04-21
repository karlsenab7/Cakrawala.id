import 'package:cakrawala_mobile/constants.dart';
import 'package:flutter/material.dart';

import 'components/body_transaction_successful.dart';

class TransactionSuccessfulScreen extends StatelessWidget {
  final int id;
  final int nominal;
  final int points;
  final String namaMerchant;
  final String time;
  const TransactionSuccessfulScreen({
    Key? key,
    required this.id,
    required this.nominal,
    required this.points,
    required this.namaMerchant,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: deepSkyBlue,
        body: BodyTransactionSuccessful(
          id: id,
          nominal: nominal,
          points: points,
          namaMerchant: namaMerchant,
          time: time,
        ),
      ),
    );
  }
}
