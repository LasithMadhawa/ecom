import 'package:ecom/services/profile.service.dart';
import 'package:flutter/material.dart';
import 'package:ecom/models/user.model.dart';

enum ProfileDataState {
  uninitialized,
  error,
  loading,
  fetched
}

class ProfileProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;
  ProfileDataState _dataState = ProfileDataState.uninitialized;
  ProfileDataState get dataState => _dataState;

  ProfileProvider();

  fetchData() async {
    _dataState = ProfileDataState.loading;
    notifyListeners();
    try {
      _user = await ProfileService.instance.getUser();
      _dataState = ProfileDataState.fetched;
      notifyListeners();
    } catch (e) {
      _dataState = ProfileDataState.error;
      notifyListeners();
    }
  }
}