import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/formvalidation.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/services/guard/guard_services.dart';
import 'package:flutter_secentry/widget/green_button.dart';
import 'package:flutter_secentry/widget/loading.dart';
import 'package:provider/provider.dart';

class GuardJoinFacility extends StatefulWidget {
  const GuardJoinFacility({Key? key}) : super(key: key);

  @override
  State<GuardJoinFacility> createState() => _GuardJoinFacilityState();
}

class _GuardJoinFacilityState extends State<GuardJoinFacility> {
  final code = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GuardServices _guardServices = GuardServices();
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
                            'Guard Join Facility',
                            style: TextStyle(fontSize: 40),
                          ),
                          heightSpace(80),
                          estateCode(),
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

  estateCode() => TextFormField(
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
      dynamic result = await _guardServices.joinEstate(context, code.text);
      if (result == true) {
        _profileDataNotifier!.setLoading(false);
        Navigator.pushNamed(context, '/guard_dashboard');
      } else {
        _profileDataNotifier!.setLoading(false);
      }
    }
  }
}
