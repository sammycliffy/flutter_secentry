import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/widget/button.dart';

class EntryInfo extends StatefulWidget {
  const EntryInfo({Key? key}) : super(key: key);

  @override
  _EntryInfoState createState() => _EntryInfoState();
}

class _EntryInfoState extends State<EntryInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightSpace(40),
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios)),
                heightSpace(30),
                const Text(
                  'Guest Info',
                  style: TextStyle(fontSize: 40),
                ),
                heightSpace(10),
                const Text(
                  'Bimbo Ogunlade',
                  style: TextStyle(fontSize: 20),
                ),
                heightSpace(30),
                text('Host name', 'Mr Bolu'),
                Divider(),
                heightSpace(20),
                text('Host phone', '08123456789'),
                Divider(),
                heightSpace(20),
                text('Country', 'Nigeria'),
                Divider(),
                heightSpace(20),
                text('State', 'Rivers State'),
                Divider(),
                heightSpace(20),
                text('Visitor Address', 'Akpajo Eleme'),
                Divider(),
                heightSpace(20),
                text('Phone Number', '08123456789'),
                Divider(),
                heightSpace(20),
                text('Purpose of visit', 'Mekwe'),
                Divider(),
                heightSpace(20),
                text('Gender', 'Male'),
                Divider(),
                heightSpace(20),
                text('Time', '2 hours'),
                Divider(),
                heightSpace(50),
                CustomButton(text: 'Approve', validate: null),
                heightSpace(50),
              ],
            ),
          )
        ],
      ),
    ));
  }

  text(title, text) => Column(
        // ignore: prefer_const_literals_to_create_immutables
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: kGray, fontSize: 15),
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 20),
          )
        ],
      );
}
