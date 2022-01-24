import 'dart:convert';
import 'package:flutter_secentry/helpers/sharedpreferences.dart';
import 'package:flutter_secentry/models/company/company_details_model.dart';
import 'package:flutter_secentry/models/company/company_news_model.dart';
import 'package:flutter_secentry/models/user_model.dart';
import 'package:flutter_secentry/services/api.dart';
import 'package:flutter_secentry/widget/toast.dart';
import 'package:http/http.dart' as http;

class CompanyNewsServices {
  Future<CompanyNewsModel> getAllNews() async {
    UserModel userData = await SharedPreference().readAsModel('userData');
    CompanyDetails companyId =
        await SharedPreference().readCompanyModel('companydetails');
    CompanyNewsModel _CompanyNewsModel = CompanyNewsModel();
    try {
      var client = http.Client();
      var url = Uri.parse(
          "${Api.baseUrl}company-admin-news/?company_id=${companyId.results?[0].companyId}");
      print(url);
      final http.Response response = await client.get(
        url,
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token ${userData.key}'
        },
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseJson = json.decode(response.body);
        print(responseJson);
        _CompanyNewsModel = CompanyNewsModel.fromJson(responseJson);
      } else {
        final responseJson = json.decode(response.body);
        print(responseJson);
        ToastUtils.showRedToast(response.body);
      }
    } catch (e) {
      print(e.toString());
      // if (e is SocketException) {
      //   return '"Please check your Internet Connection", "No Internet Connection"';
      // } else {
      //   print(e.toString());
      // }
    }
    return _CompanyNewsModel;
  }

  Future<CompanyNewsModel> getAllNewsByPageNumber(pageNumber) async {
    UserModel userData = await SharedPreference().readAsModel('userData');
    CompanyDetails companyId =
        await SharedPreference().readCompanyModel('companydetails');
    CompanyNewsModel _CompanyNewsModel = CompanyNewsModel();
    try {
      var client = http.Client();
      var url = Uri.parse(
          "${Api.baseUrl}company-admin-news/?company_id=${companyId.results?[0].companyId}&page=$pageNumber");
      print(url);
      final http.Response response = await client.get(
        url,
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token ${userData.key}'
        },
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseJson = json.decode(response.body);
        print(responseJson);
        _CompanyNewsModel = CompanyNewsModel.fromJson(responseJson);
      } else {
        final responseJson = json.decode(response.body);
        print(responseJson);
        ToastUtils.showRedToast(response.body);
      }
    } catch (e) {
      print(e.toString());
      // if (e is SocketException) {
      //   return '"Please check your Internet Connection", "No Internet Connection"';
      // } else {
      //   print(e.toString());
      // }
    }
    return _CompanyNewsModel;
  }
}
