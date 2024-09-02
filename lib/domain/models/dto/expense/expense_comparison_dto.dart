import 'package:conta/domain/models/entities/expense/expense_comparison_entity.dart';

extension ExpenseComparisonDto on ExpenseComparisonEntity {
  static ExpenseComparisonEntity fromJson(Map<String, dynamic> json) {
    return ExpenseComparisonEntity(
      userId: json['user__id'],
      userEmail: json['user__email'],
      totalExpense: json['total_expense'],
      percent: json['percent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userEmail': userEmail,
      'totalExpense': totalExpense,
      'percent': percent,
    };
  }
}