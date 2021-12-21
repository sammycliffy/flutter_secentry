import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/formvalidation.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/services/company/company_services.dart';
import 'package:flutter_secentry/widget/green_button.dart';
import 'package:flutter_secentry/widget/loading.dart';
import 'package:provider/provider.dart';

class CompanyCode extends StatefulWidget {
  const CompanyCode({Key? key}) : super(key: key);

  @override
  State<CompanyCode> createState() => _CompanyCodeState();
}

class _CompanyCodeState extends State<CompanyCode> {
  final code = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final CompanyServices _companyServices = CompanyServices();
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
                            'Hi Samuel',
                            style: TextStyle(fontSize: 40),
                          ),
                          heightSpace(80),
                          companyCode(),
                          heightSpace(50),
                          GreenCustomButton(
                              text: 'Join Facility', validate: validate),
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

  companyCode() => TextFormField(
      controller: code,
      validator: (value) => FormValidation().emailValidation(code.text),
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(12),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 5.0),
          ),
          hintText: 'Enter code'));

  validate() async {
    Navigator.pushNamed(context, '/nofacility');
    if (_formKey.currentState!.validate()) {
      _profileDataNotifier!.setLoading(true);
      dynamic result =
          await _companyServices.companyRegistration(context, code.text);
      if (result) {
        _profileDataNotifier!.setLoading(true);
        Navigator.pushNamed(context, '/no_facility_invitation');
      } else {
        _profileDataNotifier!.setLoading(true);
      }
    }
  }
}
