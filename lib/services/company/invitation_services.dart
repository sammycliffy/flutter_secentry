import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secentry/helpers/sharedpreferences.dart';
import 'package:flutter_secentry/models/company/company_visitor_model.dart';
import 'package:flutter_secentry/models/user_model.dart';
import 'package:flutter_secentry/models/visitor_entry_model.dart';
import 'package:flutter_secentry/services/api.dart';
import 'package:flutter_secentry/widget/toast.dart';
import 'package:http/http.dart' as http;

class CompanyGuestEntryServices {
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
      String model,
      String plate,
      String color) async {
    UserModel userData = await SharedPreference().readAsModel('userData');
    try {
      var client = http.Client();
      var url = Uri.parse("${Api.baseUrl}company-user-guest/");
      final http.Response response = await client
          .post(
            url,
            headers: <String, String>{
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Token ${userData.key}'
            },
            body: jsonEncode(<String, dynamic>{
              "company_visitor_name": visitorName,
              "company_visitor_address": visitorAddress,
              "country": country,
              "state": state,
              "company_visitor_phone": visitorPhone,
              "purpose_of_visit": purposeOfVisit,
              "vehicle_model": model,
              "vehicle_colour": color,
              "vehicle_plate_number": plate,
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

  Future<CompanyVisitorModel> getInvitation(context) async {
    UserModel userData = await SharedPreference().readAsModel('userData');
    CompanyVisitorModel _companyVisitorModel = CompanyVisitorModel();
    try {
      var client = http.Client();
      var url = Uri.parse(
          "${Api.baseUrl}company-user-guest/?company_user_phone=${userData.phoneNumber}");
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

        _companyVisitorModel = CompanyVisitorModel.fromJson(responseJson);
        return _companyVisitorModel;
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
    return _companyVisitorModel;
  }

  Future<CompanyVisitorModel> getInvitationByNumber(context, pageNumber) async {
    UserModel userData = await SharedPreference().readAsModel('userData');
    CompanyVisitorModel _companyVisitorModel = CompanyVisitorModel();
    try {
      var client = http.Client();
      var url = Uri.parse(
          "${Api.baseUrl}company-user-guest/?company_visitor_phone=${userData.phoneNumber}&page=$pageNumber");
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

        _companyVisitorModel = CompanyVisitorModel.fromJson(responseJson);
        return _companyVisitorModel;
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
    return _companyVisitorModel;
  }

  Future<CompanyVisitorModel> getInvitedLists(context) async {
    UserModel userData = await SharedPreference().readAsModel('userData');
    CompanyVisitorModel _companyVisitorModel = CompanyVisitorModel();
    print(userData.phoneNumber);
    try {
      var client = http.Client();
      var url = Uri.parse(
          "${Api.baseUrl}company-user-guest/?company_visitor_phone=${userData.phoneNumber}");
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
        _companyVisitorModel = CompanyVisitorModel.fromJson(responseJson);
      } else {
        ToastUtils.showRedToast(response.body);
        log("error login: ${response.body}");
      }
    } catch (e) {
      print(e.toString());
    }
    return _companyVisitorModel;
  }

  Future<CompanyVisitorModel> getInvitedListsByNumber(
      context, pageNumber) async {
    UserModel userData = await SharedPreference().readAsModel('userData');
    CompanyVisitorModel _companyVisitorModel = CompanyVisitorModel();
    try {
      var client = http.Client();
      var url = Uri.parse(
          "${Api.baseUrl}company-user-guest/?company_visitor_phone=${userData.phoneNumber}&page=$pageNumber");
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
        _companyVisitorModel = CompanyVisitorModel.fromJson(responseJson);
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
    return _companyVisitorModel;
  }
}
