import 'dart:convert';
import 'package:flutter_secentry/models/estate_details.dart';
import 'package:flutter_secentry/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  Future<UserModel> readAsModel(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? getString = prefs.getString(key);

    return UserModel.fromJson(json.decode('$getString'));
  }

  Future<EstateDetails> readEstateModel(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? getString = prefs.getString(key);

    return EstateDetails.fromJson(json.decode('$getString'));
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  setPending(bool pending) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('pending', pending);
  }

  // Future<bool> readPendingStatus(String key) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   bool? getBool = prefs.getBool(key);

  //   return getBool;
  // }
}
