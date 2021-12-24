import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/helpers/profile_helpers.dart';
import 'package:flutter_secentry/helpers/profile_selector.dart';
import 'package:flutter_secentry/services/estate_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Image? currentImage;
  String? token;
  @override
  void initState() {
    super.initState();
    currentImage = Image.asset(Images.secentryLogo, width: 200, height: 200);
    Timer(
      Duration(seconds: 3),
      () => checkForFirstInstallation(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(currentImage!.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white, body: Center(child: currentImage));
  }

  checkLoginState() async {
    final EstateServices _estateServices = EstateServices();
    SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");
    print(token);
    if (token != null) {
      dynamic result = await _estateServices.getEstateDetail();
      saveUser(context);
      saveEstate(context);
      checkProfile(context);
    } else {
      Navigator.pushNamed(context, '/login');
    }
  }

  void checkForFirstInstallation() async {
    final prefs = await SharedPreferences.getInstance();
    int launchCount = prefs.getInt('counter') ?? 0;
    prefs.setInt('counter', launchCount + 1);
    if (launchCount == 0) {
      Navigator.pushNamed(context, '/onboarding');
    } else {
      checkLoginState();
    }
  }
}
