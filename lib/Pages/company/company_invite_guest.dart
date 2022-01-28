import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/formvalidation.dart';
import 'package:flutter_secentry/helpers/providers/invitation.dart';
import 'package:flutter_secentry/widget/button.dart';
import 'package:provider/provider.dart';

class CompanyInviteGuest extends StatefulWidget {
  const CompanyInviteGuest({Key? key}) : super(key: key);

  @override
  State<CompanyInviteGuest> createState() => _CompanyInviteGuestState();
}

class _CompanyInviteGuestState extends State<CompanyInviteGuest> {
  final fullName = TextEditingController();
  final phone = TextEditingController();
  String? duration = ' Days';
  final _formKey = GlobalKey<FormState>();
  final visitingNumber = TextEditingController();
  final purposeOfVisit = TextEditingController();
  final vehicleColor = TextEditingController();
  final vehiclePlate = TextEditingController();
  final vehicleModel = TextEditingController();

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
                    heightSpace(60),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back_ios)),
                        widthSpace(40),
                        const Text(
                          'Invite Guest',
                          style: TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                    heightSpace(50),
                    fullnameText(),
                    heightSpace(20),
                    phoneText(),
                    heightSpace(20),
                    purposeText(),
                    heightSpace(20),
                    Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: kGrayLight, width: 3)),
                        child: Column(children: [
                          Text('Vehicle Details (Optional)'),
                          heightSpace(20),
                          vehicleColorText(),
                          heightSpace(20),
                          vehicleModelText(),
                          heightSpace(20),
                          vehiclePlateText(),
                          heightSpace(20),
                        ])),
                    heightSpace(20),
                    durationWidget(),
                    heightSpace(30),
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
                    heightSpace(30),
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
  vehicleColorText() => TextFormField(
      controller: vehicleColor,
      keyboardType: TextInputType.number,
      validator: (value) => null,
      decoration: const InputDecoration(
          fillColor: kGrayLight,
          filled: true,
          contentPadding: EdgeInsets.all(12),
          border: InputBorder.none,
          hintText: 'Vehicle Color'));

  vehicleModelText() => TextFormField(
      controller: vehicleModel,
      keyboardType: TextInputType.number,
      validator: (value) => null,
      decoration: const InputDecoration(
          fillColor: kGrayLight,
          filled: true,
          contentPadding: EdgeInsets.all(12),
          border: InputBorder.none,
          hintText: 'Vehicle Model'));

  vehiclePlateText() => TextFormField(
      controller: vehiclePlate,
      keyboardType: TextInputType.number,
      validator: (value) => null,
      decoration: const InputDecoration(
          fillColor: kGrayLight,
          filled: true,
          contentPadding: EdgeInsets.all(12),
          border: InputBorder.none,
          hintText: 'Vehicle Plate no'));
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
              // ' Weeks',
              // ' Months',
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
          visitingNumber.text,
          [],
          null,
          null,
          null,
          purposeOfVisit.text,
          vehicleModel.text,
          vehiclePlate.text,
          vehicleColor.text);
      Navigator.pushNamed(context, '/company_item_pass');
    }
  }

  // validate() => Navigator.pushNamed(context, '/pending_request');
  validate() async {
    if (_formKey.currentState!.validate()) {
      _invitationNotifier!.setItemPass(
          fullName.text,
          phone.text,
          visitingNumber.text,
          [],
          null,
          null,
          null,
          purposeOfVisit.text,
          vehicleModel.text,
          vehiclePlate.text,
          vehicleColor.text);
      Navigator.pushNamed(context, '/company_visitor_info');
    }
  }
}
