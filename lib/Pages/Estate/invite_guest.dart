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

class InviteGuest extends StatefulWidget {
  const InviteGuest({Key? key}) : super(key: key);

  @override
  State<InviteGuest> createState() => _InviteGuestState();
}

class _InviteGuestState extends State<InviteGuest> {
  final fullname = TextEditingController();
  final phone = TextEditingController();
  String? duration = 'Days';
  final _formKey = GlobalKey<FormState>();
  final visitingNumber = TextEditingController();
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
                            'Invite Guest',
                            style: TextStyle(fontSize: 40),
                          ),
                          heightSpace(30),
                          fullnameText(),
                          heightSpace(30),
                          phoneText(),
                          heightSpace(30),
                          durationWidget(),
                          heightSpace(10),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                                onPressed: () => Navigator.pushNamed(
                                    context, '/add_item_pass'),
                                child: const Text('Add Item pass',
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: kPrimary,
                                        fontWeight: FontWeight.bold))),
                          ),
                          heightSpace(20),
                          CustomButton(text: 'Continue', validate: validate),
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

  fullnameText() => TextFormField(
      controller: fullname,
      validator: (value) => FormValidation().stringValidation(fullname.text),
      decoration: const InputDecoration(
          fillColor: kGrayLight,
          filled: true,
          contentPadding: EdgeInsets.all(12),
          border: InputBorder.none,
          hintText: 'Full name'));

  phoneText() => TextFormField(
      controller: phone,
      validator: (value) => FormValidation().stringValidation(phone.text),
      decoration: const InputDecoration(
          fillColor: kGrayLight,
          filled: true,
          contentPadding: EdgeInsets.all(12),
          border: InputBorder.none,
          hintText: 'Phone number'));

  durationWidget() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TextFormField(
              keyboardType: TextInputType.number,
              controller: visitingNumber,
              onChanged: (value) {},
              // validator: (value) => checkMaxDuration(value),
              decoration: const InputDecoration(
                  // filled: true,
                  // fillColor: kGrayLight,
                  contentPadding: EdgeInsets.all(12),
                  // border: InputBorder.none,
                  hintText: 'Duration in numbers')),
        ),
        widthSpace(20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            color: kGrayLight,
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButtonFormField<String?>(
            decoration: const InputDecoration(enabledBorder: InputBorder.none),
            value: duration,
            iconSize: 24,
            elevation: 16,
            onChanged: (String? newValue) {
              setState(() {
                duration = newValue;
              });
            },
            items: <String?>[
              'Days',
              'Weeks',
              'Months',
            ].map<DropdownMenuItem<String?>>((String? value) {
              return DropdownMenuItem<String?>(
                value: value,
                child: Text(
                  value!,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

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
