import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';

class ComingSoon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightSpace(50),
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios)),
          heightSpace(30),
          Center(child: Image.asset(Images.coming_soon)),
          heightSpace(20),
          Center(
            child: Text('Coming Soon',
                style: TextStyle(fontSize: 20, color: kPrimary)),
          ),
          heightSpace(20),
          Center(
            child: Container(
              width: 40,
              height: 40,
              decoration:
                  BoxDecoration(color: kPrimary, shape: BoxShape.circle),
              child: Center(
                child: Text('to',
                    style: TextStyle(
                        fontWeight: FontWeight.w100,
                        color: kWhite,
                        fontSize: 18)),
              ),
            ),
          ),
          heightSpace(20),
          Center(
            child: Text(
              'Secentry',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ],
      ),
    )));
  }
}
