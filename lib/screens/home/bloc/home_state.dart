part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<GroupEntity> groups;
  final String? errorMessage;
  final UserEntity? user;

  const HomeState({
    this.status = HomeStatus.initial,
    this.groups = const [],
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
}
