import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/formvalidation.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/services/auth_service.dart';
import 'package:flutter_secentry/widget/loading.dart';
import 'package:provider/provider.dart';

class PendingRequest extends StatefulWidget {
  const PendingRequest({Key? key}) : super(key: key);

  @override
  State<PendingRequest> createState() => _PendingRequestState();
}

class _PendingRequestState extends State<PendingRequest> {
  final code = TextEditingController();
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heightSpace(70),
                        const Text(
                          'Hi Samuel',
                          style: TextStyle(fontSize: 40),
                        ),
                        heightSpace(50),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          width: double.infinity,
                          height: 120,
                          decoration: BoxDecoration(
                              color: kGreen,
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            children: [
                              facilityIcon,
                              widthSpace(20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  heightSpace(30),
                                  const Text(
                                    'Golf Estate',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: kPrimary),
                                  ),
                                  heightSpace(5),
                                  const Text(
                                    'Request to join facility pending',
                                    style: TextStyle(
                                        fontSize: 16, color: kPrimary),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        heightSpace(100),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, '/estate_dashboard'),
                          child: Center(
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: guestIcon,
                            ),
                          ),
                        ),
                        heightSpace(20),
                        const Center(
                          child: Text(
                            'Your invitations will \nappear here',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, color: kGray),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  estateCode() => TextFormField(
      controller: code,
      validator: (value) => FormValidation().emailValidation(code.text),
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(12),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 5.0),
          ),
          hintText: 'Enter code'));

  // validate() async {
  //   Navigator.pushNamed(context, '/nofacility');
  //   if (_formKey.currentState!.validate()) {
  //     _profileDataNotifier!.setLoading(true);

  //     dynamic result =
  //         await _authServices.loginUser(context, email.text, password.text);
  //     if (result) {
  //       Navigator.pushNamed(context, '/no_facility_invitation');
  //     }
  //   }
  // }
}
