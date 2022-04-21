import 'package:cakrawala_mobile/Screens/Welcome/welcome_screen.dart';
import 'package:cakrawala_mobile/components/custom_app_bar.dart';
import 'package:cakrawala_mobile/constants.dart';
import 'package:cakrawala_mobile/utils/userinfo-api.dart';
import 'package:cakrawala_mobile/value-store/sp-handler.dart';
import "package:flutter/material.dart";

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var sp = SharedPreferenceHandler();
  String email = "-";
  String name = "-";
  String phone = "-";
  String balance = "-";
  String points = "-";
  String serviceLevel = "-";
  
  List<String> userDataHeader = [
    "Name",
    "Email",
    "Phone",
    "Balance",
    "Points",
    "Service Level"
  ];
  List<String> userData = [];

  @override
  void initState() {
    loadState();
    super.initState();
  }

  void loadState() async {
    await UserInfoAPI.getUserInformation().then((data) {
      setState(() {
        if (data.status == 200) {
          setState(() {
            email = data.data['email'];
            name = data.data['Name'];
            phone = data.data['Phone'];
            balance = data.data['balance'].toString();
            points = data.data['point'].toString();
            serviceLevel = getUserLevelService(data.data['exp']).toString();
            loadUserData();
          });
        }
      });
    });
  }

  void loadUserData() {
    userData.add(name);
    userData.add(email);
    userData.add(phone);
    userData.add(balance);
    userData.add(points);
    userData.add(serviceLevel);
  }

  void logOut() {
    sp.revokeToken();
  }

  int getUserLevelService(int exp) {
    if (exp > 2500) {
      return 6;
    } else if (exp > 1800) {
      return 5;
    } else if (exp > 1000) {
      return 4;
    } else if (exp > 600) {
      return 3;
    } else if (exp > 300) {
      return 2;
    } else if (exp > 90) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: deepSkyBlue,
      appBar: const CustomAppBar(
        text: "Profile",
        center: true,
        backButton: false,
      ),
      body: Column(
        children: [
          // PROFILE INFO
          ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.white,
              );
            },
            itemCount: userData.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(userDataHeader[index]),
                subtitle: Text(
                  userData[index],
                  style: const TextStyle(
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: white,
                  ),
                ),
              );
            },
          ),

          // LOGOUT BUTTON
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            width: size.width * 0.27,
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(50)),
            child: TextButton.icon(
              icon: const Icon(Icons.logout, color: white),
              label: const Text("Log Out",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Mulish',
                      fontSize: 15,
                      fontWeight: FontWeight.w700)),
              onPressed: () {
                logOut();
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const WelcomeScreen()),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
