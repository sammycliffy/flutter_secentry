import 'dart:convert';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_secentry/helpers/sharedpreferences.dart';
import 'package:flutter_secentry/models/estatemessage_model.dart';
import 'package:flutter_secentry/models/user_model.dart';
import 'package:flutter_secentry/widget/toast.dart';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import 'api.dart';

class MessageServices {
  DioCacheManager? _dioCacheManager;
  Future<EstateMessage> getAllMessage() async {
    EstateMessage _estateMessage = EstateMessage();
    _dioCacheManager = DioCacheManager(CacheConfig());
    UserModel userData = await SharedPreference().readAsModel('userData');
    print(userData.phoneNumber);
    var client = http.Client();
    var url =
        "${Api.baseUrl}estate-admin-message/?estate_user_phone=${userData.phoneNumber}";
    Options _cacheOptions = buildCacheOptions(
      const Duration(seconds: 10),
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
        _estateMessage = EstateMessage.fromJson(response.data);
      } else {
        ToastUtils.showRedToast(json.decode(response.data));
      }
    } catch (e) {
      if (e is DioError) {
        print(e.toString());
      } else {
        print(e.toString());
      }
    }
    return _estateMessage;
  }

  Future<EstateMessage> getAllMessageByPageNumber(pageNumber) async {
    EstateMessage _estateMessage = EstateMessage();
    _dioCacheManager = DioCacheManager(CacheConfig());
    UserModel userData = await SharedPreference().readAsModel('userData');
    var client = http.Client();
    var url =
        "${Api.baseUrl}estate-admin-message/?estate_user_phone=${userData.phoneNumber}&page=$pageNumber";
    Options _cacheOptions = buildCacheOptions(
      const Duration(seconds: 10),
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
        _estateMessage = EstateMessage.fromJson(response.data);
      } else {
        ToastUtils.showRedToast(json.decode(response.data));
      }
    } catch (e) {
      if (e is DioError) {
        print(e.toString());
      } else {
        print(e.toString());
      }
    }
    return _estateMessage;
  }

  // Future<EstateMessage> getAllMessageByPageNumber(pageNumber) async {
  //   _dioCacheManager = DioCacheManager(CacheConfig());

  //   EstateDetails estateId =
  //       await SharedPreference().readEstateDetails("estateDetails");
  //   UserModel userData = await SharedPreference().readAsModel('userData');
  //   var client = http.Client();
  //   var url =
  //       "${Api.baseUrl}estate-admin-message/?estate_id=${estateId.results[0].estateId}&page=$pageNumber";
  //   Options _cacheOptions = buildCacheOptions(
  //     Duration(seconds: 120),
  //   );
  //   _cacheOptions.headers.addAll({
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     'Accept': 'application/json',
  //     'Authorization': 'Token ${userData.key}',
  //   });
  //   try {
  //     Dio _dio = Dio();
  //     _dio.interceptors.add(_dioCacheManager.interceptor);
  //     Response response = await _dio.get(url, options: _cacheOptions);
  //     if (response.statusCode == 200) {
  //       print(response.data);
  //       return EstateMessage.fromJson(response.data);
  //     } else {
  //       ToastUtils.showRedToast(json.decode(response.data));
  //     }
  //   } catch (e) {
  //     if (e is DioError) {
  //       print(e.response.data);
  //       return Future.error(e.response.data['detail']);
  //     } else {
  //       print(e.toString());
  //     }
  //     //return e
  //   }
  // }

  // Future<dynamic> sendMessage(context, String message) async {
  //   UserModel userData = await SharedPreference().readAsModel('userData');

  //   EstateDetails estatePhone =
  //       await SharedPreference().readEstateDetails("estateDetails");
  //   print(estatePhone.results[0].estateAdminPhone);
  //   try {
  //     var client = http.Client();
  //     var url = Uri.parse("${Api.baseUrl}estate-user-message/");

  //     final http.Response response = await client
  //         .post(
  //           url,
  //           headers: <String, String>{
  //             'Content-type': 'application/json',
  //             'Accept': 'application/json',
  //             'Authorization': 'Token ${userData.key}'
  //           },
  //           body: jsonEncode(<String, dynamic>{"message": message}),
  //         )
  //         .timeout(Duration(seconds: 15));

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final responseJson = json.decode(response.body);
  //       ToastUtils.showToastCenter('Message sent to Admin');
  //       return true;
  //     } else {
  //       final responseJson = json.decode(response.body);
  //       print(responseJson);
  //       ToastUtils.showRedToast(response.body);

  //       return false;
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     // if (e is SocketException) {
  //     //   return '"Please check your Internet Connection", "No Internet Connection"';
  //     // } else {
  //     //   print(e.toString());
  //     // }
  //   }
  // }
}
