import 'package:dartz/dartz.dart';
import 'package:conta/config/exceptions.dart';
import 'package:conta/domain/models/entities/group/group_details_entity.dart';
import 'package:conta/domain/models/entities/group/group_entity.dart';
import 'package:conta/domain/repositories/group/group_repository.dart';

class GroupService {
  final GroupRepository _groupRepository;

  GroupService(this._groupRepository);

  Future<Either<ProjetoException, List<GroupEntity>>> list() async =>  await _groupRepository.list();
  
  Future<Either<ProjetoException, GroupDetailsEntity>> details(int id) async => await _groupRepository.details(id);

  Future<Either<ProjetoException, GroupEntity>> create(String name) async => await _groupRepository.create(name);

  Future<Either<ProjetoException, GroupDetailsEntity>> updateName(int id, String name) async => await _groupRepository.updateName(id, name);

  Future<Either<ProjetoException, GroupDetailsEntity>> delete(int id) async => await _groupRepository.delete(id);

  Future<Either<ProjetoException, String>> removeMember(int id, int memberId) async => await _groupRepository.removeMember(id, memberId);

}
