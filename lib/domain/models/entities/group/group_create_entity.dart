import 'package:equatable/equatable.dart';
import 'package:conta/config/settings.dart';

class GroupCreateEntity extends Equatable {
  final String name;

  const GroupCreateEntity({
    required this.name,
  });

  const GroupCreateEntity.empty() : name = "";

  GroupCreateEntity copyWith({
    ProjetoGetter<String>? name,
  }) {
    return GroupCreateEntity(
      name: name != null ? name() : this.name,
    );
  }

  @override
  List<Object?> get props => [name];
}
