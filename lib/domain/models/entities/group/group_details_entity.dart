import 'package:conta/domain/models/entities/expense/expense_entity.dart';
import 'package:equatable/equatable.dart';

import 'package:conta/domain/models/entities/user/user_entity.dart';

class GroupDetailsEntity extends Equatable {
  final int id;
  final String name;
  final int owner;
  final List<UserEntity> members;
  final String ownerName;
  final double totalExpenses;
  final double averageExpensesPerPerson;
  final double totalFixedIncome;
  final List<ExpenseEntity> expenses;
  final DateTime createdAt;

  const GroupDetailsEntity({
    required this.id,
    required this.name,
    required this.owner,
    required this.members,
    required this.ownerName,
    required this.totalExpenses,
    required this.averageExpensesPerPerson,
    required this.totalFixedIncome,
    required this.expenses,
    required this.createdAt,
  });

  GroupDetailsEntity.empty()
      : id = 0,
        name = "",
        owner = 0,
        members = const [],
        expenses = const [],
        ownerName = "",
        totalExpenses = 0.0,
        averageExpensesPerPerson = 0.0,
        totalFixedIncome = 0.0,
        createdAt = DateTime(1970, 1, 1);

  GroupDetailsEntity copyWith({
    int? id,
    String? name,
    int? owner,
    List<UserEntity>? members,
    String? ownerName,
    double? totalExpenses,
    double? averageExpensesPerPerson,
    double? totalFixedIncome,
    DateTime? createdAt,
  }) {
    return GroupDetailsEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      owner: owner ?? this.owner,
      members: members ?? this.members,
      expenses: expenses,
      ownerName: ownerName ?? this.ownerName,
      totalExpenses: totalExpenses ?? this.totalExpenses,
      averageExpensesPerPerson:
          averageExpensesPerPerson ?? this.averageExpensesPerPerson,
      totalFixedIncome: totalFixedIncome ?? this.totalFixedIncome,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        owner,
        members,
        expenses,
        ownerName,
        totalExpenses,
        averageExpensesPerPerson,
        totalFixedIncome,
        createdAt,      
      ];
}
