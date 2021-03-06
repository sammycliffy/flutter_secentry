import 'package:flutter_secentry/services/company/company_services.dart';
import 'package:flutter_secentry/services/estate_service.dart';
import 'package:flutter_secentry/services/guard/guard_services.dart';

class GetDetails {
  final EstateServices _estateServices = EstateServices();
  final CompanyServices _companyServices = CompanyServices();
  final GuardServices _guardServices = GuardServices();
  Future getCompanyDetails() async {
    dynamic companyResults = await _companyServices.getCompanyDetail();
  }

  Future getEstateDetails() async {
    dynamic result = await _estateServices.getEstateDetail();
  }

  Future getEstateGuardDetails() async {
    dynamic result = await _guardServices.getEstateGuardDetail();
  }

  Future getCompanyGuardDetails() async {
    dynamic result = await _guardServices.getCompanyGuardDetail();
  }
}
