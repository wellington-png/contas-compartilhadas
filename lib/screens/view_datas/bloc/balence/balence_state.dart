part of 'balence_bloc.dart';

enum BalanceStatus { initial, loading, success, failure }

class BalanceState extends Equatable {
  final BalanceStatus status;
  final BalanceEntity? balance;
  final String? errorMessage;

  const BalanceState({
    this.status = BalanceStatus.initial,
    this.balance,
    this.errorMessage,
  });

  BalanceState copyWith({
    BalanceStatus? status,
    BalanceEntity? balance,
    String? errorMessage,
  }) {
    return BalanceState(
      status: status ?? this.status,
      balance: balance ?? this.balance,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, balance, errorMessage];
}
