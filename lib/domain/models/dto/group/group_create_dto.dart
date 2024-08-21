import 'package:conta/domain/models/entities/group/group_create_entity.dart';

extension GroupCreateDto on GroupCreateEntity {
  static GroupCreateEntity fromJson(Map<String, dynamic> json) {
    return GroupCreateEntity(
      name: json['name'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
