part of 'groups_bloc.dart';

abstract class GroupsEvent extends Equatable {
  const GroupsEvent();
}

class GetGroupsEvent extends GroupsEvent {
  const GetGroupsEvent();

  @override
  List<Object?> get props => [];
}
