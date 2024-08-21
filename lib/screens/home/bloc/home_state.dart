part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<GroupEntity>? groups;
  final String? errorMessage;
  final UserEntity? user;

  const HomeState({
    this.status = HomeStatus.initial,
    this.groups,
    this.errorMessage,
    this.user,
  });

  @override
  List<Object?> get props => [
        status,
        groups,
        errorMessage,
        user,
      ];

  HomeState copyWith({
    HomeStatus? status,
    List<GroupEntity>? groups,
    String? errorMessage,
    UserEntity? user,
  }) {
    return HomeState(
      status: status ?? this.status,
      groups: groups ?? this.groups,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }
}
