part of 'expense_com_bloc.dart';

abstract class ExpenseComEvent extends Equatable {
  const ExpenseComEvent();
}

class ExpenseComRequested extends ExpenseComEvent {
  final int id;
  final int month;
  final int year;

  const ExpenseComRequested({
    required this.id,
    required this.month,
    required this.year,
  });

  @override
  List<Object> get props => [];
}

class UpdateDate extends ExpenseComEvent {
  final int month;
  final int year;

  const UpdateDate({
    required this.month,
    required this.year,
  });

  @override
  List<Object> get props => [month, year];
}

class ExpenseUpdateGroupId extends ExpenseComEvent {
  final int groupId;

  const ExpenseUpdateGroupId({
    required this.groupId,
  });

  @override
  List<Object> get props => [groupId];
}

