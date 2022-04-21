import 'package:cakrawala_mobile/value-store/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class SharedPreferenceHandler {
  late SharedPreferences sp;
  SharedPreferenceHandler(){
    init();
  }

  void init() async{
    sp = await SharedPreferences.getInstance();
  }

  void  setSharedPreference(SharedPreferences sharedPreferences){
    sp = sharedPreferences;
  }

  Future<bool> setToken(token) async {
    try{
      await this.sp.setString("token", token);
      return true;
    }on Exception catch(e){
      print(e.toString());
      return false;
    }
  }

  String getToken() {
    var token = this.sp.getString("token");
    if(token != null){
      return token;
    }
    return "";
  }

  Future<bool> isTokenActive() async{
    var token = getToken();
    try{
      var response = await http.get(
          Uri.parse(Constant.URL_BE + "/test"),
          headers: {
            "Authorization" : token
          }
      );
      return response.statusCode == 200;
    } on Exception catch(e){
      return false;
    }
  }

  Future<bool> revokeToken() async{
    try{
      await this.sp.setString("token", "");
      return true;
    }on Exception catch(e){
      print(e.toString());
      return false;
    }
  }

  static Future<SharedPreferenceHandler> getHandler() async {
    var sp = SharedPreferenceHandler();
    sp.setSharedPreference(await SharedPreferences.getInstance());
    return sp;
  }
}