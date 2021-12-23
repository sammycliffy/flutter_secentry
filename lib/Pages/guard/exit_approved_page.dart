import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/widget/button.dart';

class ExitApproved extends StatelessWidget {
  const ExitApproved({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightSpace(100),
              const Text(
                'Exit Approved',
                style: TextStyle(fontSize: 40),
              ),
              const Text(
                'You can go out',
                style: TextStyle(fontSize: 20),
              ),
              exitApproved,
              CustomButton(text: 'Continue', validate: null),
              heightSpace(50),
            ],
          ),
        ),
      ),
    );
  }
}
