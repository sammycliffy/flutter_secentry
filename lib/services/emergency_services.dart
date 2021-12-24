import 'dart:convert';
import 'package:flutter_secentry/helpers/sharedpreferences.dart';
import 'package:flutter_secentry/models/emergency_model.dart';
import 'package:flutter_secentry/models/estate_details.dart';
import 'package:flutter_secentry/models/user_model.dart';
import 'package:flutter_secentry/widget/toast.dart';
import 'package:http/http.dart' as http;

import 'api.dart';

class EmergencyServices {
  Future<EmergencyModel> getAllContact() async {
    UserModel userData = await SharedPreference().readAsModel('userData');
    EmergencyModel _emergencyModel = EmergencyModel();
    EstateDetails estateId =
        await SharedPreference().readEstateModel('estateDetails');
    try {
      var client = http.Client();
      var url = Uri.parse(
          "${Api.baseUrl}estate-admin-emergency/?estate_id=${estateId.results?[0].estateId}");
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
        _emergencyModel = EmergencyModel.fromJson(responseJson);
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
    return _emergencyModel;
  }

  Future<EmergencyModel> getAllContactByPagenumber(pageNumber) async {
    UserModel userData = await SharedPreference().readAsModel('userData');
    EmergencyModel _emergencyModel = EmergencyModel();
    EstateDetails estateId =
        await SharedPreference().readEstateModel('estateDetails');
    try {
      var client = http.Client();
      var url = Uri.parse(
          "${Api.baseUrl}estate-admin-emergency/?estate_id=${estateId.results?[0].estateId}&page=$pageNumber");
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
        _emergencyModel = EmergencyModel.fromJson(responseJson);
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
    return _emergencyModel;
  }
}
