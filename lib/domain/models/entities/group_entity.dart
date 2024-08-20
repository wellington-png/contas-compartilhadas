import 'package:equatable/equatable.dart';
import 'package:conta/config/settings.dart';

class GroupEntity extends Equatable {
  final int id;
  final String name;
  final int owner;

  const GroupEntity({
    required this.name,
    required this.id,
    required this.owner,
  });

  const GroupEntity.empty()
      : name = "",
        id = 0,
        owner = 0;

  GroupEntity copyWith({
    ProjetoGetter<String>? name,
    ProjetoGetter<int>? id,
    ProjetoGetter<int>? owner,
  }) {
    return GroupEntity(
      name: name != null ? name() : this.name,
      id: id != null ? id() : this.id,
      owner: owner != null ? owner() : this.owner,
    );
  }

  @override
  List<Object?> get props => [name, owner, id];
}
