import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/formvalidation.dart';
import 'package:flutter_secentry/helpers/profile_helpers.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/services/guard_company/guard_company_services.dart';
import 'package:flutter_secentry/widget/green_button.dart';
import 'package:flutter_secentry/widget/loading.dart';
import 'package:provider/provider.dart';

class GuardJoinCompany extends StatefulWidget {
  const GuardJoinCompany({Key? key}) : super(key: key);

  @override
  State<GuardJoinCompany> createState() => _GuardJoinCompanyState();
}

class _GuardJoinCompanyState extends State<GuardJoinCompany> {
  final code = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final CompanyGuardServices _guardServices = CompanyGuardServices();
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
                          IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.arrow_back_ios)),
                          heightSpace(40),
                          const Text(
                            'Guard Join Company',
                            style: TextStyle(fontSize: 30),
                          ),
                          heightSpace(80),
                          companyCode(),
                          heightSpace(50),
                          GreenCustomButton(
                              text: 'Join Company', validate: validate),
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
      validator: (value) => FormValidation().stringValidation(code.text),
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(12),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 5.0),
          ),
          hintText: 'Enter code'));

  validate() async {
    if (_formKey.currentState!.validate()) {
      _profileDataNotifier!.setLoading(true);
      dynamic result = await _guardServices.joinCompany(context, code.text);
      if (result == true) {
        saveUser(context);
        saveGuard(context);
        _profileDataNotifier!.setLoading(false);
        Navigator.pushNamed(context, '/guard_dashboard');
      } else {
        _profileDataNotifier!.setLoading(false);
      }
    }
  }
}
