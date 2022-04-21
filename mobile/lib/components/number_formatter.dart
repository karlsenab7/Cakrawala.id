import 'dart:developer';

class NumberFormatter {
  String formatNumber(String num) {
    String temp = "";
    int count = 0;

    // reverse num string
    String reversed = String.fromCharCodes(num.runes.toList().reversed);

    // traverse the reversed string
    for (var c in reversed.runes) {
      var ch = String.fromCharCode(c);
      count++;
      temp = temp + ch;

      // if three characters are traversed
      if (count == 3) {
        temp = temp + ",";
        count = 0;
      }
    }

    // reverse back the string
    reversed = String.fromCharCodes(temp.runes.toList().reversed);

    // if given string is less than 1000
    if (reversed.length % 4 == 0) {
      // remove ","
      reversed = reversed.substring(1);
      log("substring: $reversed");
    }
    return reversed;
  }
}