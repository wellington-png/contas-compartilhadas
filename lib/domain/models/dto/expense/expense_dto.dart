import 'package:conta/domain/models/entities/expense/expense_entity.dart';
import 'package:intl/intl.dart';


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
      nameUser: json['name_user'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    // date_spent = 2022-10-10T00:00:00.000 em string
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    return {
      'id': id,
      'amount': amount.toString(),
      'description': description,
      'date_spent': formatter.format(dateSpent),
      'group': group,
      'is_fixed': isFixed,
    };
  }
}
