import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_secentry/helpers/sharedpreferences.dart';
import 'package:flutter_secentry/models/estate_details.dart';
import 'package:flutter_secentry/models/user_model.dart';
import 'package:flutter_secentry/widget/toast.dart';
import 'package:http/http.dart' as http;

import 'api.dart';

class EstateServices {
  DioCacheManager? _dioCacheManager;
  Future<dynamic> estateRegistration(
    context,
    String estateId,
  ) async {
    UserModel userData = await SharedPreference().readAsModel('userData');
    try {
      var client = http.Client();
      var url = Uri.parse("${Api.baseUrl}estate-user/");
      final http.Response response = await client
          .post(
            url,
            headers: <String, String>{
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Token ${userData.key}'
            },
            body: jsonEncode(<String, dynamic>{"estate_id": estateId}),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseJson = json.decode(response.body);
        // SharedPreference().save("estateInformation", responseJson);
        // SharedPreference().save("userData", responseJson);
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

  Future<bool> getEstateDetail() async {
    bool result = false;
    _dioCacheManager = DioCacheManager(CacheConfig());
    UserModel userData = await SharedPreference().readAsModel('userData');
    var client = http.Client();
    var url =
        "${Api.baseUrl}user-estate-detail/?estate_user_phone=${userData.phoneNumber}";
    Options _cacheOptions = buildCacheOptions(
      const Duration(seconds: 120),
    );
    _cacheOptions.headers!.addAll({
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Token ${userData.key}',
    });
    try {
      Dio _dio = Dio();
      _dio.interceptors.add(_dioCacheManager!.interceptor);
      Response response = await _dio.get(url, options: _cacheOptions);
      if (response.statusCode == 200) {
        SharedPreference().save("estateDetails", response.data);
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
}
