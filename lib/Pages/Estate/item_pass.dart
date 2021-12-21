import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/formvalidation.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/services/auth_service.dart';
import 'package:flutter_secentry/widget/button.dart';
import 'package:flutter_secentry/widget/loading.dart';
import 'package:provider/provider.dart';

class AddItemPass extends StatefulWidget {
  const AddItemPass({Key? key}) : super(key: key);

  @override
  State<AddItemPass> createState() => _AddItemPassState();
}

class _AddItemPassState extends State<AddItemPass> {
  final title = TextEditingController();
  final quantity = TextEditingController();
  final description = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthServices _authServices = AuthServices();
  ProfileDataNotifier? _profileDataNotifier;

  @override
  Widget build(BuildContext context) {
    _profileDataNotifier = context.watch<ProfileDataNotifier>();
    return Scaffold(
      body: _profileDataNotifier!.loading
          ? const LoadingScreen()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          heightSpace(40),
                          const IconButton(
                              onPressed: null,
                              icon: Icon(Icons.arrow_back_ios)),
                          heightSpace(40),
                          const Text(
                            'Item Pass',
                            style: TextStyle(fontSize: 40),
                          ),
                          heightSpace(50),
                          titleText(),
                          heightSpace(20),
                          quantityText(),
                          heightSpace(20),
                          descriptionText(),
                          heightSpace(20),
                          CustomButton(text: 'Add Item', validate: validate),
                        ],
                      ),
                    ),
                  ),
                  Align(alignment: Alignment.bottomRight, child: background)
                ],
              ),
            ),
    );
  }

  titleText() => TextFormField(
      controller: title,
      validator: (value) => FormValidation().emailValidation(title.text),
      decoration: const InputDecoration(
          fillColor: kGrayLight,
          filled: true,
          contentPadding: EdgeInsets.all(12),
          border: InputBorder.none,
          hintText: 'Item name'));

  quantityText() => TextFormField(
      controller: title,
      keyboardType: TextInputType.number,
      validator: (value) => FormValidation().emailValidation(title.text),
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(12),
          fillColor: kGrayLight,
          filled: true,
          border: InputBorder.none,
          hintText: 'Quantity'));

  descriptionText() => TextFormField(
      maxLines: 5,
      controller: title,
      keyboardType: TextInputType.text,
      validator: (value) => FormValidation().emailValidation(title.text),
      decoration: const InputDecoration(
          fillColor: kGrayLight,
          filled: true,
          contentPadding: EdgeInsets.all(12),
          border: InputBorder.none,
          hintText: 'Description'));

  validate() => Navigator.pushNamed(context, '/pending_request');

  // validate() async {
  //   Navigator.pushNamed(context, '/nofacility');
  //   if (_formKey.currentState!.validate()) {
  //     _profileDataNotifier!.setLoading(true);

  //     dynamic result =
  //         await _authServices.loginUser(context, email.text, password.text);
  //     if (result) {
  //       Navigator.pushNamed(context, '/no_facility_invitation');
  //     }
}
