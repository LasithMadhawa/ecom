import 'package:dio/dio.dart';
import 'package:ecom/config.dart';
import 'package:ecom/interceptors/response_interceptor.dart';
import 'package:ecom/models/user.model.dart';

class ProfileService {
  static final ProfileService _instance = ProfileService._privateConstructor();

  static ProfileService get instance => _instance;

  final Dio dio = Dio();

  ProfileService._privateConstructor() {
    dio.interceptors.add(ResponseInterceptor());
  }

  Future<User?> getUser() async {
    try {
      String? url = '${Config.AUTH_URL}/auth/profile';
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        throw Exception('Failed to load profile');
      }
    } catch (e) {
      rethrow;
    }
  }
}