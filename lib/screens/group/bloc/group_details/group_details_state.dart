part of 'group_details_bloc.dart';

enum GroupDetailStatus { initial, loading, success, failure }

class GroupDetailState extends Equatable {
  final GroupDetailStatus status;
  final GroupDetailsEntity? group;
  final String? errorMessage;

  const GroupDetailState({
    this.status = GroupDetailStatus.initial,
    this.group,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        status,
        group,
        errorMessage,
      ];

  GroupDetailState copyWith({
    GroupDetailStatus? status,
    GroupDetailsEntity? group,
    String? errorMessage,
  }) {
    return GroupDetailState(
      status: status ?? this.status,
      group: group ?? this.group,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
