import 'package:conta/domain/models/entities/group/group_details_entity.dart';
import 'package:conta/domain/models/entities/user/user_entity.dart';
import 'package:conta/domain/models/dto/user/user_dto.dart';
import 'package:conta/domain/models/entities/expense/expense_entity.dart';
import 'package:conta/domain/models/dto/expense/expense_dto.dart';

extension GroupDetailsDto on GroupDetailsEntity {
  static GroupDetailsEntity fromJson(Map<String, dynamic> json) {
    return GroupDetailsEntity(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      owner: json['owner'] ?? 0,
      members: (json['members'] as List)
          .map<UserEntity>((e) => UserDto.fromJson(e))
          .toList(),
      ownerName: json['owner_name'] ?? "",
      totalExpenses: (json['total_expenses'] ?? 0.0).toDouble(),
      averageExpensesPerPerson:
          (json['average_expenses_per_person'] ?? 0.0).toDouble(),
      totalFixedIncome: (json['total_fixed_income'] ?? 0.0).toDouble(),
      expenses: (json['expenses'] as List)
          .map<ExpenseEntity>((e) => ExpenseDto.fromJson(e))
          .toList(),
      createdAt: DateTime.parse(json['created_at'] ?? "1970-01-01"),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'owner': owner,
      'members': members.map((member) => member.toJson()).toList(),
      'ownerName': ownerName,
      'totalExpenses': totalExpenses,
      'averageExpensesPerPerson': averageExpensesPerPerson,
      'totalFixedIncome': totalFixedIncome,
      'expenses': expenses.map((expense) => expense.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
