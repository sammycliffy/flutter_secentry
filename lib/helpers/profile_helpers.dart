import 'package:flutter/material.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/helpers/sharedpreferences.dart';
import 'package:flutter_secentry/models/user_model.dart';
import 'package:provider/provider.dart';

saveUser(context) async {
  ProfileDataNotifier _profileNotifier =
      Provider.of<ProfileDataNotifier>(context, listen: false);
  UserModel userData = await SharedPreference().readAsModel("userData");
  _profileNotifier.setUserProfile(userData);
}

checkProfile(context) async {
  ProfileDataNotifier _profileNotifier =
      Provider.of<ProfileDataNotifier>(context, listen: false);
  UserModel userData = await SharedPreference().readAsModel("userData");
  if (userData.isGuard == true &&
      userData.belongToEstateidGuard == "No Estate joined yet") {
    Navigator.pushNamed(context, '/add_estateid');
  } else if (userData.isGuard == true &&
      userData.belongToEstateidGuard != "No Estate joined yet") {
    Navigator.pushNamed(context, '/security_dashboard');
  } else {
    Navigator.pushNamed(context, '/dashboard');
  }
}
