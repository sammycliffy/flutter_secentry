import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/helpers/sharedpreferences.dart';
import 'package:flutter_secentry/models/estate_details.dart';
import 'package:flutter_secentry/services/estate_service.dart';
import 'package:flutter_secentry/widget/button.dart';
import 'package:provider/src/provider.dart';

class Nofacility extends StatefulWidget {
  const Nofacility({Key? key}) : super(key: key);

  @override
  State<Nofacility> createState() => _NofacilityState();
}

class _NofacilityState extends State<Nofacility> {
  final EstateServices _estateServices = EstateServices();
  List<ImageText> imageText = [
    ImageText(
        imageUrl: noEstateImage,
        text:
            'For Estate Residents who wants to be part of their existing estate. You need a unique estate Id from your estate manager',
        type: 'Join Estate'),
    ImageText(
        imageUrl: noEstateImage,
        text:
            'For Estate Residents who wants to be part of their existing estate. You need a unique estate Id from your estate manager')
  ];
  final _totalDots = 2;
  double _currentPosition = 0.0;
  PageController _pageController = PageController(initialPage: 0);
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
      body: SingleChildScrollView(
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
                    style: TextStyle(fontSize: 40),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.notifications,
                      color: kPrimary,
                      size: 30,
                    ),
                    onPressed: () =>
                        Navigator.pushNamed(context, '/my_invitations'),
                  )
                ],
              ),
              const Text(
                'No facility yet,',
                style: TextStyle(fontSize: 17, color: kGray),
              ),
              heightSpace(100),
              SizedBox(
                width: 400,
                height: 320,
                child: PageView(
                  pageSnapping: true,
                  controller: _pageController,
                  onPageChanged: pageChange,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: 400,
                          height: 200,
                          child: imageText[0].imageUrl!,
                        ),
                        heightSpace(20),
                        Text(
                          imageText[0].text!,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 400,
                          height: 200,
                          child: imageText[1].imageUrl!,
                        ),
                        heightSpace(20),
                        Text(
                          imageText[1].text!,
                          textAlign: TextAlign.center,
                        )
                      ],
                    )
                  ],
                ),
              ),
              heightSpace(20),
              Center(
                  child: DotsIndicator(
                      dotsCount: _totalDots, position: _currentPosition)),
              heightSpace(40),
              _currentPosition == 0.0
                  ? CustomButton(text: 'Join Estate', validate: validateEstate)
                  : CustomButton(text: 'Join Company', validate: null)
            ],
          ),
        ),
      ),
    );
  }

  checkAcceptedStatus() async {
    dynamic result = await _estateServices.getEstateDetail();
    if (result) {
      EstateDetails estateDetails =
          await SharedPreference().readEstateModel('estateDetails');
      if (estateDetails.results?[0].accepted == true) {
        Navigator.pushNamed(context, '/estate_dashboard');
      }
    }
  }

  void pageChange(int index) {
    setState(() {
      _currentPosition = index.toDouble();
    });
  }

  validateEstate() {
    Navigator.pushNamed(context, '/estate_code');
  }
}

class ImageText {
  var imageUrl;
  String? text;
  String? type;

  ImageText({this.imageUrl, this.text, this.type});
}
