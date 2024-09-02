import 'package:bloc/bloc.dart';
import 'package:conta/domain/models/entities/expense/balance_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:conta/domain/services/expense_service.dart';

part 'balence_events.dart';
part 'balence_state.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  final ExpenseService expenseService;

  BalanceBloc({required this.expenseService}) : super(const BalanceState()) {
    on<BalanceRequested>(_onBalanceRequested);
  }
  void _onBalanceRequested(
    BalanceRequested event,
    Emitter<BalanceState> emit,
  ) async {
    emit(state.copyWith(status: BalanceStatus.loading));
    final balance = await expenseService.balance();
    balance.fold(
      (error) =>
          emit(state.copyWith(status: BalanceStatus.failure, errorMessage: error.message)),
      (balance) =>
          emit(state.copyWith(status: BalanceStatus.success, balance: balance)),
    );
  }
}
