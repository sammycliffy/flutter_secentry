import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/formvalidation.dart';
import 'package:flutter_secentry/helpers/providers/invitation.dart';
import 'package:flutter_secentry/widget/button.dart';
import 'package:provider/provider.dart';

class InviteGuest extends StatefulWidget {
  const InviteGuest({Key? key}) : super(key: key);

  @override
  State<InviteGuest> createState() => _InviteGuestState();
}

class _InviteGuestState extends State<InviteGuest> {
  final fullName = TextEditingController();
  final phone = TextEditingController();
  String? duration = ' Days';
  final _formKey = GlobalKey<FormState>();
  final visitingNumber = TextEditingController();
  final purposeOfVisit = TextEditingController();

  InvitationNotifier? _invitationNotifier;

  @override
  Widget build(BuildContext context) {
    _invitationNotifier = context.watch<InvitationNotifier>();
    return Scaffold(
      body: SingleChildScrollView(
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
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios)),
                    heightSpace(40),
                    const Text(
                      'Invite Guest',
                      style: TextStyle(fontSize: 40),
                    ),
                    heightSpace(30),
                    fullnameText(),
                    heightSpace(20),
                    phoneText(),
                    heightSpace(20),
                    purposeText(),
                    heightSpace(20),
                    durationWidget(),
                    heightSpace(10),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                          onPressed: () => addItemPass(),
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
      controller: fullName,
      validator: (value) => FormValidation().stringValidation(fullName.text),
      decoration: const InputDecoration(
          fillColor: kGrayLight,
          filled: true,
          contentPadding: EdgeInsets.all(12),
          border: InputBorder.none,
          hintText: 'Full name'));

  purposeText() => TextFormField(
      controller: purposeOfVisit,
      validator: (value) =>
          FormValidation().stringValidation(purposeOfVisit.text),
      decoration: const InputDecoration(
          fillColor: kGrayLight,
          filled: true,
          contentPadding: EdgeInsets.all(12),
          border: InputBorder.none,
          hintText: 'Purpose of visit'));

  phoneText() => TextFormField(
      controller: phone,
      keyboardType: TextInputType.number,
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
              validator: (value) =>
                  FormValidation().stringValidation(visitingNumber.text),
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
              ' Days',
              ' Weeks',
              ' Months',
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

  addItemPass() {
    if (_formKey.currentState!.validate()) {
      _invitationNotifier!.setItemPass(
          fullName.text,
          phone.text,
          '${visitingNumber.text} +  $duration',
          [],
          null,
          null,
          null,
          purposeOfVisit.text);
      Navigator.pushNamed(context, '/add_item_pass');
    }
  }

  // validate() => Navigator.pushNamed(context, '/pending_request');
  validate() async {
    if (_formKey.currentState!.validate()) {
      _invitationNotifier!.setItemPass(
          fullName.text,
          phone.text,
          '${visitingNumber.text} +  $duration',
          [],
          null,
          null,
          null,
          purposeOfVisit.text);
      Navigator.pushNamed(context, '/visitor_info');
    }
  }
}
