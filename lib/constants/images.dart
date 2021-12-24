import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Images {
  static String background = 'assets/images/background.svg';
  static String joinEstate = 'assets/images/join_estate.svg';
  static String messages = 'assets/images/messages.svg';
  static String estateIcon = 'assets/images/estateicon.svg';
  static String inviteIcon = 'assets/images/inviteicon.svg';
  static String estateIconGreen = 'assets/images/estateicongreen.svg';
  static String guestEntry = 'assets/images/guestentry.svg';
  static String entry = 'assets/images/entry.png';
  static String search = 'assets/images/search.png';
  static String guestIcon = 'assets/images/guest_list.svg';
  static String entryicon = 'assets/images/dashboard_guest_entry.png';
  static String emergency = 'assets/images/emergency.png';
  static String report = 'assets/images/report1.png';
  static String message = 'assets/images/messages.png';
  static String news = 'assets/images/news.png';
  static String vendor = 'assets/images/vendor.png';
  static String entry_approved = 'assets/images/entry_approve.svg';
  static String exit_approved = 'assets/images/exit_approved.svg';
  static String secentryLogo = 'assets/images/secentry_logo.png';
}

final noEstateImage =
    SvgPicture.asset(Images.joinEstate, semanticsLabel: 'background');

final background =
    SvgPicture.asset(Images.background, semanticsLabel: 'background');
final invitationMessage = SvgPicture.asset(Images.messages);
final facilityIcon = SvgPicture.asset(Images.estateIcon);
final guestIcon = SvgPicture.asset(Images.inviteIcon);
final greenFacilityIcon = SvgPicture.asset(Images.estateIconGreen);
final visitorentry = SvgPicture.asset(Images.entry);
final searchIcon = SvgPicture.asset(Images.search);
final guestListIcon = SvgPicture.asset(Images.guestEntry);
final entryApproved = SvgPicture.asset(Images.entry_approved);
final exitApproved = SvgPicture.asset(Images.exit_approved);
final guestEntry = Image.asset(
  Images.entryicon,
  width: 100,
  height: 100,
);

final emergencyIcon = Image.asset(
  Images.emergency,
  width: 100,
  height: 100,
);
final reportIcon = Image.asset(
  Images.report,
  width: 100,
  height: 100,
);

final messageIcon = Image.asset(
  Images.message,
  width: 100,
  height: 100,
);
final vendorIcon = Image.asset(
  Images.vendor,
  width: 100,
  height: 100,
);
final newsIcon = Image.asset(
  Images.news,
  width: 100,
  height: 100,
);
