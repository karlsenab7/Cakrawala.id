import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cakrawala_mobile/components/user_not_found.dart';
import 'package:cakrawala_mobile/value-store/constant.dart';
import 'package:cakrawala_mobile/value-store/sp-handler.dart';
import 'package:http/http.dart' as http;

import '../components/choose_account_table1.dart';

class UserAPI{
  Future<Map<String, String>> _getHeaders() async{
    var token = await SharedPreferenceHandler.getHandler();
    var map = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.AUTHORIZATION : token.getToken()
    };
    return map;
  }

  Future<List<User>> fetchUser(String phone) async {
    var header = await _getHeaders();
    var data = {
      "phone": phone.toString()
    };
    // log(json.encode(data));

    final response = await http.post(
        Uri.parse(Constant.URL_BE+"/phone-number"),
        body: json.encode(data),
        headers: header);

    var bodyresp = json.decode(response.body) as Map<String, dynamic>;
    
    // log(response.statusCode.toString());

    if(response.statusCode == 200){
      var temp = bodyresp['data'].map((e) => User.fromJson(e)).toList().cast<User>();
      log("masuk 200!! $temp");
      return temp;
    } else {
      throw Exception('Failed to load user');
    }
  }
}