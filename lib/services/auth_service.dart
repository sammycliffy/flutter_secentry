import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_secentry/helpers/sharedpreferences.dart';
import 'package:flutter_secentry/models/user_model.dart';
import 'package:flutter_secentry/widget/toast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';

class AuthServices {
  SharedPreferences? sharedPreferences;
  Future<dynamic> userRegistration(
      context,
      String email,
      String fullName,
      String phoneNumber,
      String address,
      String gender,
      String password1,
      bool companyUser,
      bool estateUser) async {
    print(companyUser);
    try {
      var url = Uri.parse("${Api.baseUrl}auth/registration/");
      final http.Response response = await http
          .post(
            url,
            headers: <String, String>{
              'Content-type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(<String, dynamic>{
              "email": email,
              "full_name": fullName,
              "phone_number": phoneNumber,
              "address": address,
              "gender": gender,
              "password1": password1,
              "password2": password1,
              "role": " ",
              "is_estateuser": estateUser,
              "is_estateguard": false,
              "is_companyuser": companyUser,
            }),
          )
          .timeout(const Duration(seconds: 40));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseJson = json.decode(response.body);
        sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences!.setString("token", responseJson['key']);
        SharedPreference().save("userData", responseJson);
        return true;
      } else {
        final responseJson = json.decode(response.body);
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

  Future<bool> loginUser(context, String email, String password) async {
    bool result = false;
    try {
      var url = Uri.parse("${Api.baseUrl}auth/login-new/");

      print(url);
      final http.Response response = await http
          .post(
            url,
            headers: <String, String>{
              'Content-type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(
                <String, dynamic>{"email": email, "password": password}),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseJson = json.decode(response.body);
        sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences!.setString("token", responseJson['key']);
        SharedPreference().save("userData", responseJson);
        print(responseJson);
        result = true;
      } else {
        ToastUtils.showRedToast(response.body);
        log("error login: ${response.body}");
        result = false;
      }
    } catch (e) {
      if (e is SocketException) {
        ToastUtils.showRedToast('Poor network connection');
      } else if (e is TimeoutException) {
        ToastUtils.showRedToast('Network problem. Please try again');
      } else {
        print(e.toString());
      }
    }
    return result;
  }

  Future<bool> passwordReset(context, String email) async {
    bool result = false;
    try {
      var url = Uri.parse("${Api.baseUrl}auth/password-reset/");
      print(url);
      final http.Response response = await http
          .post(
            url,
            headers: <String, String>{
              'Content-type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(<String, dynamic>{"email": email}),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseJson = json.decode(response.body);
        print(responseJson);
        result = true;
      } else {
        ToastUtils.showRedToast(response.body);
        log("error login: ${response.body}");
        result = false;
      }
    } catch (e) {
      if (e is SocketException) {
        ToastUtils.showRedToast('Poor network connection');
      } else if (e is TimeoutException) {
        ToastUtils.showRedToast('Network problem. Please try again');
      } else {
        print(e.toString());
      }
    }
    return result;
  }

  Future<bool> validateToken(context, String token) async {
    bool result = false;
    try {
      var url = Uri.parse("${Api.baseUrl}auth/password-reset/validate_token/");
      print(url);
      final http.Response response = await http
          .post(
            url,
            headers: <String, String>{
              'Content-type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(<String, dynamic>{"token": token}),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseJson = json.decode(response.body);
        print(responseJson);
        result = true;
      } else {
        ToastUtils.showRedToast(response.body);
        log("error login: ${response.body}");
        result = false;
      }
    } catch (e) {
      if (e is SocketException) {
        ToastUtils.showRedToast('Poor network connection');
      } else if (e is TimeoutException) {
        ToastUtils.showRedToast('Network problem. Please try again');
      } else {
        print(e.toString());
      }
    }
    return result;
  }

  Future<bool> emailVerification(context, String token) async {
    print(token + 'this is token');
    bool result = false;
    try {
      var url = Uri.parse("${Api.baseUrl}auth/verify-user-new/");
      print(url);
      final http.Response response = await http
          .post(
            url,
            headers: <String, String>{
              'Content-type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(<String, dynamic>{"key": token}),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseJson = json.decode(response.body);
        print(responseJson);
        result = true;
      } else {
        ToastUtils.showRedToast(response.body);
        log("error login: ${response.body}");
        result = false;
      }
    } catch (e) {
      if (e is SocketException) {
        ToastUtils.showRedToast('Poor network connection');
      } else if (e is TimeoutException) {
        ToastUtils.showRedToast('Network problem. Please try again');
      } else {
        print(e.toString());
      }
    }
    return result;
  }

  Future<bool> newPassword(context, String password1, String password2) async {
    bool result = false;
    try {
      var url = Uri.parse("${Api.baseUrl}auth/password/change/");
      print(url);
      final http.Response response = await http
          .post(
            url,
            headers: <String, String>{
              'Content-type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(<String, dynamic>{
              "new_password1": password1,
              "new_password2": password2
            }),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseJson = json.decode(response.body);
        print(responseJson);
        result = true;
      } else {
        ToastUtils.showRedToast(response.body);
        log("error login: ${response.body}");
        result = false;
      }
    } catch (e) {
      if (e is SocketException) {
        ToastUtils.showRedToast('Poor network connection');
        result = false;
      } else if (e is TimeoutException) {
        ToastUtils.showRedToast('Network problem. Please try again');
        result = false;
      } else {
        result = false;
        print(e.toString());
      }
    }
    return result;
  }

  Future<dynamic> deleteAccount() async {
    UserModel userData = await SharedPreference().readAsModel('userData');
    try {
      var client = http.Client();
      var url = Uri.parse("${Api.baseUrl}users/delete/${userData.phoneNumber}");
      print(url);
      final http.Response response = await client.delete(
        url,
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token ${userData.key}'
        },
      ).timeout(Duration(seconds: 15));
      print(response.body);
      if (response.statusCode == 204) {
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
