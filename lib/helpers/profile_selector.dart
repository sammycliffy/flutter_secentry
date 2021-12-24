import 'package:flutter/material.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/helpers/sharedpreferences.dart';
import 'package:flutter_secentry/models/estate_details.dart';
import 'package:flutter_secentry/models/user_model.dart';
import 'package:provider/provider.dart';

checkProfile(context) async {
  ProfileDataNotifier _profileNotifier =
      Provider.of<ProfileDataNotifier>(context, listen: false);
  UserModel userData = await SharedPreference().readAsModel("userData");
  EstateDetails estateDetails =
      await SharedPreference().readEstateModel('estateDetails');
  if (userData.isEstateuser == true) {
    //is estate user
    if (userData.belongEstateId != "No Estate ID") {
      if (estateDetails.results?[0].accepted != true) {
        Navigator.pushNamed(context, '/nofacility');
      } else {
        Navigator.pushNamed(context, '/estate_dashboard');
      }
    } else {
      Navigator.pushNamed(context, '/nofacility');
    }
  } else if (userData.isCompanyuser == true) {
    //is company user
    if (userData.belongCompanyId != "No Company ID") {
      Navigator.pushNamed(context, '/company_dashboard');
    } else {
      Navigator.pushNamed(context, '/nofacility');
    }
  } else {
    //guard
    if (userData.belongToEstateidGuard != "No Estate joined yet") {
      Navigator.pushNamed(context, '/guard_dashboard');
    } else {
      //doesn't belong to estate
      Navigator.pushNamed(context, '/no_guard_facility');
    }
  }

  // if (userData.isGuard == true &&
  //     userData.belongToEstateidGuard == "No Estate joined yet") {
  //   Navigator.pushNamed(context, '/add_estateid');
  // } else if (userData.isGuard == true &&
  //     userData.belongToEstateidGuard != "No Estate joined yet") {
  //   Navigator.pushNamed(context, '/security_dashboard');
  // } else {
  //   Navigator.pushNamed(context, '/dashboard');
  // }
}
