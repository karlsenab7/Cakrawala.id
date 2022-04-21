import 'package:cakrawala_mobile/Screens/SplashScreen/splash_screen.dart';
import 'package:cakrawala_mobile/constants.dart';
import 'package:flutter/material.dart';
import 'package:dcdg/dcdg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: white, scaffoldBackgroundColor: deepSkyBlue),
        home: const SplashScreen());
  }
}
