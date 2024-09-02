part of 'expense_com_bloc.dart';

enum ExpenseComStatus { initial, loading, success, failure }

class ExpenseComState extends Equatable {
  final ExpenseComStatus status;
  final List<ExpenseComparisonEntity>? expenses;
  final String? errorMessage;
  final int? month;
  final int? year;
  final int? groupId;

  const ExpenseComState({
    this.status = ExpenseComStatus.initial,
    this.expenses,
    this.errorMessage,
    this.month,
    this.year,
    this.groupId,
  });

  ExpenseComState copyWith({
    ExpenseComStatus? status,
    List<ExpenseComparisonEntity>? expenses,
    String? errorMessage,
    int? month,
    int? year,
    int? groupId,
  }) {
    return ExpenseComState(
      status: status ?? this.status,
      expenses: expenses ?? this.expenses,
      errorMessage: errorMessage ?? this.errorMessage,
      month: month ?? this.month,
      year: year ?? this.year,
      groupId: groupId ?? this.groupId,
    );
  }

  @override
  List<Object?> get props => [status, expenses, errorMessage, month, year, groupId];
}
