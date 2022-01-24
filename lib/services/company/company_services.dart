import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_secentry/helpers/sharedpreferences.dart';
import 'package:flutter_secentry/models/company/company_details_model.dart';
import 'package:flutter_secentry/models/user_model.dart';
import 'package:flutter_secentry/widget/toast.dart';
import 'package:http/http.dart' as http;

import '../api.dart';

class CompanyServices {
  DioCacheManager? _dioCacheManager;
  Future<dynamic> companyRegistration(
    context,
    String companyId,
  ) async {
    UserModel userData = await SharedPreference().readAsModel('userData');
    try {
      var client = http.Client();
      var url = Uri.parse("${Api.baseUrl}company-user/");
      final http.Response response = await client
          .post(
            url,
            headers: <String, String>{
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Token ${userData.key}'
            },
            body: jsonEncode(<String, dynamic>{"company_id": companyId}),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseJson = json.decode(response.body);

        print(responseJson);
        return true;
      } else {
        final responseJson = json.decode(response.body);
        print(responseJson);
        ToastUtils.showRedToast(response.body);
        log("error login: ${response.body}");
        return false;
      }
    } catch (e) {
      print(e.toString());
      // if (e is SocketException) {
      //   return '"Please check your Internet Connection", "No Internet Connection"';
      // } else {
      //   print(e.toString());
      // }
    }
  }

  Future<bool> getCompanyDetails() async {
    bool result = false;
    _dioCacheManager = DioCacheManager(CacheConfig());
    UserModel userData = await SharedPreference().readAsModel('userData');
    var client = http.Client();
    var url =
        "${Api.baseUrl}company-user-search/?company_user_phone=${userData.phoneNumber}";
    Options _cacheOptions = buildCacheOptions(
      const Duration(seconds: 120),
    );
    _cacheOptions.headers?.addAll({
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Token ${userData.key}',
    });
    try {
      Dio _dio = Dio();
      _dio.interceptors.add(_dioCacheManager!.interceptor);
      Response response = await _dio.get(url, options: _cacheOptions);
      if (response.statusCode == 200) {
        print(response.data);
        SharedPreference().save("companyDetails", response.data);
        result = true;
      } else {
        ToastUtils.showRedToast(json.decode(response.data));
        result = false;
      }
    } catch (e) {
      if (e is DioError) {
        print(e.response);
      } else {
        print(e.toString());
      }
    }
    return result;
  }

  Future<CompanyDetails> getCompanyDetail() async {
    CompanyDetails _companyDetails = CompanyDetails();
    UserModel userData = await SharedPreference().readAsModel('userData');
    try {
      var client = http.Client();
      var url = Uri.parse(
          "${Api.baseUrl}company-user-search/?company_user_phone=${userData.phoneNumber}");
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
        SharedPreference().save("companydetails", responseJson);
        _companyDetails = CompanyDetails.fromJson(responseJson);
      } else {
        ToastUtils.showRedToast(response.body);
        log("error login: ${response.body}");
      }
    } catch (e) {
      print(e.toString());
    }
    return _companyDetails;
  }
}
