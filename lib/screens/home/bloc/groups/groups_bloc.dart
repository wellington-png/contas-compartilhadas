import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:conta/domain/models/entities/group/group_entity.dart';
import 'package:conta/domain/services/group_service.dart';

part 'groups_events.dart';
part 'groups_state.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  final GroupService groupService;

  GroupsBloc({required this.groupService}) : super(const GroupsState()) {
    on<GetGroupsEvent>(_onGetGroupsEvent);
    on<CreateGroupEvent>(_onCreateGroupEvent);
  }

  Future<void> _onGetGroupsEvent(
    GetGroupsEvent event,
    Emitter<GroupsState> emit,
  ) async {
    emit(state.copyWith(status: GroupsStatus.loading));
    final result = await groupService.list();
    result.fold(
      (error) => emit(
        state.copyWith(
          status: GroupsStatus.failure,
          errorMessage: error.message,
        ),
      ),
      (groups) => emit(
        state.copyWith(status: GroupsStatus.success, groups: groups),
      ),
    );
  }

  Future<void> _onCreateGroupEvent(
    CreateGroupEvent event,
    Emitter<GroupsState> emit,
  ) async {
    emit(state.copyWith(status: GroupsStatus.loading));
    final result = await groupService.create(event.groupName);
    result.fold(
      (error) => emit(
        state.copyWith(
          status: GroupsStatus.failure,
          errorMessage: error.message,
        ),
      ),
      (group) => emit(
        state.copyWith(
          status: GroupsStatus.success,
          groups: [...state.groups ?? [], group],
        ),
      ),
    );
  }
}
