import 'dart:convert';
import 'package:flutter_secentry/helpers/sharedpreferences.dart';
import 'package:flutter_secentry/models/estatemessage_model.dart';
import 'package:flutter_secentry/models/user_model.dart';
import 'package:flutter_secentry/widget/toast.dart';
import 'package:http/http.dart' as http;

import 'api.dart';

class MessageServices {
  Future<EstateMessage> getAllMessage() async {
    UserModel userData = await SharedPreference().readAsModel('userData');
    EstateMessage _visitorModel = EstateMessage();
    try {
      var client = http.Client();
      var url = Uri.parse(
          "${Api.baseUrl}estate-admin-message/?estate_user_phone=${userData.phoneNumber}");
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
        _visitorModel = EstateMessage.fromJson(responseJson);
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
    return _visitorModel;
  }

  Future<EstateMessage> getAllMessageByPageNumber(pageNumber) async {
    UserModel userData = await SharedPreference().readAsModel('userData');
    EstateMessage _visitorModel = EstateMessage();
    try {
      var client = http.Client();
      var url = Uri.parse(
          "${Api.baseUrl}estate-admin-message/?estate_user_phone=${userData.phoneNumber}&page=$pageNumber");
      print(url);
      final http.Response response = await client.get(
        url,
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token ${userData.key}'
        },
      ).timeout(Duration(seconds: 15));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseJson = json.decode(response.body);

        _visitorModel = EstateMessage.fromJson(responseJson);
        return _visitorModel;
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
    return _visitorModel;
  }
  // Future<EstateMessage> getAllMessageByPageNumber(pageNumber) async {
  //   EstateMessage _estateMessage = EstateMessage();
  //   _dioCacheManager = DioCacheManager(CacheConfig());
  //   UserModel userData = await SharedPreference().readAsModel('userData');
  //   var client = http.Client();
  //   var url =
  //       "${Api.baseUrl}estate-admin-message/?estate_user_phone=${userData.phoneNumber}&page=$pageNumber";
  //   Options _cacheOptions = buildCacheOptions(
  //     const Duration(seconds: 10),
  //   );
  //   _cacheOptions.headers!.addAll({
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     'Accept': 'application/json',
  //     'Authorization': 'Token ${userData.key}',
  //   });
  //   try {
  //     Dio _dio = Dio();
  //     _dio.interceptors.add(_dioCacheManager!.interceptor);
  //     Response response = await _dio.get(url, options: _cacheOptions);
  //     if (response.statusCode == 200) {
  //       _estateMessage = EstateMessage.fromJson(response.data);
  //     } else {
  //       ToastUtils.showRedToast(json.decode(response.data));
  //     }
  //   } catch (e) {
  //     if (e is DioError) {
  //       print(e.toString());
  //     } else {
  //       print(e.toString());
  //     }
  //   }
  //   return _estateMessage;
  // }
}
