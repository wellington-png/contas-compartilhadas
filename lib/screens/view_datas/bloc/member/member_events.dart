part of 'member_bloc.dart';

abstract class MemberEvents extends Equatable {
  const MemberEvents();
}

class GetMemberEvents extends MemberEvents {
  final int id;
  const GetMemberEvents(this.id);

  @override
  List<Object?> get props => [id];
}

class UpdateGroupId extends MemberEvents {
  final int id;
  const UpdateGroupId(this.id);

  @override
  List<Object?> get props => [id];
}