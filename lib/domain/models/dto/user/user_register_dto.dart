import 'package:conta/domain/models/entities/user/user_register_entity.dart';

extension UserRegisterDto on UserRegisterEntity {
  static UserRegisterEntity fromJson(Map<String, dynamic> json) {
    return UserRegisterEntity(
      email: json['email'] ?? "",
      password: json['password'] ?? "",
      name: json['name'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
    };
  }
}
