import 'package:ecom/models/auth.model.dart';
import 'package:ecom/services/auth.service.dart';
import 'package:flutter/material.dart';

enum AuthState {
  uninitialized,
  loading,
  authenticated,
  unauthorized,
}

class AuthProvider extends ChangeNotifier {
  Auth? auth;
  AuthState _authState = AuthState.uninitialized;
  AuthState get authState => _authState;

  AuthProvider();

  initialize() async {
    _authState = AuthState.loading;
    notifyListeners();
    auth = await AuthService.instance.init();
    if (auth != null) {
      _authState = AuthState.authenticated;
    } else {
      _authState = AuthState.unauthorized;
    }
    notifyListeners();
  }

  login(String email, String password) async {
    _authState = AuthState.loading;
    notifyListeners();
    try {
      auth = await AuthService.instance.login(email, password);
      if (auth != null) {
        _authState = AuthState.authenticated;
      } else {
        _authState = AuthState.unauthorized;
      }
      notifyListeners();
    } catch (e) {
      _authState = AuthState.unauthorized;
      notifyListeners();
      // rethrow;
    }
  }

  refreshToken() async {
    _authState = AuthState.loading;
    notifyListeners();
    try {
      auth = await AuthService.instance.refreshToken();
      if (auth != null) {
        _authState = AuthState.authenticated;
      } else {
        _authState = AuthState.unauthorized;
      }
      notifyListeners();
    } catch (e) {
      _authState = AuthState.unauthorized;
      notifyListeners();
      // rethrow;
    }
  }

  logout() {
    _authState = AuthState.unauthorized;
    AuthService.instance.logout();
  }
}