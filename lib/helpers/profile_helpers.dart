import 'package:flutter/material.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/helpers/sharedpreferences.dart';
import 'package:flutter_secentry/models/estate_details.dart';
import 'package:flutter_secentry/models/user_model.dart';
import 'package:provider/provider.dart';

saveUser(context) async {
  ProfileDataNotifier _profileNotifier =
      Provider.of<ProfileDataNotifier>(context, listen: false);
  UserModel userData = await SharedPreference().readAsModel("userData");
  _profileNotifier.setUserProfile(userData);
}

saveEstate(context) async {
  ProfileDataNotifier _profileNotifier =
      Provider.of<ProfileDataNotifier>(context, listen: false);
  EstateDetails estateDetails =
      await SharedPreference().readEstateModel('estateDetails');
  _profileNotifier.setEstateDetail(estateDetails);
}
