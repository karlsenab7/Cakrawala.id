import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cakrawala_mobile/value-store/constant.dart';
import 'package:cakrawala_mobile/value-store/sp-handler.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../components/number_formatter.dart';

class HistoryAPI {
  static Future<Map<String, String>> _getHeaders() async {
    var token = await SharedPreferenceHandler.getHandler();
    var map = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.AUTHORIZATION: token.getToken()
    };
    return map;
  }

  static Future<List<TransactionHistory>> getHistoryAdmin() async {
    var header = await _getHeaders();
    var response = await http.get(
        Uri.parse(Constant.URL_BE + "/transaction-history"),
        headers: header);
    var bodyResp = json.decode(response.body);

    // print(bodyResp["data"]);

    List<TransactionHistory> transHistory = [];
    late String type;

    if (response.statusCode == 200) {
      for (var t in bodyResp["data"]) {
        // Classify transaction type
        if (t["MerchantID"] == null && t["FriendID"] == null) {
          type = "Topup";
        } else if (t["MerchantID"] != null && t["FriendID"] == null) {
          type = "Pay Merchant";
        } else if (t["MerchantID"] == null && t["FriendID"] != null) {
          type = "Transfer";
        } else {
          type = "Error";
        }

        var formatter = NumberFormatter();

        print("The transaction type is " + type.toUpperCase());
        String destID = t["UserID"].toString();
        String nominal = formatter.formatNumber(t["Amount"].toString());
        String createdAt = t["createdAt"].toString();

        // parsing createdAt
        List<String> timestamp = createdAt.split('T');
        String date = timestamp[0];
        String time = timestamp[1].split('.')[0];
        createdAt = date + " " + time;

        var temp = DateTime.parse(createdAt);
        // log('${DateFormat.MMMM().format(temp)}');

        TransactionHistory trans =
            TransactionHistory(type, destID, nominal, temp);
        transHistory.add(trans);

        // print(createdAt.split('T')[0]);


      }
    }

    return transHistory;
  }
}

class TransactionHistory {
  final String transactionType, destID, nominal;
  final DateTime createdAt;
  TransactionHistory(
      this.transactionType, this.destID, this.nominal, this.createdAt);
}
