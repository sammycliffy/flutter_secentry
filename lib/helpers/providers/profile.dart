import 'package:flutter/material.dart';
import 'package:flutter_secentry/models/company/company_details_model.dart';
import 'package:flutter_secentry/models/estate_details.dart';
import 'package:flutter_secentry/models/user_model.dart';

class ProfileDataNotifier with ChangeNotifier {
  UserModel? _userProfile;
  EstateDetails? _estateDetails;
  CompanyDetails? _companyDetails;
  bool _loading = false;

  UserModel? get userProfile => _userProfile;
  EstateDetails? get estateDetails => _estateDetails;
  CompanyDetails? get companyDetails => _companyDetails;
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

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }
}
