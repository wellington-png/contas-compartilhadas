part of 'home_bloc.dart';


abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetGroupsEvent extends HomeEvent {
  const GetGroupsEvent();

  @override
  List<Object?> get props => [];
}