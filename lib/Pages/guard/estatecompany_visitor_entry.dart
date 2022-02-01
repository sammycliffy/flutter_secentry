import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_secentry/Pages/guard/entry_info.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/formvalidation.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/services/guard/estate_company_guard.dart';
import 'package:flutter_secentry/services/guard/guard_services.dart';
import 'package:flutter_secentry/widget/green_button.dart';
import 'package:flutter_secentry/widget/loading.dart';
import 'package:provider/provider.dart';

class EstateCompanyVisitorEntryApproval extends StatefulWidget {
  const EstateCompanyVisitorEntryApproval({Key? key}) : super(key: key);

  @override
  State<EstateCompanyVisitorEntryApproval> createState() =>
      _EstateCompanyVisitorEntryApprovalState();
}

class _EstateCompanyVisitorEntryApprovalState
    extends State<EstateCompanyVisitorEntryApproval> {
  final code = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final EstateCompanyGuardServices _guardServices =
      EstateCompanyGuardServices();
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
                          const Text(
                            'Visitor entry',
                            style: TextStyle(fontSize: 40),
                          ),
                          heightSpace(5),
                          const Text(
                            'For companies inside an estate',
                            style: TextStyle(color: kGray),
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
      _guardServices.searchVisitor(context, code.text).then((value) {
        _profileDataNotifier!.setLoading(false);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EntryInfo(
                      visitorModel: value,
                    )));
      }).whenComplete(() => _profileDataNotifier!.setLoading(false));
    }
  }
}
