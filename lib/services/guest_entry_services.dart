import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secentry/helpers/sharedpreferences.dart';
import 'package:flutter_secentry/models/search_model.dart';
import 'package:flutter_secentry/models/user_model.dart';
import 'package:flutter_secentry/models/visitor_entry_model.dart';
import 'package:flutter_secentry/services/api.dart';
import 'package:flutter_secentry/widget/toast.dart';
import 'package:http/http.dart' as http;

class GuestEntryServices {
  Future<dynamic> inviteGuest(
      context,
      String visitorName,
      String visitorAddress,
      String visitorPhone,
      String purposeOfVisit,
      duration,
      itemPass) async {
    print(duration);
    // UserModel userData = await SharedPreference().readAsModel('userData');
    // try {
    //   var client = http.Client();
    //   var url = Uri.parse("${Api.baseUrl}estate-user-guest/");
    //   final http.Response response = await client
    //       .post(
    //         url,
    //         headers: <String, String>{
    //           'Content-type': 'application/json',
    //           'Accept': 'application/json',
    //           'Authorization': 'Token ${userData.key}'
    //         },
    //         body: jsonEncode(<String, dynamic>{
    //           "estate_visitor_name": visitorName,
    //           "estate_visitor_address": visitorAddress,
    //           "estate_visitor_phone": visitorPhone,
    //           "purpose_of_visit": purposeOfVisit,
    //           "duration": duration.round(),
    //           "item_pass": itemPass.map((i) => i.toJson()).toList()
    //         }),
    //       )
    //       .timeout(Duration(seconds: 15));

    //   if (response.statusCode == 200 || response.statusCode == 201) {
    //     final responseJson = json.decode(response.body);
    //     print(responseJson);
    //     return VisitorEntryModel.fromJson(responseJson);
    //   } else {
    //     final responseJson = json.decode(response.body);
    //     print(responseJson);
    //     ToastUtils.showRedToast(response.body);
    //     log("error login: ${response.body}");
    //     return false;
    //   }
    // } catch (e) {
    //   print(e.toString());
    // if (e is SocketException) {
    //   return '"Please check your Internet Connection", "No Internet Connection"';
    // } else {
    //   print(e.toString());
    // }
  }
}

Future<dynamic> searchGuest(context, String phoneNumber) async {
  UserModel userData = await SharedPreference().readAsModel('userData');
  print(phoneNumber);
  try {
    var client = http.Client();
    var url = Uri.parse("${Api.baseUrl}user-search/?phone_number=$phoneNumber");
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
      print(responseJson);
      SearchModel result = SearchModel.fromJson(responseJson);
      if (result.count == 0) {
        ToastUtils.showRedToast('User not found');
      } else {
        return result;
      }
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
