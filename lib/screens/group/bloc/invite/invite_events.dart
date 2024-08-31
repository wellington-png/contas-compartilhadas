part of 'invite_bloc.dart';

abstract class InviteEvent extends Equatable {
  const InviteEvent();
}

class SendInviteEvent extends InviteEvent {
  final int groupId;
  final String email;

  const SendInviteEvent({
    required this.groupId,
    required this.email,
  });

  @override
  List<Object?> get props => [groupId, email];
}
