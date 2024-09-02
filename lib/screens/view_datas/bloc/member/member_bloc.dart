import 'package:bloc/bloc.dart';
import 'package:conta/domain/models/entities/user/user_entity.dart';
import 'package:equatable/equatable.dart';

import 'package:conta/domain/services/group_service.dart';

part 'member_events.dart';
part 'member_state.dart';

class MemberBloc extends Bloc<MemberEvents, MemberState> {
  final GroupService groupService;

  MemberBloc({required this.groupService}) : super(const MemberState()) {
    on<GetMemberEvents>(_onGetMemberEvents);
    on<UpdateGroupId>(_onUpdateGroupId);
  }

  Future<void> _onGetMemberEvents(
    GetMemberEvents event,
    Emitter<MemberState> emit,
  ) async {
    emit(state.copyWith(status: MemberStatus.loading));
    final result = await groupService.members(state.groupId!);
    result.fold(
      (error) => emit(
        state.copyWith(
          status: MemberStatus.failure,
          errorMessage: error.message,
        ),
      ),
      (members) => emit(
        state.copyWith(status: MemberStatus.success, members: members),
      ),
    );
  }

  void _onUpdateGroupId(
    UpdateGroupId event,
    Emitter<MemberState> emit,
  ) {
    emit(state.copyWith(groupId: event.id));
  }

}
