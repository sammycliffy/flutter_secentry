import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/services/company/company_services.dart';
import 'package:flutter_secentry/services/estate_service.dart';
import 'package:flutter_secentry/widget/button.dart';
import 'package:provider/src/provider.dart';

class CompanyJoinFacility extends StatefulWidget {
  const CompanyJoinFacility({Key? key}) : super(key: key);

  @override
  State<CompanyJoinFacility> createState() => _CompanyJoinFacilityState();
}

class _CompanyJoinFacilityState extends State<CompanyJoinFacility> {
  final CompanyServices _companyServices = CompanyServices();

  ProfileDataNotifier? _profileDataNotifier;
  @override
  Widget build(BuildContext context) {
    _profileDataNotifier = context.watch<ProfileDataNotifier>();
    return Scaffold(
      backgroundColor: kWhite,
      drawer: const Drawer(
        backgroundColor: kBlack,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightSpace(100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name(_profileDataNotifier!.userProfile!.fullName),
                    style: const TextStyle(fontSize: 40),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.notifications,
                          color: kPrimary,
                          size: 40,
                        ),
                        onPressed: () =>
                            Navigator.pushNamed(context, '/my_invitations'),
                      ),
                      widthSpace(40),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, '/my_account'),
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: kPrimary,
                          ),
                          child:
                              const Icon(Icons.person, color: kWhite, size: 20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Text(
                'No facility yet,',
                style: TextStyle(fontSize: 17, color: kGray),
              ),
              heightSpace(100),
              Column(
                children: [
                  SizedBox(
                    width: 400,
                    height: 200,
                    child: noEstateImage,
                  ),
                  heightSpace(20),
                  const Text(
                    'For Company staff who wants to be part of their companies. You need a unique company Id from your company manager',
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              heightSpace(80),
              CustomButton(text: 'Join Company', validate: validateCompany)
            ],
          ),
        ),
      ),
    );
  }

  validateCompany() {
    Navigator.pushNamed(context, '/company_code');
  }
}

name(name) {
  try {
    return 'Hi, ' + name.substring(0, name.indexOf(' '));
  } catch (e) {
    print(e.toString());
    return name;
  }
}
