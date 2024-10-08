part of 'expense_bloc.dart';

abstract class ExpenseEvent extends Equatable {
  const ExpenseEvent();
}

class ExpenseListRequested extends ExpenseEvent {
  final int? groupId;
  final String? dateSpentRangeAfter;
  final String? dateSpentRangeBefore;
  final bool? isFixed;
  final int? month;
  final int? year;

  const ExpenseListRequested({
    required this.groupId,
    this.dateSpentRangeAfter,
    this.dateSpentRangeBefore,
    this.isFixed,
    this.month,
    this.year,
  });

  @override
  List<Object?> get props => [
        groupId,
        dateSpentRangeAfter,
        dateSpentRangeBefore,
        isFixed,
        month,
        year
      ];
}

class CreateExpenseRequested extends ExpenseEvent {
  final ExpenseEntity expense;

  const CreateExpenseRequested(this.expense);

  @override
  List<Object?> get props => [expense];
}

class DeleteExpenseRequested extends ExpenseEvent {
  final int id;

  const DeleteExpenseRequested(this.id);

  @override
  List<Object?> get props => [id];
}
