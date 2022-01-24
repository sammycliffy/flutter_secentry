import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/services/company/company_services.dart';
import 'package:flutter_secentry/widget/loading.dart';
import 'package:flutter_secentry/widget/toast.dart';
import 'package:provider/src/provider.dart';

class CompanyPending extends StatefulWidget {
  const CompanyPending({Key? key}) : super(key: key);

  @override
  State<CompanyPending> createState() => _CompanyPendingState();
}

class _CompanyPendingState extends State<CompanyPending> {
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
                        Stack(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.email,
                                color: kPrimary,
                                size: 30,
                              ),
                              onPressed: () => Navigator.pushNamed(
                                  context, '/company_messages'),
                            ),
                            Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: kGreen),
                              child: Center(
                                child: Text(
                                  '1',
                                  style: TextStyle(color: kWhite),
                                ),
                              ),
                            )
                          ],
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
    _companyServices.getCompanyDetail().then((value) {
      // saveCompany(context);
      if (value.results?[0].accepted == true) {
        Navigator.pushNamed(context, '/company_dashboard');
        _profileDataNotifier!.setLoading(false);
      } else {
        _profileDataNotifier!.setLoading(false);
        ToastUtils.showRedToast('Not yet accepted');
      }
    });
  }
}
