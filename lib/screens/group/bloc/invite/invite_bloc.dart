import 'package:bloc/bloc.dart';
import 'package:conta/domain/services/invite_service.dart';
import 'package:equatable/equatable.dart';

part 'invite_events.dart';
part 'invite_state.dart';

class InviteBloc extends Bloc<InviteEvent, InviteState> {
  final InviteService inviteService;

  InviteBloc({required this.inviteService}) : super(const InviteState()) {
    on<SendInviteEvent>(_sendInviteEventToState);
  }

  Future<void> _sendInviteEventToState(
    SendInviteEvent event,
    Emitter<InviteState> emit,
  ) async {
    emit(state.copyWith(status: InviteStatus.loading));
    final result =
        await inviteService.invite(email: event.email, id: event.groupId);

    result.fold(
      (error) {
        emit(
          state.copyWith(
            status: InviteStatus.failure,
            errorMessage: error.message,
          ),
        );
      },
      (groupDetails) => emit(
        state.copyWith(
          status: InviteStatus.success,
        ),
      ),
    );
  }
}
