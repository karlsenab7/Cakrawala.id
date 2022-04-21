import 'dart:async';

import 'package:cakrawala_mobile/Screens/Homepage/homepage_screen.dart';
import 'package:cakrawala_mobile/Screens/SplashScreen/components/body.dart';
import 'package:cakrawala_mobile/Screens/Welcome/welcome_screen.dart';
import 'package:cakrawala_mobile/value-store/sp-handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SplashScreen extends StatefulWidget{
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return SplashView();
  }
}

class SplashView extends State<SplashScreen>{


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    var durasi = const Duration(seconds: 3);
    return Timer(durasi, () async {
      var spInstance = await SharedPreferences.getInstance();
      var sp  = SharedPreferenceHandler();
      sp.setSharedPreference(spInstance);
      var loggedIn = await sp.isTokenActive();
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => loggedIn ? const Homepage() : const WelcomeScreen()
      ));
    });
  }
}