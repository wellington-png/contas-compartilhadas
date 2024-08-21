import 'package:bloc/bloc.dart';
import 'package:conta/domain/models/entities/user/user_entity.dart';
import 'package:conta/domain/services/user_service.dart';

import 'package:equatable/equatable.dart';

import 'package:conta/domain/models/entities/group/group_entity.dart';
import 'package:conta/domain/services/group_service.dart';

part 'home_events.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GroupService groupService;
  final UserService userService;

  HomeBloc({required this.groupService, required this.userService})
      : super(const HomeState()) {
    on<GetGroupsEvent>(_onGetGroupsEvent);
    on<GetUserMeEvent>(_onGetUserMeEvent);
  }

  Future<void> _onGetGroupsEvent(
    GetGroupsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    final result = await groupService.list();
    result.fold(
      (error) => emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: error.message,
        ),
      ),
      (groups) => emit(
        state.copyWith(status: HomeStatus.success, groups: groups),
      ),
    );
  }

  Future<void> _onGetUserMeEvent(
    GetUserMeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeState(status: HomeStatus.loading));
    final result = await userService.me();
    result.fold(
      (error) => emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: error.message,
        ),
      ),
      (user) => emit(HomeState(status: HomeStatus.success, user: user)),
    );
  }
}
