import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecom/models/auth.model.dart';
import 'package:ecom/screens/login/login-screen.dart';
import 'package:ecom/services/auth.service.dart';
import 'package:flutter/material.dart';

class ResponseInterceptor extends InterceptorsWrapper {
  BuildContext? context;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Dio dio = Dio();

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
      navigatorKey.currentState
          ?.push(MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
    return handler.next(response);
  }

  @override
  onError(DioException err, handler) async {
    if (err.response?.statusCode == 401) {
      // If a 401 response is received, refresh the access token
      String? newAccessToken = await refreshToken();

      if (newAccessToken != null) {
        // Update the request header with the new access token
        err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

        // Repeat the request with the updated header
        return handler.resolve(await dio.fetch(err.requestOptions));
      }
      navigatorKey.currentState
          ?.push(MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
    debugPrint(
        "ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}");
    return handler.next(err);
  }

  Future<String?> refreshToken() async {
    Auth? auth = await AuthService.instance.refreshToken();
    return auth?.accessToken;
  }
}
