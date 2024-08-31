part of 'invite_bloc.dart';


enum InviteStatus { initial, loading, success, failure }

class InviteState extends Equatable {
  final InviteStatus status;
  final String? errorMessage;

  const InviteState({
    this.status = InviteStatus.initial,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        status,
        errorMessage,
      ];

  InviteState copyWith({
    InviteStatus? status,
    String? errorMessage,
  }) {
    return InviteState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}