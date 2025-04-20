import 'dart:developer';

import 'package:america/constants.dart';
import 'package:america/views/branches_screen.dart';
import 'package:america/views/homeScreen.dart';
import 'package:america/views/login_screen.dart';
import 'package:america/views/register_screen.dart';
import 'package:flutter/material.dart';

import 'package:america/views/appScreen.dart';
import 'package:america/widgets/navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  void navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");
    log(token.toString());
    if (token == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BranchesScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
            width: 400.0,
            height: 400.0,
          ),
        ),
      ),
    );
  }
}
