import 'package:equatable/equatable.dart';
import 'package:conta/config/settings.dart';

class LoginEntity extends Equatable {
  final String email;
  final String password;

  const LoginEntity({
    required this.email,
    required this.password,
  });

  const LoginEntity.empty()
      : email = "",
        password = "";

  LoginEntity copyWith({
    ProjetoGetter<String>? email,
    ProjetoGetter<String>? password,
  }) {
    return LoginEntity(
      email: email != null ? email() : this.email,
      password: password != null ? password() : this.password,
    );
  }

  @override
  List<Object?> get props => [email, password];
}
