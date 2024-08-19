import 'package:projeto_final_mobile/domain/models/entities/user_entity.dart';

extension UserDto on UserEntity {
  static UserEntity fromJson(Map<String, dynamic> json) {
    return UserEntity(
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
