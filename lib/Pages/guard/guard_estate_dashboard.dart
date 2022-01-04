import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:provider/src/provider.dart';

class GuardEstateDashboard extends StatefulWidget {
  const GuardEstateDashboard({Key? key}) : super(key: key);

  @override
  _GuardEstateDashboardState createState() => _GuardEstateDashboardState();
}

class _GuardEstateDashboardState extends State<GuardEstateDashboard> {
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
                  heightSpace(30),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/my_account'),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: kPrimary,
                      ),
                      child: const Icon(Icons.person, color: kWhite, size: 30),
                    ),
                  ),
                  heightSpace(30),
                  Text(
                    '${_profileDataNotifier!.userProfile!.fullName}',
                    style: TextStyle(fontSize: 40),
                  ),
                  heightSpace(30),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/guest_entry'),
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
                              const Text(
                                'Golf Estate',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: kWhite),
                              ),
                              heightSpace(5),
                              const Text(
                                'Tap to view estate info',
                                style: TextStyle(fontSize: 16, color: kWhite),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  heightSpace(60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      block(
                          const Icon(
                            Icons.arrow_back,
                            color: kWhite,
                            size: 50,
                          ),
                          'User Entry',
                          kPrimary,
                          '/user_entry'),
                      block(
                          const Icon(
                            Icons.arrow_forward,
                            color: kWhite,
                            size: 50,
                          ),
                          'User Exit',
                          kPrimary,
                          '/user_exit')
                    ],
                  ),
                  heightSpace(50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      block(
                          const Icon(
                            Icons.person,
                            color: kWhite,
                            size: 50,
                          ),
                          'Visitor Entry',
                          kPrimary,
                          '/visitor_entry'),
                      block(
                          const Icon(
                            Icons.person,
                            color: kWhite,
                            size: 50,
                          ),
                          'Vistor Exit',
                          kPrimary,
                          '/visitor_exit')
                    ],
                  ),
                ],
              ),
            ),
            heightSpace(30),
            Align(alignment: Alignment.bottomRight, child: background)
          ],
        ),
      ),
    );
  }

  block(icon, text, color, routeName) => Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, routeName),
            child: Card(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(5)),
                child: Center(child: icon),
              ),
            ),
          ),
          heightSpace(10),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )
        ],
      );
}
