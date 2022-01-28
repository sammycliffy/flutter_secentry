import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/services/auth_service.dart';
import 'package:provider/provider.dart';

class CompanyDashoard extends StatefulWidget {
  const CompanyDashoard({Key? key}) : super(key: key);

  @override
  State<CompanyDashoard> createState() => _CompanyDashoardState();
}

class _CompanyDashoardState extends State<CompanyDashoard> {
  final code = TextEditingController();
  final AuthServices _authServices = AuthServices();
  ProfileDataNotifier? _profileDataNotifier;

  @override
  Widget build(BuildContext context) {
    _profileDataNotifier = context.watch<ProfileDataNotifier>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heightSpace(80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name(_profileDataNotifier!.userProfile!.fullName),
                        style: const TextStyle(fontSize: 25),
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
                              child: const Icon(Icons.person,
                                  color: kWhite, size: 20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  heightSpace(50),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, '/company_information'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      width: double.infinity,
                      height: 120,
                      decoration: BoxDecoration(
                          color: kPrimary,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          greenFacilityIcon,
                          widthSpace(20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              heightSpace(30),
                              Text(
                                '${_profileDataNotifier!.companyDetails!.results?[0].companyName}',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: kWhite),
                              ),
                              heightSpace(5),
                              const Text(
                                'Tap to view company info',
                                style: TextStyle(fontSize: 16, color: kWhite),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  heightSpace(50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      cellIcon(
                          guestEntry, 'Guest Entry', '/company_guest_entry'),
                      cellIcon(
                          emergencyIcon, 'Emergency', '/company_emergency'),
                      cellIcon(reportIcon, 'Report', null)
                    ],
                  ),
                  heightSpace(50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      cellIcon(newsIcon, 'News', '/company_news'),
                      cellIcon(badgeIcon, 'Badge', '/company_badge'),
                      cellIcon(messageIcon, 'Messages', '/company_messages')
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  cellIcon(image, text, routeName) => Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, routeName),
            child: Card(
              child: Container(
                width: 100,
                height: 100,
                padding: const EdgeInsets.all(10),
                child: image,
              ),
            ),
          ),
          heightSpace(10),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      );

  name(name) => 'Hi, ' + name.substring(0, name.indexOf(' '));
}
