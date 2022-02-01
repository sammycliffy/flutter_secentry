import 'package:flutter/material.dart';
import 'package:flutter_secentry/helpers/getFacilityDetails.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/helpers/sharedpreferences.dart';
import 'package:flutter_secentry/models/company/company_details_model.dart';
import 'package:flutter_secentry/models/estate_details.dart';
import 'package:flutter_secentry/models/guard/guard_details.dart';
import 'package:flutter_secentry/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

checkProfile(context) async {
  GetDetails _getDetails = GetDetails();
  ProfileDataNotifier _profileNotifier =
      Provider.of<ProfileDataNotifier>(context, listen: false);
  UserModel userData = await SharedPreference().readAsModel("userData");

  if (userData.verified == "False") {
    Navigator.pushNamed(context, '/email_verification');
  } else if (userData.isEstateuser == true) {
    //is estate user
    if (userData.belongEstateId != "No Estate ID") {
      _getDetails.getEstateDetails().then((value) async {
        EstateDetails estateDetails =
            await SharedPreference().readEstateModel('estateDetails');
        if (estateDetails.results?[0].accepted != true) {
          bool? result = await SharedPreference().readPendingStatus('pending');
          if (result == true || result == null) {
            Navigator.pushNamed(context, '/estate_pending');
          } else {
            Navigator.pushNamed(context, '/estatejoinfacility');
          }
        } else {
          Navigator.pushNamed(context, '/estate_dashboard');
        }
      });
    } else {
      Navigator.pushNamed(context, '/estatejoinfacility');
    }
  } else if (userData.isCompanyuser == true) {
    if (userData.belongCompanyId != "No Company ID") {
      _getDetails.getCompanyDetails().then((value) async {
        CompanyDetails companyDetails =
            await SharedPreference().readCompanyModel("companydetails");

        print(companyDetails.results?[0].accepted);
        if (companyDetails.results?[0].accepted != true) {
          bool? result = await SharedPreference().readPendingStatus('pending');
          if (result == true || result == null) {
            Navigator.pushNamed(context, '/company_pending');
          } else {
            Navigator.pushNamed(context, '/companyjoinfacility');
          }
        } else {
          Navigator.pushNamed(context, '/company_dashboard');
        }
      });
    } else {
      Navigator.pushNamed(context, '/companyjoinfacility');
    }
  } else {
    //guard
    if (userData.getEstateIdGuard == "None" &&
        userData.getCompanyIdGuard == "None") {
      Navigator.pushNamed(context, '/no_guard_facility');
    } else if (userData.getCompanyIdGuard != "None") {
      print(userData.getCompanyIdGuard);
      _getDetails.getCompanyGuardDetails();

      Navigator.pushNamed(context, '/guard_company_dashboard');
    } else {
      _getDetails.getEstateGuardDetails();
      Navigator.pushNamed(context, '/guard_estate_dashboard');
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
