part of 'member_bloc.dart';

enum MemberStatus { initial, loading, success, failure }

class MemberState extends Equatable {
  final MemberStatus status;
  final List<UserEntity>? members;
  final String? errorMessage;
  final int? groupId;

  const MemberState({
    this.status = MemberStatus.initial,
    this.members,
    this.errorMessage,
    this.groupId,
  });

  @override
  List<Object?> get props => [
        status,
        members,
        errorMessage,
        groupId,
      ];

  MemberState copyWith({
    MemberStatus? status,
    List<UserEntity>? members,
    String? errorMessage,
    int? groupId,
  }) {
    return MemberState(
      status: status ?? this.status,
      members: members ?? this.members,
      errorMessage: errorMessage ?? this.errorMessage,
      groupId: groupId ?? this.groupId,
    );
  }
}
