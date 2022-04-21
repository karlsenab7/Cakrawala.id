import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cakrawala_mobile/components/choose_gift_table.dart';
import 'package:cakrawala_mobile/value-store/constant.dart';
import 'package:cakrawala_mobile/value-store/sp-handler.dart';
import 'package:http/http.dart' as http;

import 'custom-http-response.dart';

class GiftAPI{
  Future<Map<String, String>> _getHeaders() async{
    var token = await SharedPreferenceHandler.getHandler();
    var map = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.AUTHORIZATION : token.getToken()
    };
    return map;
  }

  Future<List<Gift>> fetchGift() async {
    var header = await _getHeaders();
    final response = await http.get(Uri.parse(Constant.URL_BE+"/get-rewards"), headers: header);
    var bodyresp = json.decode(response.body) as Map<String, dynamic>;

    if(response.statusCode == 200){
      var temp = bodyresp['data'].map((e) => Gift.fromJson(e)).toList().cast<Gift>();
      log("masuk 200!! $temp");
      return temp;
    } else {
      log("masuk else");
      throw Exception('Failed to load gift');
    }
  }

  Future<CustomHttpResponse<Map<String, dynamic>>> getGift() async {
    var header = await _getHeaders();
    var response = await http.get(Uri.parse(Constant.URL_BE+"/gift"), headers: header);
    var bodyresp = json.decode(response.body) as Map<String, dynamic>;
    if(response.statusCode == 200){
      return CustomHttpResponse(response.statusCode, "", bodyresp);
    } else if(response.statusCode < 500){
      return CustomHttpResponse(response.statusCode, bodyresp['message'], json.decode('{}') as Map<String, dynamic>);
    }
    return CustomHttpResponse(response.statusCode, response.body, json.decode('{}') as Map<String, dynamic>);
  }

}