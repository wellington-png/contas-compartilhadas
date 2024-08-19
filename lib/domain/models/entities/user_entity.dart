import 'package:equatable/equatable.dart';
import 'package:projeto_final_mobile/config/settings.dart';

class UserEntity extends Equatable {
  final String username;
  final String password;

  const UserEntity({
    required this.username,
    required this.password,
  });

  const UserEntity.empty()
      : username = "",
        password = "";

  UserEntity copyWith({
    ProjetoGetter<String>? username,
    ProjetoGetter<String>? password,
  }) {
    return UserEntity(
      username: username != null ? username() : this.username,
      password: password != null ? password() : this.password,
    );
  }

  @override
  List<Object?> get props => [username, password];
}
