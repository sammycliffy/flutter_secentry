import 'package:flutter/material.dart';
import 'package:flutter_secentry/Pages/authpages/new_password.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/services/auth_service.dart';
import 'package:flutter_secentry/widget/button.dart';
import 'package:flutter_secentry/widget/loading.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/src/provider.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  final TextEditingController _pinPutController = TextEditingController();
  final AuthServices _authServices = AuthServices();
  final FocusNode _pinPutFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  ProfileDataNotifier? _profileDataNotifier;

  @override
  Widget build(BuildContext context) {
    _profileDataNotifier = context.watch<ProfileDataNotifier>();
    return Scaffold(
        backgroundColor: kWhite,
        body: _profileDataNotifier!.loading
            ? const LoadingScreen()
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            heightSpace(100),
                            const Text(
                              'Verify Email',
                              style: TextStyle(fontSize: 40),
                            ),
                            heightSpace(20),
                            const Text(
                              'Enter the token that was sent to your email',
                              style: TextStyle(fontSize: 16, color: kGray),
                            ),
                            heightSpace(10),
                            Container(
                              color: Colors.white,
                              margin: const EdgeInsets.all(20.0),
                              padding: const EdgeInsets.all(20.0),
                              child: PinPut(
                                fieldsCount: 4,
                                onSubmit: (String pin) {
                                  validate(pin);
                                },
                                focusNode: _pinPutFocusNode,
                                controller: _pinPutController,
                                submittedFieldDecoration:
                                    _pinPutDecoration.copyWith(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                selectedFieldDecoration: _pinPutDecoration,
                                followingFieldDecoration:
                                    _pinPutDecoration.copyWith(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    color: kPrimary.withOpacity(.5),
                                  ),
                                ),
                              ),
                            ),
                            heightSpace(10),
                            CustomButton(text: 'Resend Code', validate: null),
                            heightSpace(50),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: background,
                      )
                    ],
                  ),
                ),
              ));
  }

  validate(otp) async {
    print(otp);
    if (_formKey.currentState!.validate()) {
      _profileDataNotifier!.setLoading(true);
      dynamic result = await _authServices.emailVerification(context, otp);
      if (result) {
        _profileDataNotifier!.setLoading(false);
        Navigator.pushNamed(context, '/login');
      } else {
        _profileDataNotifier!.setLoading(false);
      }
    }
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: kGrayLight),
      borderRadius: BorderRadius.circular(15.0),
    );
  }
}
