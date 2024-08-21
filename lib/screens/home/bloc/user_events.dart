part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class GetUserMeEvent extends UserEvent {
  const GetUserMeEvent();

  @override
  List<Object?> get props => [];
}
