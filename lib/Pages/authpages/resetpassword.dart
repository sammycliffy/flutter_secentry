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

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final email = TextEditingController();
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
                          heightSpace(120),
                          const Text(
                            'Reset Password',
                            style: TextStyle(fontSize: 40),
                          ),
                          heightSpace(20),
                          emailText(),
                          heightSpace(20),
                          heightSpace(50),
                          CustomButton(text: 'Validate', validate: validate),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/login'),
                                child: const Text('back to login',
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

  emailText() => TextFormField(
      controller: email,
      validator: (value) => FormValidation().emailValidation(email.text),
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(12),
          filled: true,
          fillColor: kGrayLight,
          border: InputBorder.none,
          hintText: 'Email'));

  validate() async {
    if (_formKey.currentState!.validate()) {
      _profileDataNotifier!.setLoading(true);
      dynamic result = await _authServices.passwordReset(context, email.text);
      if (result) {
        _profileDataNotifier!.setLoading(false);
        Navigator.pushNamed(context, '/otp_page');
      } else {
        _profileDataNotifier!.setLoading(false);
      }
    }
  }
}
