import 'package:bloc/bloc.dart';
import 'package:conta/domain/models/entities/expense/expense_entity.dart';
import 'package:conta/domain/services/expense_service.dart';
import 'package:equatable/equatable.dart';

part 'expense_events.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseService expenseService;

  ExpenseBloc({required this.expenseService}) : super(const ExpenseState()) {
    on<ExpenseListRequested>(_onExpenseListRequested);
  }

  void _onExpenseListRequested(
      ExpenseListRequested event, Emitter<ExpenseState> emit) async {
    emit(state.copyWith(status: ExpenseStatus.loading));
    final result = await expenseService.list(
      groupId: event.groupId,
      dateSpentRangeAfter: event.dateSpentRangeAfter,
      dateSpentRangeBefore: event.dateSpentRangeBefore,
      isFixed: event.isFixed,
      month: event.month,
      year: event.year,
    );

    result.fold(
      (error) => emit(state.copyWith(
          status: ExpenseStatus.failure, errorMessage: error.message)),
      (expenses) => emit(
          state.copyWith(status: ExpenseStatus.success, expenses: expenses)),
    );
  }
}
