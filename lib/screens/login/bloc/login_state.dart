part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final LoginStatus status;
  final LoginEntity? user;

  const LoginState({this.status = LoginStatus.initial, this.user});

  @override
  List<Object?> get props => [status, user];
}
