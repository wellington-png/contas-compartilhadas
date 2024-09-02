import 'package:equatable/equatable.dart';

class ExpenseEntity extends Equatable {
  final int? id;
  final double amount;
  final String description;
  final DateTime dateSpent;
  final int group;
  final bool isFixed;
  final String? nameUser;

  const ExpenseEntity({
    this.id,
    required this.amount,
    required this.description,
    required this.dateSpent,
    required this.group,
    required this.isFixed,
    this.nameUser,
  });

  ExpenseEntity.empty()
      : id = 0,
        amount = 0.0,
        description = "",
        dateSpent = DateTime(1970, 1, 1),
        group = 0,
        isFixed = false,
        nameUser = "";

  ExpenseEntity copyWith({
    int? id,
    double? amount,
    String? description,
    DateTime? dateSpent,
    int? group,
    bool? isFixed,
    nameUser,
  }) {
    return ExpenseEntity(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      dateSpent: dateSpent ?? this.dateSpent,
      group: group ?? this.group,
      isFixed: isFixed ?? this.isFixed,
      nameUser: nameUser ?? this.nameUser,
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
