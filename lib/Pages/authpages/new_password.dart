import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/formvalidation.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/services/auth_service.dart';
import 'package:flutter_secentry/widget/button.dart';
import 'package:flutter_secentry/widget/loading.dart';
import 'package:flutter_secentry/widget/toast.dart';
import 'package:provider/provider.dart';

class NewPassword extends StatefulWidget {
  final String? token;
  const NewPassword({Key? key, @required this.token}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final email = TextEditingController();
  final password = TextEditingController();
  final password1 = TextEditingController();
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
                            'New Password',
                            style: TextStyle(fontSize: 40),
                          ),
                          heightSpace(20),
                          passwordText(),
                          heightSpace(20),
                          password1Text(),
                          heightSpace(50),
                          CustomButton(text: 'Update', validate: validate),
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
  password1Text() => TextFormField(
      obscureText: true,
      controller: password1,
      validator: (value) => FormValidation().passwordValidation(password1.text),
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(12),
          filled: true,
          fillColor: kGrayLight,
          border: InputBorder.none,
          hintText: 'Confirm Password'));

  validate() async {
    if (_formKey.currentState!.validate()) {
      if (password.text != password1.text) {
        ToastUtils.showRedToast('Passwords do not match');
      } else {
        _profileDataNotifier!.setLoading(true);
        dynamic result = await _authServices.newPassword(
            context, widget.token!, password.text);
        if (result) {
          _profileDataNotifier!.setLoading(false);
          ToastUtils.showGreenToast('Password update successfully');
          Navigator.pushNamed(context, '/login');
        } else {
          _profileDataNotifier!.setLoading(false);
        }
      }
    }
  }
}
