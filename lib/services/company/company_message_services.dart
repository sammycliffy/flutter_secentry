import 'dart:convert';
import 'package:flutter_secentry/helpers/sharedpreferences.dart';
import 'package:flutter_secentry/models/company/companymessage_model.dart';
import 'package:flutter_secentry/models/user_model.dart';
import 'package:flutter_secentry/services/api.dart';
import 'package:flutter_secentry/widget/toast.dart';
import 'package:http/http.dart' as http;

class CompanyMessageServices {
  Future<CompanyMessage> getAllMessage() async {
    UserModel userData = await SharedPreference().readAsModel('userData');
    CompanyMessage _visitorModel = CompanyMessage();
    try {
      var client = http.Client();
      var url = Uri.parse(
          "${Api.baseUrl}company-admin-message/?company_user_phone=${userData.phoneNumber}");
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
        _visitorModel = CompanyMessage.fromJson(responseJson);
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

  Future<CompanyMessage> getAllMessageByPageNumber(pageNumber) async {
    UserModel userData = await SharedPreference().readAsModel('userData');
    CompanyMessage _visitorModel = CompanyMessage();
    try {
      var client = http.Client();
      var url = Uri.parse(
          "${Api.baseUrl}company-admin-message/?company_user_phone=${userData.phoneNumber}&page=$pageNumber");
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

        _visitorModel = CompanyMessage.fromJson(responseJson);
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

  Future<dynamic> sendMessage(context, String message) async {
    UserModel userData = await SharedPreference().readAsModel('userData');
    try {
      var client = http.Client();
      var url = Uri.parse("${Api.baseUrl}company-user-message/");

      final http.Response response = await client
          .post(
            url,
            headers: <String, String>{
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Token ${userData.key}'
            },
            body: jsonEncode(<String, dynamic>{"message": message}),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseJson = json.decode(response.body);
        ToastUtils.showToastCenter('Message sent to Admin');
        return true;
      } else {
        final responseJson = json.decode(response.body);
        print(responseJson);
        ToastUtils.showRedToast(response.body);

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
}
