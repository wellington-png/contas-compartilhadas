import 'package:equatable/equatable.dart';

import 'package:conta/domain/models/entities/user/user_entity.dart';


class GroupDetailsEntity extends Equatable {
  final int id;
  final String name;
  final int owner;
  final List<UserEntity> members;
  final String ownerName;

  const GroupDetailsEntity({
    required this.id,
    required this.name,
    required this.owner,
    required this.members,
    required this.ownerName,
  });

  const GroupDetailsEntity.empty()
      : id = 0,
        name = "",
        owner = 0,
        members = const [],
        ownerName = "";

  
  GroupDetailsEntity copyWith({
    int? id,
    String? name,
    int? owner,
    List<UserEntity>? members,
    String? ownerName,
  }) {
    return GroupDetailsEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      owner: owner ?? this.owner,
      members: members ?? this.members,
      ownerName: ownerName ?? this.ownerName,
    );
  }

  @override
  List<Object?> get props => [id, name, owner, members, ownerName];
}
