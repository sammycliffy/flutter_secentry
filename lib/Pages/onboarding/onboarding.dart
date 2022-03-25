import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/profile_helpers.dart';
import 'package:flutter_secentry/helpers/profile_selector.dart';
import 'package:flutter_secentry/services/estate_service.dart';
import 'package:flutter_secentry/widget/button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  Image? currentImage;
  String? token;
  @override
  void initState() {
    super.initState();
    currentImage = Image.asset(Images.onboard1, width: 300, height: 300);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(currentImage!.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              heightSpace(150),
              Center(
                child: currentImage,
              ),
              Text(
                'Welcome to Secentry',
                style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold, color: kPrimary),
              ),
              heightSpace(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Secentry is an automated visitor management platform that helps secure companies and estate properties.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              heightSpace(40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: CustomButton(text: 'Continue', validate: null),
              )
            ],
          ),
        ));
  }
}
