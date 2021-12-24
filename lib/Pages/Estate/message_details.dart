import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/spaces.dart';

class MessageDetails extends StatelessWidget {
  final String? message;
  const MessageDetails({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // ignore: prefer_const_literals_to_create_immutables
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightSpace(40),
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios)),
            const Text(
              'Messages',
              style: TextStyle(fontSize: 40),
            ),
            heightSpace(30),
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              child: Text(
                message!,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 17),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
