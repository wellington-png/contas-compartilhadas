import 'package:conta/config/exceptions.dart';
import 'package:conta/domain/models/entities/expense/expense_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ExpenseRepository {
  Future<Either<ProjetoException, List<ExpenseEntity>>> list(
      {int? groupId,
      String? dateSpentRangeAfter,
      String? dateSpentRangeBefore,
      bool? isFixed,
      int? month,
      int? year}
  );
  Future<Either<ProjetoException, ExpenseEntity>> create(ExpenseEntity expense);
  Future<Either<ProjetoException, ExpenseEntity>> update(ExpenseEntity expense);
  Future<Either<ProjetoException, bool>> delete(int id);
}