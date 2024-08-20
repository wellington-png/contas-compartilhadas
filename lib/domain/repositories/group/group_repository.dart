import 'package:conta/domain/models/entities/group_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:conta/config/exceptions.dart';

abstract class GroupRepository {
  Future<Either<ProjetoException, List<GroupEntity>>> list();
}
