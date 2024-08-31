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
