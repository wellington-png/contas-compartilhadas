import 'package:equatable/equatable.dart';

class ExpenseComparisonEntity extends Equatable {
  final int userId;
  final String userEmail;
  final double totalExpense;
  final double percent;

  const ExpenseComparisonEntity({
    required this.userId,
    required this.userEmail,
    required this.totalExpense,
    required this.percent,
  });

  const ExpenseComparisonEntity.empty()
      : userId = 0,
        userEmail = '',
        totalExpense = 0.0,
        percent = 0.0;

  ExpenseComparisonEntity copyWith({
    int? userId,
    String? userEmail,
    double? totalExpense,
    double? percent,
  }) {
    return ExpenseComparisonEntity(
      userId: userId ?? this.userId,
      userEmail: userEmail ?? this.userEmail,
      totalExpense: totalExpense ?? this.totalExpense,
      percent: percent ?? this.percent,
    );
  }

  @override
  List<Object?> get props => [userId, userEmail, totalExpense, percent];
}
