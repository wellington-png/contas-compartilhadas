// import 'package:conta/domain/models/entities/group_entity.dart';
import 'package:conta/config/exceptions.dart';
import 'package:conta/domain/models/entities/group/group_entity.dart';
import 'package:conta/domain/repositories/group/group_repository.dart';
import 'package:dartz/dartz.dart';

class GroupService {
  final GroupRepository _groupRepository;

  GroupService(this._groupRepository);

  Future<Either<ProjetoException, List<GroupEntity>>> list() async =>  await _groupRepository.list();
  
}
