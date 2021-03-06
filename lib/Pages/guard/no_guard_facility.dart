import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/widget/button.dart';

class NoGuardFacility extends StatefulWidget {
  const NoGuardFacility({Key? key}) : super(key: key);

  @override
  State<NoGuardFacility> createState() => _NoGuardFacilityState();
}

class _NoGuardFacilityState extends State<NoGuardFacility> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      drawer: const Drawer(
        backgroundColor: kBlack,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Hi Samuel,',
                    style: TextStyle(fontSize: 40),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/my_account'),
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: kPrimary,
                      ),
                      child: const Icon(Icons.person, color: kWhite, size: 20),
                    ),
                  ),
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
                  : CustomButton(
                      text: 'Join Company', validate: validateCompany)
            ],
          ),
        ),
      ),
    );
  }

  void pageChange(int index) {
    setState(() {
      _currentPosition = index.toDouble();
    });
  }

  validateEstate() {
    Navigator.pushNamed(context, '/guard_join_facility');
  }

  validateCompany() {
    Navigator.pushNamed(context, '/guard_join_company');
  }
}

class ImageText {
  var imageUrl;
  String? text;
  String? type;

  ImageText({this.imageUrl, this.text, this.type});
}
