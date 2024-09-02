import 'package:conta/domain/models/entities/expense/balance_entity.dart';

extension BalanceDto on BalanceEntity {
  static BalanceEntity fromJson(Map<String, dynamic> json) {
    return BalanceEntity(
      yearMonth: json['month'],
      fixedIncome: (json['fixed_income'] as num?)?.toDouble() ?? 0.0,
      totalExpense: (json['total_expenses'] as num?)?.toDouble() ?? 0.0,
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': yearMonth,
      'fixed_income': fixedIncome,
      'total_expenses': totalExpense,
      'balance': balance,
    };
  }
}
