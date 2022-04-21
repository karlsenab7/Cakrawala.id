
import 'dart:io';

import 'package:cakrawala_mobile/utils/custom-http-response.dart';
import 'package:cakrawala_mobile/value-store/sp-handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../value-store/constant.dart';
class AuthenticationApi {
  static final Map<String, String> _headers = {
    HttpHeaders.contentTypeHeader: 'application/json'
  };

  static Future<CustomHttpResponse<Map<String, dynamic>>> loginRequest(email, password) async {
    var sp = await SharedPreferenceHandler.getHandler();
    var data = {
      "email": email,
      "password" : password,
    };
    var response = await http.post(
      Uri.parse(Constant.URL_BE +"/login"),
      body: json.encode(data),
      headers: _headers
    );
    var blankResp = json.decode("{}")as Map<String, dynamic>;
    if(response.statusCode<500){
      var bodyresp = json.decode(response.body) as Map<String, dynamic>;
      if(response.statusCode == 200){
        sp.setToken(bodyresp["token"]);
        return CustomHttpResponse(response.statusCode, bodyresp["token"], bodyresp);
      }
      print(response.body);
      return CustomHttpResponse(response.statusCode, bodyresp["message"], blankResp);
    }
    return CustomHttpResponse(response.statusCode, response.body, blankResp);
  }

  static Future<CustomHttpResponse<Map<String, dynamic>>> registerRequest(email, password, name, phone) async {
    var body = {
      "email" : email,
      "name" : name,
      "phone" : phone,
      "password" : password
    };
    var response = await http.post(
        Uri.parse(Constant.URL_BE +"/register"),
        body: json.encode(body),
        headers: _headers
    );
    var blankResp = json.decode("{}")as Map<String, dynamic>;
    if(response.statusCode<500){
      var bodyresp = json.decode(response.body) as Map<String, dynamic>;
      if(response.statusCode == 200){
        await (await SharedPreferenceHandler.getHandler()).setToken(bodyresp["token"]);
        return CustomHttpResponse(response.statusCode, bodyresp["token"], bodyresp);
      }
      return CustomHttpResponse(response.statusCode, bodyresp["message"], blankResp);
    }
    return CustomHttpResponse(response.statusCode, response.body, blankResp);
  }
}