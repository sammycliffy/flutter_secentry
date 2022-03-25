import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/services/auth_service.dart';
import 'package:provider/provider.dart';

class EstateDashoard extends StatefulWidget {
  const EstateDashoard({Key? key}) : super(key: key);

  @override
  State<EstateDashoard> createState() => _EstateDashoardState();
}

class _EstateDashoardState extends State<EstateDashoard> {
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
                        Navigator.pushNamed(context, '/estate_information'),
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
                                '${_profileDataNotifier!.estateDetails!.results?[0].estateName}',
                                style: const TextStyle(
                                    fontSize: 20,
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
                  heightSpace(50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      cellIcon(guestEntry, 'Guest Entry', '/guest_entry'),
                      cellIcon(emergencyIcon, 'Emergency', '/emergency'),
                      cellIcon(reportIcon, 'Report', '/coming_soon')
                    ],
                  ),
                  heightSpace(50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      cellIcon(newsIcon, 'News', '/news'),
                      cellIcon(badgeIcon, 'Badge', '/user_badge'),
                      cellIcon(messageIcon, 'Messages', '/messages')
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

  name(name) {
    try {
      return 'Hi, ' + name.substring(0, name.indexOf(' '));
    } catch (e) {
      print(e.toString());
      return name;
    }
  }
}
