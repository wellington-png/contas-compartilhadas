part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class PerformLoginEvent extends LoginEvent {
  final String username;
  final String password;

  const PerformLoginEvent({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [username, password];
}

class PerformLogoutEvent extends LoginEvent {
  const PerformLogoutEvent();

  @override
  List<Object?> get props => [];
}

class GetLoginDataEvent extends LoginEvent {
  const GetLoginDataEvent();

  @override
  List<Object?> get props => [];
}
