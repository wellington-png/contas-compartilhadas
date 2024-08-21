part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class PerformRegisterEvent extends RegisterEvent {
  final String email;
  final String password;
  final String name;

  const PerformRegisterEvent({
    required this.email,
    required this.password,
    required this.name,
  });

  @override
  List<Object?> get props => [email, password, email, name];
}