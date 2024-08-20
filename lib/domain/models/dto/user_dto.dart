import 'package:conta/domain/models/entities/user_entity.dart';

extension UserDto on UserEntity {
  static UserEntity fromJson(Map<String, dynamic> json) {
    return UserEntity(
      username: json['username'] ?? "",
      password: json['password'] ?? "",
      email: json['email'] ?? "",
      name: json['name'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'email': email,
      'name': name,
    };
  }
}
