part of 'user_bloc.dart';

enum UserStatus { initial, loading, success, failure }

class UserState extends Equatable {
  final UserStatus status;
  final UserEntity? user;
  final String? errorMessage;
  final Avatar? avatar;

  const UserState({
    this.status = UserStatus.initial,
    this.user,
    this.errorMessage,
    this.avatar
  });

  @override
  List<Object?> get props => [
        status,
        user,
        errorMessage,
        avatar
      ];

  UserState copyWith({
    UserStatus? status,
    UserEntity? user,
    String? errorMessage,
    Avatar? avatar
  }) {
    return UserState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      avatar: avatar ?? this.avatar
    );
  }
}
