import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/formvalidation.dart';
import 'package:flutter_secentry/helpers/getFacilityDetails.dart';
import 'package:flutter_secentry/helpers/profile_helpers.dart';
import 'package:flutter_secentry/helpers/profile_selector.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/services/auth_service.dart';
import 'package:flutter_secentry/services/company/company_services.dart';
import 'package:flutter_secentry/services/estate_service.dart';
import 'package:flutter_secentry/widget/button.dart';
import 'package:flutter_secentry/widget/loading.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final email = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthServices _authServices = AuthServices();
  final EstateServices _estateServices = EstateServices();
  final CompanyServices _companyServices = CompanyServices();
  ProfileDataNotifier? _profileDataNotifier;

  @override
  Widget build(BuildContext context) {
    _profileDataNotifier = context.watch<ProfileDataNotifier>();
    return WillPopScope(
      onWillPop: () => exitApp(),
      child: Scaffold(
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
                              'Login',
                              style: TextStyle(fontSize: 40),
                            ),
                            heightSpace(20),
                            emailText(),
                            heightSpace(20),
                            passwordText(),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                  onPressed: () => Navigator.pushNamed(
                                      context, '/reset_password'),
                                  child: const Text('Forgotten password?',
                                      style: TextStyle(
                                          fontSize: 17, color: kPrimary))),
                            ),
                            heightSpace(50),
                            CustomButton(text: 'Login', validate: validate),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                  onPressed: () => Navigator.pushNamed(
                                      context, '/registration'),
                                  child: const Text('No account? Signup',
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
      ),
    );
  }

  exitApp() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

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
      validator: (value) => FormValidation().passwordValidation(email.text),
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(12),
          filled: true,
          fillColor: kGrayLight,
          border: InputBorder.none,
          hintText: 'Password'));

  validate() async {
    if (_formKey.currentState!.validate()) {
      _profileDataNotifier!.setLoading(true);
      dynamic result =
          await _authServices.loginUser(context, email.text, password.text);
      if (result) {
        _profileDataNotifier!.setLoading(false);
        checkProfile(context);
        saveUser(context);
        saveEstate(context);
        saveCompany(context);
        saveGuard(context);
      } else {
        _profileDataNotifier!.setLoading(false);
      }
    }
  }
}
