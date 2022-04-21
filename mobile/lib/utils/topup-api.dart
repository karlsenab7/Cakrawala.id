import 'dart:convert';
import 'dart:io';

import 'package:cakrawala_mobile/value-store/constant.dart';
import 'package:http/http.dart' as http;

import '../value-store/sp-handler.dart';
import 'custom-http-response.dart';
class TopUpAPI{
  static Future<Map<String, String>> _getHeaders() async{
    var token = await SharedPreferenceHandler.getHandler();
    var map = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.AUTHORIZATION : token.getToken()
    };
    return map;
  }

  static Future<CustomHttpResponse<bool>> topUp(int saldo) async {
    var header = await _getHeaders();
    var body = {
      "amount" : saldo
    };

    var response  = await http.post(
      Uri.parse(Constant.URL_BE+"/top-up"),
      body: json.encode(body),
      headers: header
    );
    return CustomHttpResponse(response.statusCode, response.body, response.statusCode==200);
  }
}