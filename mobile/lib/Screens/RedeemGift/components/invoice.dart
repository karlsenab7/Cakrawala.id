import 'package:cakrawala_mobile/Screens/RedeemGift/components/body_invoice.dart';
import 'package:flutter/material.dart';

import '../../../components/custom_app_bar.dart';
import '../../../constants.dart';

class InvoiceScreen extends StatelessWidget {
  final int nominal;
  final String namaGift;
  final String time;
  const InvoiceScreen({
    Key? key,
    required this.nominal,
    required this.namaGift,
    required this.time
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepSkyBlue,
      appBar: const CustomAppBar(text: "Invoice"),
      body: BodyInvoice(
        namaGift: namaGift,
        nominal: nominal,
        time: time,
      ),
    );
  }
}
