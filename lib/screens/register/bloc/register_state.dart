part of 'register_bloc.dart';

enum RegisterStatus { initial, loading, success, failure }

class RegisterState extends Equatable {
  final RegisterStatus status;
  final UserRegisterEntity? user;
  final String? errorMessage;

  const RegisterState({this.status = RegisterStatus.initial, this.user,this.errorMessage});

  @override
  List<Object?> get props => [status, user, errorMessage];
}
