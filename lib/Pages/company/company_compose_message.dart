import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/formvalidation.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/services/company/company_message_services.dart';
import 'package:flutter_secentry/widget/green_button.dart';
import 'package:flutter_secentry/widget/loading.dart';
import 'package:provider/src/provider.dart';

class CompanyComposeMessage extends StatefulWidget {
  const CompanyComposeMessage({Key? key}) : super(key: key);

  @override
  State<CompanyComposeMessage> createState() => _CompanyComposeMessageState();
}

class _CompanyComposeMessageState extends State<CompanyComposeMessage> {
  static TextEditingController message = TextEditingController();
  static ProfileDataNotifier? _profileDataNotifier;
  static final _formkey = GlobalKey<FormState>();
  static final CompanyMessageServices _messageServices =
      CompanyMessageServices();
  @override
  Widget build(BuildContext context) {
    _profileDataNotifier = context.watch<ProfileDataNotifier>();
    return Scaffold(
      body: _profileDataNotifier!.loading
          ? const LoadingScreen()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Form(
                  key: _formkey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heightSpace(50),
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back_ios)),
                        heightSpace(20),
                        const Text(
                          'Compose Message',
                          style: TextStyle(fontSize: 30),
                        ),
                        heightSpace(5),
                        const Text(
                          'Type in your message.',
                          style: TextStyle(color: kGray, fontSize: 16),
                        ),
                        heightSpace(50),
                        composeText(),
                        heightSpace(30),
                        GreenCustomButton(
                            text: 'Send to Admin', validate: validate)
                      ]),
                ),
              ),
            ),
    );
  }

  composeText() => TextFormField(
      maxLines: 6,
      controller: message,
      keyboardType: TextInputType.text,
      validator: (value) => FormValidation().stringValidation(message.text),
      decoration: const InputDecoration(
        fillColor: kGrayLight,
        filled: true,
        contentPadding: EdgeInsets.all(12),
        border: InputBorder.none,
      ));

  validate() async {
    if (_formkey.currentState!.validate()) {
      _profileDataNotifier!.setLoading(true);
      dynamic result =
          await _messageServices.sendMessage(BuildContext, message.text);
      if (result) {
        _profileDataNotifier!.setLoading(false);

        message.clear();
      } else {
        _profileDataNotifier!.setLoading(false);
      }
    }
  }
}
