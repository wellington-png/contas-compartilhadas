part of 'expense_bloc.dart';

enum ExpenseStatus { initial, loading, success, failure }

class ExpenseState extends Equatable {
  final ExpenseStatus status;
  final List<ExpenseEntity>? expenses;
  final String? errorMessage;

  const ExpenseState({
    this.status = ExpenseStatus.initial,
    this.expenses,
    this.errorMessage,
  });

  ExpenseState copyWith({
    ExpenseStatus? status,
    List<ExpenseEntity>? expenses,
    String? errorMessage,
  }) {
    return ExpenseState(
      status: status ?? this.status,
      expenses: expenses ?? this.expenses,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, expenses, errorMessage];
}
