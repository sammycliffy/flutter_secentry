import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/spaces.dart';

class NewsDetails extends StatelessWidget {
  final String? subject;
  final String? body;
  final String? time;
  const NewsDetails({Key? key, this.subject, this.body, this.time})
      : super(key: key);

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
            Text(
              subject!,
              style: const TextStyle(fontSize: 30),
            ),
            heightSpace(20),
            Text(
              time!,
              style: TextStyle(fontSize: 15, color: kGray),
            ),
            heightSpace(30),
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              child: Text(
                body!,
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
