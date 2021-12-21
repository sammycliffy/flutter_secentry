import 'package:flutter/material.dart';
import 'package:flutter_secentry/models/user_model.dart';

class ProfileDataNotifier with ChangeNotifier {
  UserModel? _userProfile;
  bool _loading = false;

  UserModel? get userProfile => _userProfile;
  bool get loading => _loading;
  setUserProfile(UserModel? userProfile) {
    _userProfile = userProfile;
    notifyListeners();
  }

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }
}
