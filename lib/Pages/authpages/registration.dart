import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/formvalidation.dart';
import 'package:flutter_secentry/helpers/profile_helpers.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/services/auth_service.dart';
import 'package:flutter_secentry/widget/button.dart';
import 'package:flutter_secentry/widget/loading.dart';
import 'package:provider/provider.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final email = TextEditingController();
  final fullName = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = 'Company user';
  String gender = 'Male';
  bool companyUser = true;
  bool estateUser = false;
  final AuthServices _authServices = AuthServices();
  ProfileDataNotifier? _profileDataNotifier;
  List<String> listOfValue = [
    'Company user',
    'Estate user',
  ];

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
                          heightSpace(120),
                          const Text(
                            'Register',
                            style: TextStyle(fontSize: 40),
                          ),
                          heightSpace(20),
                          fullNameText(),
                          heightSpace(20),
                          emailText(),
                          heightSpace(20),
                          phoneText(),
                          heightSpace(20),
                          addressText(),
                          heightSpace(20),
                          passwordText(),
                          heightSpace(20),
                          confirmpasswordText(),
                          heightSpace(20),
                          dropdown(),
                          heightSpace(20),
                          genderForm(),
                          heightSpace(20),
                          CustomButton(text: 'Register', validate: validate),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/login'),
                                child: const Text('have an account? Login',
                                    style: TextStyle(
                                        fontSize: 17, color: kPrimary))),
                          ),
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

  fullNameText() => TextFormField(
      controller: fullName,
      validator: (value) => FormValidation().stringValidation(fullName.text),
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(12),
          filled: true,
          fillColor: kGrayLight,
          border: InputBorder.none,
          hintText: 'Full name'));
  addressText() => TextFormField(
      controller: address,
      validator: (value) => FormValidation().stringValidation(fullName.text),
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(12),
          filled: true,
          fillColor: kGrayLight,
          border: InputBorder.none,
          hintText: 'Address'));
  phoneText() => TextFormField(
      controller: phone,
      validator: (value) {
        if (value?[0] != '0') {
          return 'Please enter a valid phone number';
        } else if (value!.isEmpty) {
          return 'Phone number can\'t be empty';
        } else {
          return null;
        }
      },
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(12),
          filled: true,
          fillColor: kGrayLight,
          border: InputBorder.none,
          hintText: 'Phone'));
  emailText() => TextFormField(
      controller: email,
      validator: (value) => FormValidation().emailValidation(email.text),
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(12),
          filled: true,
          fillColor: kGrayLight,
          border: InputBorder.none,
          hintText: 'Email'));

  passwordText() => TextFormField(
      obscureText: true,
      controller: password,
      validator: (value) => FormValidation().passwordValidation(password.text),
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(12),
          filled: true,
          fillColor: kGrayLight,
          border: InputBorder.none,
          hintText: 'Password'));

  confirmpasswordText() => TextFormField(
      obscureText: true,
      controller: confirmPassword,
      validator: (value) {
        if (password.text != value) {
          return 'Passwords do not match';
        } else if (value!.isEmpty) {
          return 'Field can\'t be empty';
        } else {
          return null;
        }
      },
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(12),
          filled: true,
          fillColor: kGrayLight,
          border: InputBorder.none,
          hintText: 'Confirm password'));
  dropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      height: 49,
      decoration: const BoxDecoration(
        color: kGrayLight,
      ),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration.collapsed(hintText: 'Account type'),
        value: dropdownValue,
        iconSize: 20,
        elevation: 5,
        onChanged: (String? newValue) {
          if (newValue == 'Estate user') {
            estateUser = true;
            companyUser = false;
          } else {
            estateUser = false;
            companyUser = true;
          }
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: listOfValue.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: const TextStyle(fontSize: 15)),
          );
        }).toList(),
      ),
    );
  }

  validate() async {
    if (_formKey.currentState!.validate()) {
      _profileDataNotifier!.setLoading(true);

      dynamic result = await _authServices.userRegistration(
          context,
          email.text,
          fullName.text,
          phone.text,
          address.text,
          gender,
          password.text,
          companyUser,
          estateUser);

      if (result == true) {
        _profileDataNotifier!.setLoading(false);
        saveUser(context);
        Navigator.pushNamed(context, '/email_verification');
      } else {
        _profileDataNotifier!.setLoading(false);
      }
    }
  }

  Widget genderForm() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          height: 40,
          child: ListTile(
            title: const Text('Male'),
            leading: Radio<String>(
              value: 'Male',
              groupValue: gender,
              onChanged: (String? value) {
                setState(() {
                  gender = value!;
                });
              },
            ),
          ),
        ),
        SizedBox(
          width: 150,
          height: 40,
          child: ListTile(
            title: const Text('Female'),
            leading: Radio<String>(
              value: 'Female',
              groupValue: gender,
              onChanged: (String? value) {
                setState(() {
                  gender = value!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
