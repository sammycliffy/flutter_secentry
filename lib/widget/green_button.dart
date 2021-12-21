import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';

class GreenCustomButton extends StatelessWidget {
  final String? text;
  // ignore: prefer_typing_uninitialized_variables
  final validate;
  const GreenCustomButton(
      {Key? key, @required this.text, @required this.validate})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: kGreen, borderRadius: BorderRadius.circular(5)),
        child: Center(
            child: Text(
          text!,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        )),
      ),
      onTap: validate,
    );
  }
}
