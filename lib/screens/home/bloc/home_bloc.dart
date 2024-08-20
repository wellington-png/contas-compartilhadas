import 'package:bloc/bloc.dart';
import 'package:conta/domain/models/entities/user_entity.dart';

import 'package:equatable/equatable.dart';

import 'package:conta/domain/models/entities/group_entity.dart';
import 'package:conta/domain/services/group_service.dart';

part 'home_events.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GroupService groupService;

  HomeBloc({required this.groupService}) : super(const HomeState()) {
    on<GetGroupsEvent>(_onGetGroupsEvent);
  }

  Future<void> _onGetGroupsEvent(
    GetGroupsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeState(status: HomeStatus.loading));
    try {
      final groups = await groupService.list();
      emit(HomeState(
        status: HomeStatus.success,
        groups: groups.getOrElse(() => []),
      ));
    } catch (e) {
      emit(const HomeState(status: HomeStatus.failure));
    }
  }
}
