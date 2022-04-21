import 'package:cakrawala_mobile/Screens/Payment/components/body_invoice.dart';
import 'package:flutter/material.dart';

import '../../components/custom_app_bar.dart';
import '../../constants.dart';

class InvoiceScreen extends StatelessWidget {
  final int id;
  final int nominal;
  final int points;
  final String namaMerchant;
  final String time;
  const InvoiceScreen({
    Key? key,
    required this.id,
    required this.nominal,
    required this.points,
    required this.namaMerchant,
    required this.time
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepSkyBlue,
      appBar: const CustomAppBar(text: "Invoice"),
      body: BodyInvoice(
        id: id,
        namaMerchant: namaMerchant,
        nominal: nominal,
        points: points,
        time: time,
      ),
    );
  }
}
