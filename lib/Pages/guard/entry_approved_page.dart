import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/widget/button.dart';

class EntryApproved extends StatelessWidget {
  const EntryApproved({Key? key}) : super(key: key);

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
                'Entry Approved',
                style: TextStyle(fontSize: 40),
              ),
              heightSpace(10),
              const Text(
                'You can go in',
                style: TextStyle(fontSize: 20),
              ),
              Center(
                  child:
                      SizedBox(width: 300, height: 400, child: entryApproved)),
              CustomButton(
                  text: 'Continue',
                  validate: () =>
                      Navigator.pushNamed(context, '/guard_dashboard')),
              heightSpace(50),
            ],
          ),
        ),
      ),
    );
  }
}
