import 'package:flutter/material.dart';
import 'package:flutter_secentry/models/company/company_details_model.dart';
import 'package:flutter_secentry/models/estate_details.dart';
import 'package:flutter_secentry/models/guard/guard_details.dart';
import 'package:flutter_secentry/models/user_model.dart';

class ProfileDataNotifier with ChangeNotifier {
  UserModel? _userProfile;
  EstateDetails? _estateDetails;
  CompanyDetails? _companyDetails;
  GuardModel? _guardModel;
  bool _loading = false;
  int? _messageCount = 0;

  UserModel? get userProfile => _userProfile;
  GuardModel? get guardModel => _guardModel;
  EstateDetails? get estateDetails => _estateDetails;
  CompanyDetails? get companyDetails => _companyDetails;
  int? get messageCount => _messageCount;
  bool get loading => _loading;
  setUserProfile(UserModel? userProfile) {
    _userProfile = userProfile;
    notifyListeners();
  }

  setEstateDetail(EstateDetails? estateDetails) {
    _estateDetails = estateDetails;
    notifyListeners();
  }

  setCompanyDetail(CompanyDetails? companyDetails) {
    _companyDetails = companyDetails;
    notifyListeners();
  }

  setGuardDetail(GuardModel? guardModel) {
    _guardModel = guardModel;
    notifyListeners();
  }

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setMessageCount(int? count) {
    _messageCount = count;
  }
}
