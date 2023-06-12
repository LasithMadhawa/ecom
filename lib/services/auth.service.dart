import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecom/config.dart';
import 'package:ecom/interceptors/response_interceptor.dart';
import 'package:ecom/models/auth.model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static final AuthService _instance = AuthService._privateConstructor();

  String? error;
  static AuthService get instance => _instance;

  final storage = const FlutterSecureStorage();
  final Dio dio = Dio();

  Auth? _authData;
  Auth? get authData => _authData;

  AuthService._privateConstructor() {
    dio.interceptors.add(ResponseInterceptor());
  }

  // Initializing authentication from the device storage
  Future<Auth?> init() async {
    try {
      var accessToken = await storage.read(key: '__ecom_accesstoken');
      var refreshToken = await storage.read(key: '__ecom_refreshtoken');

      if (accessToken != null && accessToken != "") {
        _authData = Auth.fromJson({
          "access_token": accessToken,
          "refresh_token": refreshToken,
        });
        return _authData;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Login request
  Future<Auth?> login(String email, String password) async {
    log("LoggingIn");
    try {
      String url = '${Config.AUTH_URL}/auth/login';
      final response = await dio.post(url, data: {
        "email": email,
        "password": password,
      });
      if (response.statusCode == 201) {
        _authData = Auth.fromJson(response.data);
        if (_authData != null) {
          _setAuth(_authData!);
        }
        return _authData;
      }
      return null;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // Refreshing roken
  Future<Auth?> refreshToken() async {
    try {
      String url = '${Config.AUTH_URL}/auth/refresh-token';
      final response = await dio.post(url, data: {
        "refreshToken": _authData?.refreshToken,
      });
      if (response.statusCode == 201) {
        _authData = Auth.fromJson(response.data);
        if (_authData != null) {
          _setAuth(_authData!);
        }
        return _authData;
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // Store tokens
  _setAuth(Auth auth) async {
    await storage.write(key: '__ecom_accesstoken', value: auth.accessToken);
    await storage.write(key: '__ecom_refreshtoken', value: auth.refreshToken);
  }

  // Logout; Session end
  logout() {
    storage.deleteAll();
    _authData = null;
  }
}