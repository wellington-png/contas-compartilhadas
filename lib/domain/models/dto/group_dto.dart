import 'package:conta/domain/models/entities/group_entity.dart';

extension GroupDto on GroupEntity {
  static GroupEntity fromJson(Map<String, dynamic> json) {
    return GroupEntity(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      owner: json['owner'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'owner': owner,
    };
  }
}
