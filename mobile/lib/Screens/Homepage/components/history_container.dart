import 'package:flutter/material.dart';

import '../../../constants.dart';

class HistoryContainer extends StatelessWidget {
  final Widget child;
  const HistoryContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width

    return Center(
      child: Container(
        height: 250,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        width: size.width * 0.89,
        decoration: BoxDecoration(
          // color: Colors.black,
            border: Border.all(width: 0.6, color: white),
            borderRadius: BorderRadius.circular(10)),
        child: child,

      ),
    );
  }
}
