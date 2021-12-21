import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final validate;
  CustomButton({Key? key, @required this.text, @required this.validate})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: kPrimary, borderRadius: BorderRadius.circular(5)),
        child: Center(
            child: Text(
          text!,
          style: TextStyle(color: Colors.white, fontSize: 18),
        )),
      ),
      onTap: validate,
    );
  }
}
