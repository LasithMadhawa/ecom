class Auth {
  String? accessToken;
  String? refreshToken;

  Auth();

  Auth.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }
}
