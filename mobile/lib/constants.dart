import "package:flutter/material.dart";

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

const deepSkyBlue = Color(0xFF00A2ED);
const slateGray = Color(0xFF666892);
const black = Color(0xFF202225);
const white = Color(0xFFFFFFFF);
const primaryColor = Color(0xFFFFD335);
// const primaryLightColor = Color(0xFF2B2B2B);
// const primaryColor = Color(0xFFFFD335);
// const primaryLightColor = Color(0xFF2B2B2B);
