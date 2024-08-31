import 'package:equatable/equatable.dart';

class ExpenseEntity extends Equatable {
  final int id;
  final double amount;
  final String description;
  final DateTime dateSpent;
  final int group;
  final bool isFixed;

  const ExpenseEntity({
    required this.id,
    required this.amount,
    required this.description,
    required this.dateSpent,
    required this.group,
    required this.isFixed,
  });

  ExpenseEntity.empty()
      : id = 0,
        amount = 0.0,
        description = "",
        dateSpent = DateTime(1970, 1, 1),
        group = 0,
        isFixed = false;

  ExpenseEntity copyWith({
    int? id,
    double? amount,
    String? description,
    DateTime? dateSpent,
    int? group,
    bool? isFixed,
  }) {
    return ExpenseEntity(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      dateSpent: dateSpent ?? this.dateSpent,
      group: group ?? this.group,
      isFixed: isFixed ?? this.isFixed,
    );
  }

  @override
  List<Object?> get props => [
        id,
        amount,
        description,
        dateSpent,
        group,
        isFixed,
      ];
}
