import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:provider/src/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CompanyUserBadge extends StatelessWidget {
  const CompanyUserBadge({Key? key}) : super(key: key);
  static ProfileDataNotifier? _profileDataNotifier;
  @override
  Widget build(BuildContext context) {
    _profileDataNotifier = context.watch<ProfileDataNotifier>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightSpace(30),
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context),
              ),
              heightSpace(20),
              const Text(
                'User Badge',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              heightSpace(20),
              Text(
                '${_profileDataNotifier!.userProfile!.fullName}',
                style: TextStyle(fontSize: 23),
              ),
              heightSpace(20),
              text('Company',
                  '${_profileDataNotifier!.companyDetails?.results?[0].companyName}'),
              Divider(),
              heightSpace(20),
              text(
                  'Phone', '${_profileDataNotifier!.userProfile!.phoneNumber}'),
              Divider(),
              text('Gender', '${_profileDataNotifier!.userProfile!.gender}'),
              Divider(),
              heightSpace(20),
              Center(
                child: QrImage(
                  data:
                      _profileDataNotifier!.userProfile!.phoneNumber.toString(),
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  text(title, text) => Column(
        // ignore: prefer_const_literals_to_create_immutables
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: kGray, fontSize: 15),
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 20),
          )
        ],
      );
}
