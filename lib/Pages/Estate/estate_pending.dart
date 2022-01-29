import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/profile_helpers.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/helpers/sharedpreferences.dart';
import 'package:flutter_secentry/models/estate_details.dart';
import 'package:flutter_secentry/services/estate_service.dart';
import 'package:flutter_secentry/services/message_service.dart';
import 'package:flutter_secentry/widget/loading.dart';
import 'package:flutter_secentry/widget/toast.dart';
import 'package:provider/src/provider.dart';

class EstatePending extends StatefulWidget {
  const EstatePending({Key? key}) : super(key: key);

  @override
  State<EstatePending> createState() => _EstatePendingState();
}

class _EstatePendingState extends State<EstatePending> {
  final EstateServices _estateServices = EstateServices();
  final MessageServices _messageServices = MessageServices();
  int? count = 0;
  int? storedCount = 0;
  ProfileDataNotifier? _profileDataNotifier;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInt();
  }

  getInt() async {
    _messageServices.getAllMessage().then((value) {
      setState(() {
        count = value.count;
      });
    });

    SharedPreference().readInt('message').then((value) {
      storedCount = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    _profileDataNotifier = context.watch<ProfileDataNotifier>();
    return Scaffold(
      backgroundColor: kWhite,
      drawer: const Drawer(
        backgroundColor: kBlack,
      ),
      body: _profileDataNotifier!.loading
          ? LoadingScreen()
          : SingleChildScrollView(
              child: Padding(
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
                        child:
                            const Icon(Icons.person, color: kWhite, size: 25),
                      ),
                    ),
                    heightSpace(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name(_profileDataNotifier!.userProfile!.fullName),
                          style: TextStyle(fontSize: 25),
                        ),
                        widthSpace(40),
                        IconButton(
                          icon: const Icon(
                            Icons.notifications,
                            color: kPrimary,
                            size: 30,
                          ),
                          onPressed: () =>
                              Navigator.pushNamed(context, '/my_invitations'),
                        ),
                        count == storedCount
                            ? IconButton(
                                icon: const Icon(
                                  Icons.email,
                                  color: kPrimary,
                                  size: 30,
                                ),
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/messages'),
                              )
                            : GestureDetector(
                                onTap: () =>
                                    Navigator.pushNamed(context, '/messages'),
                                child: Stack(
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.email,
                                        color: kPrimary,
                                        size: 30,
                                      ),
                                      onPressed: () => Navigator.pushNamed(
                                          context, '/messages'),
                                    ),
                                    Container(
                                      width: 26,
                                      height: 26,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: kGreen),
                                      child: const Center(
                                        child: Text(
                                          '1',
                                          style: TextStyle(color: kWhite),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                      ],
                    ),
                    const Text(
                      'Your request is pending.',
                      style: TextStyle(fontSize: 14, color: kGray),
                    ),
                    heightSpace(100),
                    tapToRefresh(),
                    heightSpace(30),
                    // Center(
                    //   child: TextButton(
                    //     child: const Text(
                    //       'Rejoin',
                    //       style: TextStyle(fontSize: 20, color: kGreen),
                    //     ),
                    //     onPressed: () =>
                    //         Navigator.pushNamed(context, '/nofacility'),
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
    );
  }

  tapToRefresh() => Center(
        child: GestureDetector(
          onTap: () => checkAcceptedStatus(),
          child: Container(
            width: 250,
            height: 250,
            decoration:
                const BoxDecoration(color: kGreen, shape: BoxShape.circle),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Icon(
                  Icons.arrow_downward_outlined,
                  size: 40,
                  color: kWhite,
                ),
                const Text(
                  'Tap to Refresh',
                  style: TextStyle(color: kWhite, fontSize: 20),
                )
              ],
            ),
          ),
        ),
      );

  checkAcceptedStatus() async {
    _profileDataNotifier!.setLoading(true);
    _estateServices.getEstateDetail().then((value) {
      saveEstate(context);
      if (value.results?[0].accepted == true) {
        Navigator.pushNamed(context, '/estate_dashboard');
        _profileDataNotifier!.setLoading(false);
      } else {
        _profileDataNotifier!.setLoading(false);
        ToastUtils.showRedToast('Not yet accepted');
      }
    });
  }

  name(name) => 'Hi, ' + name.substring(0, name.indexOf(' '));
}
