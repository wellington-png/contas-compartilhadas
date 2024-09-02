import 'package:equatable/equatable.dart';

class BalanceEntity extends Equatable {
  final String yearMonth;
  final double fixedIncome;
  final double totalExpense;
  final double balance;

  const BalanceEntity({
    required this.yearMonth,
    required this.fixedIncome,
    required this.totalExpense,
    required this.balance,
  });

  const BalanceEntity.empty()
      : yearMonth = '',
        fixedIncome = 0.0,
        totalExpense = 0.0,
        balance = 0.0;

  BalanceEntity copyWith({
    String? yearMonth,
    double? fixedIncome,
    double? totalExpense,
    double? balance,
  }) {
    return BalanceEntity(
      yearMonth: yearMonth ?? this.yearMonth,
      fixedIncome: fixedIncome ?? this.fixedIncome,
      totalExpense: totalExpense ?? this.totalExpense,
      balance: balance ?? this.balance,
    );
  }

  @override
  List<Object?> get props => [yearMonth, fixedIncome, totalExpense, balance];
}
