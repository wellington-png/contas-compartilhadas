import 'package:conta/config/assets/avatar.dart';
import 'package:conta/domain/models/entities/user/user_entity.dart';

extension UserDto on UserEntity {
  static UserEntity fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'] ?? 0,
      email: json['email'] ?? "",
      name: json['name'] ?? "",
      fixedIncome:
          double.tryParse(json['fixed_income']?.toString() ?? '') ?? 0.0,
      accountType: AccountType.values.firstWhere(
        (element) => element.value == json['account_type'],
        orElse: () => AccountType
            .simple, // Substitua por um valor padrão adequado, se necessário
      ),
      avatar: Avatar.getByIdentifier(json['avatar'] ?? 'defaultAvatar'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'fixed_income': fixedIncome,
      'account_type': accountType.value,
      'avatar': avatar.identifier,
    };
  }
}
