import 'package:bloc/bloc.dart';
import 'package:conta/config/assets/avatar.dart';
import 'package:equatable/equatable.dart';

import 'package:conta/domain/models/entities/user/user_entity.dart';
import 'package:conta/domain/services/user_service.dart';

part 'user_events.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService userService;

  UserBloc({required this.userService}) : super(const UserState()) {
    on<GetUserMeEvent>(_onGetUserMeEvent);
    on<UpdateUserEvent>(_onUpdateUserEvent);
    on<UpdateAvatarUserEvent>(_onUpdateAvatarUserEvent);
  }

  Future<void> _onGetUserMeEvent(
    GetUserMeEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserState(status: UserStatus.loading));
    final result = await userService.me();
    result.fold(
      (error) => emit(
        state.copyWith(
          status: UserStatus.failure,
          errorMessage: error.message,
        ),
      ),
      (user) => emit(UserState(status: UserStatus.success, user: user)),
    );
  }

  Future<void> _onUpdateUserEvent(
    UpdateUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserState(status: UserStatus.loading));
    final result = await userService.update(event.user);
    result.fold(
      (error) => emit(
        state.copyWith(
          status: UserStatus.failure,
          errorMessage: error.message,
        ),
      ),
      (user) => emit(UserState(status: UserStatus.success, user: user)),
    );
  }

  void _onUpdateAvatarUserEvent(
    UpdateAvatarUserEvent event,
    Emitter<UserState> emit,
  ) {
    emit(state.copyWith(avatar: event.avatar));
  }
}
