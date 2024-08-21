import 'package:equatable/equatable.dart';
import 'package:conta/config/settings.dart';

enum AccountType {
  simple('Simple'),
  prime('Prime');

  final String value;

  const AccountType(this.value);

  @override
  String toString() => value;
}

class UserEntity extends Equatable {
  final int id;
  final String email;
  final String name;
  final double fixedIncome;
  final AccountType accountType;

  const UserEntity({
    required this.email,
    required this.name,
    required this.fixedIncome,
    required this.accountType,
    required this.id,
  });

  const UserEntity.empty()
      : email = "",
        name = "",
        fixedIncome = 0.0,
        accountType = AccountType.simple,
        id = 0;

  UserEntity copyWith({
    ProjetoGetter<String>? email,
    ProjetoGetter<String>? name,
    ProjetoGetter<double>? fixedIncome,
    ProjetoGetter<String>? accountType,
    ProjetoGetter<int>? id,
  }) {
    return UserEntity(
      email: email != null ? email() : this.email,
      name: name != null ? name() : this.name,
      fixedIncome: fixedIncome != null ? fixedIncome() : this.fixedIncome,
      accountType: accountType != null
          ? AccountType.values.firstWhere(
              (element) => element.value == accountType(),
            )
          : this.accountType,
      id: id != null ? id() : this.id,
    );
  }

  @override
  List<Object?> get props => [email, name, fixedIncome, accountType, id];
}
