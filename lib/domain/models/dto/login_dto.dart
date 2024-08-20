import 'package:conta/domain/models/entities/login_entity.dart';

extension UserDto on LoginEntity {
  static LoginEntity fromJson(Map<String, dynamic> json) {
    return LoginEntity(
      username: json['username'] ?? "",
      password: json['password'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
