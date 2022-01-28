import 'package:flutter/material.dart';

class InvitationNotifier with ChangeNotifier {
  String? _fullName;
  String? _phoneNumber;
  String? _duration;
  String? _country;
  String? _state;
  String? _address;
  String? _purposeOfVisit;
  String? _vehicleModel;
  String? _vehicleColor;
  String? _vehiclePlate;
  List? _items = [];
  bool _loading = false;

  String? get fullName => _fullName;
  String? get phoneNumber => _phoneNumber;
  String? get duration => _duration;
  String? get country => _country;
  String? get state => _state;
  String? get address => _address;
  String? get vehicleColor => _vehicleColor;
  String? get vehiclePlate => _vehiclePlate;
  String? get vehicleModel => _vehicleModel;
  List? get items => _items;
  String? get purposeOfVisit => _purposeOfVisit;
  bool get loading => _loading;

  setItemPass(fullName, phoneNumber, duration, items, country, state, address,
      purposeOfVisit, vehicleModel, vehiclePlate, vehicleColor) {
    _fullName = fullName;
    _phoneNumber = phoneNumber;
    _duration = duration;
    _items = items;
    _country = country;
    _state = state;
    _address = address;
    _purposeOfVisit = purposeOfVisit;
    _vehicleModel = vehicleModel;
    _vehiclePlate = vehiclePlate;
    _vehicleColor = vehicleColor;
  }

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }
}
