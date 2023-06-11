import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecom/screens/login/login-screen.dart';
import 'package:ecom/services/auth.service.dart';
import 'package:flutter/material.dart';

class ResponseInterceptor extends InterceptorsWrapper {
  BuildContext? context;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future? onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint("REQUEST[${options.method}] => PATH: ${options.path}");
    String? token = AuthService.instance.authData?.accessToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
      log('Intercept token $token');
    }
    return super.onRequest(options, handler);
  }

  @override
  onResponse(Response response, handler) {
    if (response.statusCode == 403) {
      //  AuthService.instance.logout();
      navigatorKey.currentState
          ?.push(MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
    return handler.next(response);
  }

  @override
  onError(DioException err, handler) {
    if (err.response?.statusCode == 401) {
      print(navigatorKey.currentState);
      //  AuthService.instance.logout();
      navigatorKey.currentState
          ?.push(MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
    debugPrint(
        "ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}");
    return handler.next(err);
  }

  Future<String> refreshToken() async {
  // Perform a request to the refresh token endpoint and return the new access token.
  // You can replace this with your own implementation.
  return 'your_new_access_token';
}
}
