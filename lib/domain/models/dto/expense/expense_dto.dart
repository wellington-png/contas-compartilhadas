import 'package:conta/domain/models/entities/expense/expense_entity.dart';

extension ExpenseDto on ExpenseEntity {
  static ExpenseEntity fromJson(Map<String, dynamic> json) {
    return ExpenseEntity(
      id: json['id'] ?? 0,
      amount: double.tryParse(json['amount']?.toString() ?? '0.0') ?? 0.0,
      description: json['description'] ?? "",
      dateSpent:
          DateTime.tryParse(json['date_spent'] ?? "") ?? DateTime(1970, 1, 1),
      group: json['group'] ?? 0,
      isFixed: json['is_fixed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount.toString(),
      'description': description,
      'date_spent': dateSpent.toIso8601String(),
      'group': group,
      'is_fixed': isFixed,
    };
  }
}
