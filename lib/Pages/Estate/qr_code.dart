// ignore_for_file: use_key_in_widget_constructors

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/models/visitor_entry_model.dart';
import 'package:flutter_secentry/widget/green_button.dart';
import 'package:flutter_secentry/widget/toast.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EstateQRCode extends StatelessWidget {
  final VisitorEntryModel? visitorEntryModel;
  const EstateQRCode({@required this.visitorEntryModel});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            children: [
              heightSpace(80),
              const Center(
                child: Text(
                  'Visitor Access Pass',
                  style: TextStyle(fontSize: 40),
                ),
              ),
              heightSpace(10),
              const Text(
                'Your visitor will present this code at the gate',
                style: TextStyle(fontSize: 18, color: kGray),
              ),
              heightSpace(20),
              heightSpace(20),
              generateQRcode(visitorEntryModel!.visitorId!),
              heightSpace(30),
              Text(visitorEntryModel!.visitorId!,
                  style: TextStyle(fontSize: 25)),
              heightSpace(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      IconButton(
                          onPressed: () =>
                              copyToClipboard(visitorEntryModel!.visitorId!),
                          icon: const Icon(
                            Icons.copy,
                            size: 30,
                            color: kGreen,
                          )),
                      const Text('Copy code')
                    ],
                  ),
                  widthSpace(20),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () => share(visitorEntryModel!.visitorId),
                          icon: const Icon(
                            Icons.share,
                            size: 30,
                            color: kGreen,
                          )),
                      const Text('Share code')
                    ],
                  )
                ],
              ),
              heightSpace(50),
              GreenCustomButton(
                text: 'Finish',
                validate: () => Navigator.pushNamed(context, '/guest_entry'),
              )
            ],
          ),
        ),
      ),
    );
  }

  generateQRcode(String code) {
    return QrImage(
      data: code,
      version: QrVersions.auto,
      size: 220.0,
    );
  }

  copyToClipboard(String text) {
    return FlutterClipboard.copy(text).then((value) {
      ToastUtils.showToastCenter('copied');
    });
  }

  Future<void> share(code) async {
    await FlutterShare.share(
        title: 'Secentry Visitor ID',
        text: code,
        linkUrl: 'secentry.com',
        chooserTitle: 'Secentry Visitor ID');
  }
}
