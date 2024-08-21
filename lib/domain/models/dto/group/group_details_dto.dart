import 'package:conta/domain/models/entities/group/group_details_entity.dart';
import 'package:conta/domain/models/entities/user/user_entity.dart';
import 'package:conta/domain/models/dto/user/user_dto.dart';


extension GroupCreateDto on GroupDetailsEntity {
  static GroupDetailsEntity fromJson(Map<String, dynamic> json) {
    return GroupDetailsEntity(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      owner: json['owner'] ?? 0,
      members: (json['members']).map<UserEntity>((e) => UserDto.fromJson(e)).toList(),
      ownerName: json['ownerName'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'owner': owner,
      'members': members,
      'ownerName': ownerName,
    };
  }
}
