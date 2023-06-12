class User {
  int? id;
  String? email;
  String? name;
  String? avatar;

  User();

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    avatar = json['avatar'];
  }

  static List<User> listFromJson(List<dynamic> json) {
    return json.map((value) => User.fromJson(value)).toList();
  }
}
