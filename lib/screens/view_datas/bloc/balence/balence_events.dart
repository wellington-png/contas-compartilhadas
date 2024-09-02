part of 'balence_bloc.dart';

abstract class BalanceEvent extends Equatable {
  const BalanceEvent();
}

class BalanceRequested extends BalanceEvent {

  const BalanceRequested();

  @override
  List<Object> get props => [];
}
