import 'package:equatable/equatable.dart';
import 'package:conta/config/settings.dart';

class UserRegisterEntity extends Equatable {
  final String email;
  final String password;
  final String name;

  const UserRegisterEntity({
    required this.email,
    required this.password,
    required this.name,
  });

  const UserRegisterEntity.empty()
      : email = "",
        password = "",
        name = "";

  UserRegisterEntity copyWith({
    ProjetoGetter<String>? email,
    ProjetoGetter<String>? password,
    ProjetoGetter<String>? name,
  }) {
    return UserRegisterEntity(
      email: email != null ? email() : this.email,
      password: password != null ? password() : this.password,
      name: name != null ? name() : this.name,
    );
  }

  @override
  List<Object?> get props => [email, password, name];
}
