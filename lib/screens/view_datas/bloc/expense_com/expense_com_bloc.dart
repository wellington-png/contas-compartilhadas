import 'package:bloc/bloc.dart';
import 'package:conta/domain/models/entities/expense/expense_comparison_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:conta/domain/services/expense_service.dart';

part 'expense_com_events.dart';
part 'expense_com_state.dart';

class ExpenseComBloc extends Bloc<ExpenseComEvent, ExpenseComState> {
  final ExpenseService expenseService;

  ExpenseComBloc({required this.expenseService}) : super(const ExpenseComState()) {
    on<ExpenseComRequested>(_onExpenseComRequested);
    on<UpdateDate>(_onUpdateDate);
    on<ExpenseUpdateGroupId>(_onUpdateGroupId);
  }

  void _onExpenseComRequested(
      ExpenseComRequested event, Emitter<ExpenseComState> emit) async {
    emit(state.copyWith(status: ExpenseComStatus.loading));
    final result = await expenseService.expenseComparison(
        event.id, event.month, event.year);

    result.fold(
      (error) => emit(state.copyWith(
          status: ExpenseComStatus.failure, errorMessage: error.message)),
      (expenses) => emit(state.copyWith(
          status: ExpenseComStatus.success,
          expenses: expenses,
          month: event.month,
          year: event.year)),
    );
  }

  void _onUpdateDate(UpdateDate event, Emitter<ExpenseComState> emit) {
    emit(state.copyWith(month: event.month, year: event.year));
  }

  void _onUpdateGroupId(ExpenseUpdateGroupId event, Emitter<ExpenseComState> emit) {
    emit(state.copyWith(groupId: event.groupId));
  }
}
