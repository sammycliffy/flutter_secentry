import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/helpers/sharedpreferences.dart';
import 'package:flutter_secentry/models/estate_details.dart';
import 'package:flutter_secentry/services/estate_service.dart';
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

  ProfileDataNotifier? _profileDataNotifier;
  @override
  Widget build(BuildContext context) {
    _profileDataNotifier = context.watch<ProfileDataNotifier>();
    return Scaffold(
      backgroundColor: kWhite,
      drawer: const Drawer(
        backgroundColor: kBlack,
      ),
      appBar: AppBar(
        backgroundColor: kWhite,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: kBlack),
      ),
      body: _profileDataNotifier!.loading
          ? LoadingScreen()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heightSpace(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hi ${_profileDataNotifier!.userProfile!.fullName},',
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
                        IconButton(
                          icon: const Icon(
                            Icons.message,
                            color: kPrimary,
                            size: 30,
                          ),
                          onPressed: () =>
                              Navigator.pushNamed(context, '/messages'),
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
                  'Tap to refresh',
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
      if (value.results?[0].accepted == true) {
        Navigator.pushNamed(context, '/estate_dashboard');
        _profileDataNotifier!.setLoading(false);
      } else {
        _profileDataNotifier!.setLoading(false);
        ToastUtils.showRedToast('Not yet accepted');
      }
    });
  }
}
