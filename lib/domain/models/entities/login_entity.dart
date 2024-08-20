import 'package:equatable/equatable.dart';
import 'package:conta/config/settings.dart';

class LoginEntity extends Equatable {
  final String username;
  final String password;

  const LoginEntity({
    required this.username,
    required this.password,
  });

  const LoginEntity.empty()
      : username = "",
        password = "";

  LoginEntity copyWith({
    ProjetoGetter<String>? username,
    ProjetoGetter<String>? password,
  }) {
    return LoginEntity(
      username: username != null ? username() : this.username,
      password: password != null ? password() : this.password,
    );
  }

  @override
  List<Object?> get props => [username, password];
}
