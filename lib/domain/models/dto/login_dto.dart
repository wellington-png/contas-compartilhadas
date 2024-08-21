import 'package:conta/domain/models/entities/login_entity.dart';

extension UserDto on LoginEntity {
  static LoginEntity fromJson(Map<String, dynamic> json) {
    return LoginEntity(
      email: json['email'] ?? "",
      password: json['password'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
