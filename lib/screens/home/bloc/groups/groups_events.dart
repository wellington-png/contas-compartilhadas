part of 'groups_bloc.dart';

abstract class GroupsEvent extends Equatable {
  const GroupsEvent();
}

class GetGroupsEvent extends GroupsEvent {
  const GetGroupsEvent();

  @override
  List<Object?> get props => [];
}


class CreateGroupEvent extends GroupsEvent {
  final String groupName;

  const CreateGroupEvent(this.groupName);

  @override
  List<Object?> get props => [groupName];
}

class DeleteGroupEvent extends GroupsEvent {
  final int groupId;

  const DeleteGroupEvent(this.groupId);

  @override
  List<Object?> get props => [groupId];
}