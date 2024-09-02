import 'package:conta/domain/models/entities/group/group_details_entity.dart';
import 'package:conta/domain/models/entities/group/group_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:conta/config/exceptions.dart';

abstract class GroupRepository {
  Future<Either<ProjetoException, List<GroupEntity>>> list();
  Future<Either<ProjetoException, GroupDetailsEntity>> details(int id);
  Future<Either<ProjetoException, GroupEntity>> create(String name);
  Future<Either<ProjetoException, GroupDetailsEntity>> updateName(int id, String name);
  Future<Either<ProjetoException, GroupDetailsEntity>> delete(int id);
  Future<Either<ProjetoException, String>> removeMember(int id, int memberId);
}
