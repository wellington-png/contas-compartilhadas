part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class PerformRegisterEvent extends RegisterEvent {
  final String username;
  final String password;
  final String email;
  final String name;

  const PerformRegisterEvent({
    required this.username,
    required this.password,
    required this.email,
    required this.name,
  });

  @override
  List<Object?> get props => [username, password, email, name];
}