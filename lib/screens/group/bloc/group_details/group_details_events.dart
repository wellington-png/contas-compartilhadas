part of 'group_details_bloc.dart';

abstract class GroupDetailsEvent extends Equatable {
  const GroupDetailsEvent();
}

class GetGroupDetailsEvent extends GroupDetailsEvent {
  final int id;
  const GetGroupDetailsEvent({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}

class UpdateGroupNameEvent extends GroupDetailsEvent {
  final int id;
  final String name;
  const UpdateGroupNameEvent({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}

class RemoveMemberEvent extends GroupDetailsEvent {
  final int id;
  final int memberId;
  const RemoveMemberEvent({
    required this.id,
    required this.memberId,
  });

  @override
  List<Object?> get props => [id, memberId];
}