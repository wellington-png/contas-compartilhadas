import 'package:bloc/bloc.dart';
import 'package:conta/domain/services/group_service.dart';
import 'package:equatable/equatable.dart';

import 'package:conta/domain/models/entities/group/group_details_entity.dart';

part 'group_details_events.dart';
part 'group_details_state.dart';

class GroupDetailsBloc extends Bloc<GroupDetailsEvent, GroupDetailState> {
  final GroupService groupService;

  GroupDetailsBloc({required this.groupService})
      : super(const GroupDetailState()) {
    on<GetGroupDetailsEvent>(_getGroupDetailsEventToState);
    on<UpdateGroupNameEvent>(updateGroupName);
    on<RemoveMemberEvent>(_onRemoveMember);
  }

  Future<void> _getGroupDetailsEventToState(
    GetGroupDetailsEvent event,
    Emitter<GroupDetailState> emit,
  ) async {
    emit(state.copyWith(status: GroupDetailStatus.loading));
    final result = await groupService.details(event.id);

    result.fold(
      (error) {
        emit(
          state.copyWith(
            status: GroupDetailStatus.failure,
            errorMessage: error.message,
          ),
        );
      },
      (groupDetails) => emit(
        state.copyWith(
          status: GroupDetailStatus.success,
          group: groupDetails,
        ),
      ),
    );
  }

  Future<void> updateGroupName(
    UpdateGroupNameEvent event,
    Emitter<GroupDetailState> emit,
  ) async {
    emit(state.copyWith(status: GroupDetailStatus.loading));
    final result = await groupService.updateName(event.id, event.name);

    result.fold(
        (error) => emit(
              state.copyWith(
                status: GroupDetailStatus.failure,
                errorMessage: error.message,
              ),
            ), (groupDetails) {
      emit(
        state.copyWith(
          status: GroupDetailStatus.success,
          group: groupDetails,
        ),
      );
    });
  }

  Future<void> _onRemoveMember(
    RemoveMemberEvent event,
    Emitter<GroupDetailState> emit,
  ) async {
    emit(state.copyWith(status: GroupDetailStatus.loading));
    final result = await groupService.removeMember(event.id, event.memberId);

    result.fold(
      (error) {
        emit(
          state.copyWith(
            status: GroupDetailStatus.failure,
            errorMessage: error.message,
          ),
        );
      },
      (message) {
        final currentGroup = state.group;
        if (currentGroup != null) {
          emit(
            state.copyWith(
              status: GroupDetailStatus.success,
              group: currentGroup.copyWith(
                members: currentGroup.members
                    .where((member) => member.id != event.memberId)
                    .toList(),
              ),
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: GroupDetailStatus.failure,
              errorMessage: "Grupo não encontrado",
            ),
          );
        }
      },
    );
  }
}
