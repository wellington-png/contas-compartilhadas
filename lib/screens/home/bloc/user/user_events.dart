part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class GetUserMeEvent extends UserEvent {
  const GetUserMeEvent();

  @override
  List<Object?> get props => [];
}

class UpdateUserEvent extends UserEvent {
  final UserEntity user;

  const UpdateUserEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class UpdateAvatarUserEvent extends UserEvent {
  final Avatar avatar;

  const UpdateAvatarUserEvent({required this.avatar});

  @override
  List<Object?> get props => [avatar];
}
