import 'package:flutter/material.dart';
import 'package:flutter_secentry/Pages/Estate/qr_code.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/formvalidation.dart';
import 'package:flutter_secentry/helpers/providers/invitation.dart';
import 'package:flutter_secentry/services/invitation_services.dart';
import 'package:flutter_secentry/widget/loading.dart';
import 'package:provider/provider.dart';

class VisitorInfo extends StatefulWidget {
  const VisitorInfo({Key? key}) : super(key: key);

  @override
  State<VisitorInfo> createState() => _VisitorInfoState();
}

class _VisitorInfoState extends State<VisitorInfo> {
  final country = TextEditingController();
  final state = TextEditingController();
  final address = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GuestEntryServices _guestEntryServices = GuestEntryServices();
  InvitationNotifier? _invitationNotifier;

  @override
  Widget build(BuildContext context) {
    _invitationNotifier = context.watch<InvitationNotifier>();
    return Scaffold(
      body: _invitationNotifier!.loading
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
                          IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.arrow_back_ios)),
                          heightSpace(40),
                          const Text(
                            'Address info',
                            style: TextStyle(fontSize: 40),
                          ),
                          heightSpace(50),
                          titleText(),
                          heightSpace(20),
                          quantityText(),
                          heightSpace(20),
                          descriptionText(),
                          heightSpace(30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [blueButton(), whiteButton()],
                          )
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

  blueButton() => GestureDetector(
        onTap: () => save(),
        child: Container(
          width: 150,
          height: 40,
          decoration: BoxDecoration(
              color: kPrimary, borderRadius: BorderRadius.circular(5)),
          child: const Center(
            child: Text(
              'Save',
              style: TextStyle(color: kWhite, fontSize: 18),
            ),
          ),
        ),
      );

  whiteButton() => GestureDetector(
        onTap: () => skip(),
        child: Container(
          width: 150,
          height: 40,
          decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: kPrimary, width: 3)),
          child: const Center(
            child: Text(
              'Skip',
              style: TextStyle(color: kPrimary, fontSize: 18),
            ),
          ),
        ),
      );

  skip() async {
    _invitationNotifier!.setLoading(true);
    dynamic result = await _guestEntryServices.inviteGuest(
        context,
        _invitationNotifier!.fullName!,
        address.text,
        _invitationNotifier!.phoneNumber!,
        _invitationNotifier!.purposeOfVisit!,
        _invitationNotifier!.duration,
        _invitationNotifier!.items);
    if (result != false) {
      _invitationNotifier!.setLoading(false);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EstateQRCode(visitorEntryModel: result)));
    } else {
      _invitationNotifier!.setLoading(false);
    }
  }

  save() async {
    if (_formKey.currentState!.validate()) {
      _invitationNotifier!.setLoading(true);
      _invitationNotifier!.setItemPass(
          _invitationNotifier!.fullName,
          _invitationNotifier!.phoneNumber,
          _invitationNotifier!.duration,
          _invitationNotifier!.items,
          country.text,
          state.text,
          address.text,
          _invitationNotifier!.purposeOfVisit);
      dynamic result = await _guestEntryServices.inviteGuest(
          context,
          _invitationNotifier!.fullName!,
          address.text,
          _invitationNotifier!.phoneNumber!,
          _invitationNotifier!.purposeOfVisit!,
          _invitationNotifier!.purposeOfVisit,
          _invitationNotifier!.items);
      if (result != false) {
        _invitationNotifier!.setLoading(false);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EstateQRCode(visitorEntryModel: result)));
      } else {
        _invitationNotifier!.setLoading(false);
      }
    }
  }

  titleText() => TextFormField(
      controller: country,
      validator: (value) => FormValidation().stringValidation(country.text),
      decoration: const InputDecoration(
          fillColor: kGrayLight,
          filled: true,
          contentPadding: EdgeInsets.all(12),
          border: InputBorder.none,
          hintText: 'Country'));

  quantityText() => TextFormField(
      controller: state,
      keyboardType: TextInputType.number,
      validator: (value) => FormValidation().stringValidation(state.text),
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(12),
          fillColor: kGrayLight,
          filled: true,
          border: InputBorder.none,
          hintText: 'State'));

  descriptionText() => TextFormField(
      // maxLines: 5,
      controller: address,
      keyboardType: TextInputType.text,
      validator: (value) => FormValidation().stringValidation(address.text),
      decoration: const InputDecoration(
          fillColor: kGrayLight,
          filled: true,
          contentPadding: EdgeInsets.all(12),
          border: InputBorder.none,
          hintText: 'Description'));
}
