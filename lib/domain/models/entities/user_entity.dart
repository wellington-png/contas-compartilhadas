import 'package:equatable/equatable.dart';
import 'package:conta/config/settings.dart';

class UserEntity extends Equatable {
  final String username;
  final String password;
  final String email;
  final String name;

  const UserEntity({
    required this.username,
    required this.password,
    required this.email,
    required this.name,
  });

  const UserEntity.empty()
      : username = "",
        password = "",
        email = "",
        name = "";

  UserEntity copyWith({
    ProjetoGetter<String>? username,
    ProjetoGetter<String>? password,
    ProjetoGetter<String>? email,
    ProjetoGetter<String>? name,
  }) {
    return UserEntity(
      username: username != null ? username() : this.username,
      password: password != null ? password() : this.password,
      email: email != null ? email() : this.email,
      name: name != null ? name() : this.name,
    );
  }

  @override
  List<Object?> get props => [username, password, email, name];
}
