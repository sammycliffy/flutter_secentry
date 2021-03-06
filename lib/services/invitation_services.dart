import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secentry/helpers/sharedpreferences.dart';
import 'package:flutter_secentry/models/user_model.dart';
import 'package:flutter_secentry/models/visitor_entry_model.dart';
import 'package:flutter_secentry/models/visitor_model.dart';
import 'package:flutter_secentry/widget/toast.dart';
import 'package:http/http.dart' as http;
import 'api.dart';

class GuestEntryServices {
  Future<dynamic> inviteGuest(
    context,
    String visitorName,
    String visitorAddress,
    String visitorPhone,
    String purposeOfVisit,
    String country,
    String state,
    duration,
    itemPass,
  ) async {
    UserModel userData = await SharedPreference().readAsModel('userData');
    try {
      var client = http.Client();
      var url = Uri.parse("${Api.baseUrl}estate-user-guest/");
      final http.Response response = await client
          .post(
            url,
            headers: <String, String>{
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Token ${userData.key}'
            },
            body: jsonEncode(<String, dynamic>{
              "estate_visitor_name": visitorName,
              "estate_visitor_address": visitorAddress,
              "country": country,
              "state": state,
              "estate_visitor_phone": visitorPhone,
              "purpose_of_visit": purposeOfVisit,
              "duration": duration,
              "item_pass": itemPass.map((i) => i.toJson()).toList()
            }),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseJson = json.decode(response.body);
        print(responseJson);
        return VisitorEntryModel.fromJson(responseJson);
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

  // Future<dynamic> searchGuest(context, String phoneNumber) async {
  //   UserModel userData = await SharedPreference().readAsModel('userData');
  //   print(phoneNumber);
  //   try {
  //     var client = http.Client();
  //     var url =
  //         Uri.parse("${Api.baseUrl}user-search/?phone_number=$phoneNumber");
  //     print(url);
  //     final http.Response response = await client.get(
  //       url,
  //       headers: <String, String>{
  //         'Content-type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': 'Token ${userData.key}'
  //       },
  //     ).timeout(Duration(seconds: 15));

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final responseJson = json.decode(response.body);
  //       print(responseJson);
  //       SearchModel result = SearchModel.fromJson(responseJson);
  //       if (result.count == 0) {
  //         ToastUtils.showRedToast('User not found');
  //       } else {
  //         return result;
  //       }
  //     } else {
  //       final responseJson = json.decode(response.body);
  //       print(responseJson);
  //       ToastUtils.showRedToast(response.body);
  //       log("error login: ${response.body}");
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
  Future<VisitorModel> getInvitation(context) async {
    UserModel userData = await SharedPreference().readAsModel('userData');
    VisitorModel _visitorModel = VisitorModel();
    try {
      var client = http.Client();
      var url = Uri.parse(
          "${Api.baseUrl}estate-user-guest/?estate_user_phone=${userData.phoneNumber}");
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

        _visitorModel = VisitorModel.fromJson(responseJson);
        return _visitorModel;
      } else {
        final responseJson = json.decode(response.body);
        print(responseJson);
        ToastUtils.showRedToast(response.body);
        log("error login: ${response.body}");
        // return false;
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

  Future<VisitorModel> getInvitationByNumber(context, pageNumber) async {
    UserModel userData = await SharedPreference().readAsModel('userData');
    VisitorModel _visitorModel = VisitorModel();
    try {
      var client = http.Client();
      var url = Uri.parse(
          "${Api.baseUrl}estate-user-guest/?estate_visitor_phone=${userData.phoneNumber}&page=$pageNumber");
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

        _visitorModel = VisitorModel.fromJson(responseJson);
        return _visitorModel;
      } else {
        final responseJson = json.decode(response.body);
        print(responseJson);
        ToastUtils.showRedToast(response.body);
        log("error login: ${response.body}");
        // return false;
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

  Future<VisitorModel> getInvitedLists(context) async {
    UserModel userData = await SharedPreference().readAsModel('userData');
    VisitorModel _visitorModel = VisitorModel();
    print(userData.phoneNumber);
    try {
      var client = http.Client();
      var url = Uri.parse(
          "${Api.baseUrl}estate-user-guest/?estate_visitor_phone=${userData.phoneNumber}");
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
        _visitorModel = VisitorModel.fromJson(responseJson);
      } else {
        ToastUtils.showRedToast(response.body);
        log("error login: ${response.body}");
      }
    } catch (e) {
      print(e.toString());
    }
    return _visitorModel;
  }

  Future<VisitorModel> getInvitedListsByNumber(context, pageNumber) async {
    UserModel userData = await SharedPreference().readAsModel('userData');
    VisitorModel _visitorModel = VisitorModel();
    try {
      var client = http.Client();
      var url = Uri.parse(
          "${Api.baseUrl}estate-user-guest/?estate_visitor_phone=${userData.phoneNumber}&page=$pageNumber");
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
        _visitorModel = VisitorModel.fromJson(responseJson);
      } else {
        ToastUtils.showRedToast(response.body);
        log("error login: ${response.body}");
        // return false;
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
}
