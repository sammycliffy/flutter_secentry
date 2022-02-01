import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/formvalidation.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/services/estate_service.dart';
import 'package:flutter_secentry/services/guard/guard_services.dart';
import 'package:flutter_secentry/widget/green_button.dart';
import 'package:flutter_secentry/widget/loading.dart';
import 'package:provider/provider.dart';

class UserExit extends StatefulWidget {
  const UserExit({Key? key}) : super(key: key);

  @override
  State<UserExit> createState() => _UserExitState();
}

class _UserExitState extends State<UserExit> {
  final code = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GuardServices _guardServices = GuardServices();
  ProfileDataNotifier? _profileDataNotifier;
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      code.text = barcodeScanRes;
    });
  }

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
                              icon: const Icon(Icons.arrow_back_ios)),
                          heightSpace(40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Text(
                                'User exit',
                                style: TextStyle(fontSize: 40),
                              ),
                              IconButton(
                                  onPressed: () => Navigator.pushNamed(
                                      context, '/estate_company_user_exit'),
                                  icon: Icon(
                                    Icons.house,
                                    size: 30,
                                    color: kGreen,
                                  ))
                            ],
                          ),
                          heightSpace(80),
                          visitorCode(),
                          heightSpace(50),
                          GreenCustomButton(
                              text: 'Validate code', validate: validate),
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

  visitorCode() => TextFormField(
      controller: code,
      validator: (value) => FormValidation().stringValidation(code.text),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(12),
          border: const OutlineInputBorder(
            borderSide: BorderSide(width: 5.0),
          ),
          suffixIcon: IconButton(
              onPressed: () => scanBarcodeNormal(),
              icon: const Icon(Icons.qr_code)),
          hintText: 'Visitor code'));

  validate() async {
    if (_formKey.currentState!.validate()) {
      _profileDataNotifier!.setLoading(true);
      dynamic result = await _guardServices.exitUser(context, code.text);
      if (result) {
        _profileDataNotifier!.setLoading(false);
        Navigator.pushNamed(context, '/no_facility_invitation');
      } else {
        _profileDataNotifier!.setLoading(false);
      }
    }
  }
}
