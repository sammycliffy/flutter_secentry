import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_secentry/helpers/sharedpreferences.dart';
import 'package:flutter_secentry/models/estate_details.dart';
import 'package:flutter_secentry/models/guard/guard_details.dart';
import 'package:flutter_secentry/models/user_model.dart';
import 'package:flutter_secentry/models/visitor_model.dart';
import 'package:flutter_secentry/services/api.dart';
import 'package:flutter_secentry/widget/toast.dart';
import 'package:http/http.dart' as http;

class GuardServices {
  Future<dynamic> joinEstate(context, String facilityId) async {
    UserModel userData = await SharedPreference().readAsModel('userData');
    try {
      var client = http.Client();
      var url = Uri.parse("${Api.baseUrl}guard/");
      final http.Response response = await client
          .post(
            url,
            headers: <String, String>{
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Token ${userData.key}'
            },
            body: jsonEncode(<String, dynamic>{
              "facility_id": facilityId,
            }),
          )
          .timeout(Duration(seconds: 15));

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
      if (e is SocketException) {
        ToastUtils.showRedToast('Network Error');
      } else {
        ToastUtils.showRedToast('Network Error');
      }
    }
  }

  Future<VisitorModel> searchVisitor(context, visitorId) async {
    UserModel userData = await SharedPreference().readAsModel('userData');
    VisitorModel _visitorModel = VisitorModel();

    try {
      var client = http.Client();
      var url = Uri.parse(
          "${Api.baseUrl}estate-user-guest-search/?visitor_id=$visitorId");
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

        _visitorModel = VisitorModel.fromJson(responseJson);
      } else {
        final responseJson = json.decode(response.body);
        print(responseJson);
        ToastUtils.showRedToast(response.body);
        log("error login: ${response.body}");
      }
    } catch (e) {
      print(e.toString());
      if (e is SocketException) {
        ToastUtils.showRedToast('Network Error');
      } else {
        ToastUtils.showRedToast('Network Error');
      }
    }
    return _visitorModel;
  }

  Future<bool> searchUser(context, phonenumber) async {
    UserModel userData = await SharedPreference().readAsModel('userData');
    bool result = false;
    try {
      var client = http.Client();
      var url = Uri.parse("${Api.baseUrl}estate-user-entry-exit/");
      print(url);
      final http.Response response = await client
          .post(
            url,
            headers: <String, String>{
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Token ${userData.key}'
            },
            body: jsonEncode(<String, dynamic>{
              "estate_id": "",
              "estate_user_code": "",
              "entry": true,
              "exit": false,
              "estateid_user": phonenumber
            }),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseJson = json.decode(response.body);
        result = true;
      } else {
        final responseJson = json.decode(response.body);
        print(responseJson);
        ToastUtils.showRedToast(response.body);
        result = false;
      }
    } catch (e) {
      if (e is SocketException) {
        ToastUtils.showRedToast('Network Error');
      } else {
        ToastUtils.showRedToast('Network Error');
      }
    }
    return result;
  }

  Future<bool> exitUser(context, phonenumber) async {
    UserModel userData = await SharedPreference().readAsModel('userData');
    bool result = false;
    try {
      var client = http.Client();
      var url = Uri.parse("${Api.baseUrl}estate-user-entry-exit/");
      print(url);
      final http.Response response = await client
          .post(
            url,
            headers: <String, String>{
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Token ${userData.key}'
            },
            body: jsonEncode(<String, dynamic>{
              "estate_id": "",
              "estate_user_code": "",
              "entry": true,
              "exit": true,
              "estateid_user": phonenumber
            }),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseJson = json.decode(response.body);
        result = true;
      } else {
        final responseJson = json.decode(response.body);
        print(responseJson);
        ToastUtils.showRedToast(response.body);
        result = false;
      }
    } catch (e) {
      if (e is SocketException) {
        ToastUtils.showRedToast('Network Error');
      } else {
        ToastUtils.showRedToast('Network Error');
      }
    }
    return result;
  }

  Future<bool> approveVisitor(
    context,
    visitorPrimaryKey,
  ) async {
    bool result = false;

    UserModel userData = await SharedPreference().readAsModel('userData');

    try {
      var client = http.Client();
      var url =
          Uri.parse("${Api.baseUrl}estate-user-guest/$visitorPrimaryKey/");
      print(url);
      final http.Response response = await client
          .patch(
            url,
            headers: <String, String>{
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Token ${userData.key}'
            },
            body: jsonEncode(<String, dynamic>{
              "item_pass": [],
              "approved": true,
            }),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseJson = json.decode(response.body);
        result = true;
      } else {
        final responseJson = json.decode(response.body);
        result = false;
        print(responseJson);
        ToastUtils.showRedToast(response.body);
        log("error login: ${response.body}");
      }
    } catch (e) {
      if (e is SocketException) {
        ToastUtils.showRedToast('Network Error');
      } else {
        print(e.toString());
      }
    }
    return result;
  }

  Future<bool> approveCompanyVisitor(
    context,
    visitorPrimaryKey,
  ) async {
    bool result = false;

    UserModel userData = await SharedPreference().readAsModel('userData');

    try {
      var client = http.Client();
      var url =
          Uri.parse("${Api.baseUrl}company-user-guest/$visitorPrimaryKey/");
      print(url);
      final http.Response response = await client
          .patch(
            url,
            headers: <String, String>{
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Token ${userData.key}'
            },
            body: jsonEncode(<String, dynamic>{
              "item_pass": [],
              "approved": true,
            }),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseJson = json.decode(response.body);
        result = true;
      } else {
        final responseJson = json.decode(response.body);
        result = false;
        print(responseJson);
        ToastUtils.showRedToast(response.body);
        log("error login: ${response.body}");
      }
    } catch (e) {
      if (e is SocketException) {
        ToastUtils.showRedToast('Network Error');
      } else {
        print(e.toString());
      }
    }
    return result;
  }

  Future<bool> exitCompanyVisitor(
    context,
    visitorPrimaryKey,
  ) async {
    bool result = false;

    UserModel userData = await SharedPreference().readAsModel('userData');

    try {
      var client = http.Client();
      var url =
          Uri.parse("${Api.baseUrl}company-user-guest/$visitorPrimaryKey/");
      print(url);
      final http.Response response = await client
          .patch(
            url,
            headers: <String, String>{
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Token ${userData.key}'
            },
            body: jsonEncode(<String, dynamic>{
              "item_pass": [],
              "check_out": true,
            }),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseJson = json.decode(response.body);
        result = true;
      } else {
        final responseJson = json.decode(response.body);
        result = false;
        print(responseJson);
        ToastUtils.showRedToast(response.body);
        log("error login: ${response.body}");
      }
    } catch (e) {
      if (e is SocketException) {
        ToastUtils.showRedToast('Network Error');
      } else {
        print(e.toString());
      }
    }
    return result;
  }

  Future<bool> checkoutVisitor(
    context,
    visitorPrimaryKey,
  ) async {
    UserModel userData = await SharedPreference().readAsModel('userData');
    bool result = false;
    try {
      var client = http.Client();
      var url =
          Uri.parse("${Api.baseUrl}estate-user-guest/$visitorPrimaryKey/");
      print(url);
      final http.Response response = await client
          .patch(
            url,
            headers: <String, String>{
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Token ${userData.key}'
            },
            body: jsonEncode(<String, dynamic>{
              "item_pass": [],
              "check_out": true,
            }),
          )
          .timeout(Duration(seconds: 15));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseJson = json.decode(response.body);
        print(responseJson);

        result = true;
      } else {
        final responseJson = json.decode(response.body);
        print(responseJson);
        ToastUtils.showRedToast(response.body);
        log("error login: ${response.body}");
        return false;
      }
    } catch (e) {
      if (e is SocketException) {
        ToastUtils.showRedToast('Network Error');
      } else {
        ToastUtils.showRedToast('Network Error');
      }
    }
    return result;
  }

  Future<GuardModel> getCompanyGuardDetail() async {
    GuardModel _companyDetails = GuardModel();
    UserModel userData = await SharedPreference().readAsModel('userData');
    try {
      var client = http.Client();
      var url = Uri.parse(
          "${Api.baseUrl}company-guard-search/?guard_user_phone=${userData.phoneNumber}");
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
        SharedPreference().save("guarddetails", responseJson);
        _companyDetails = GuardModel.fromJson(responseJson);
      } else {
        ToastUtils.showRedToast(response.body);
        log("error login: ${response.body}");
      }
    } catch (e) {
      print(e.toString());
    }
    return _companyDetails;
  }

  Future<GuardModel> getEstateGuardDetail() async {
    GuardModel _companyDetails = GuardModel();
    UserModel userData = await SharedPreference().readAsModel('userData');
    try {
      var client = http.Client();
      var url = Uri.parse(
          "${Api.baseUrl}estate-guard-search/?guard_user_phone=${userData.phoneNumber}");
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
        SharedPreference().save("guarddetails", responseJson);
        _companyDetails = GuardModel.fromJson(responseJson);
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
