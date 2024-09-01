import 'package:conta/domain/models/entities/expense/expense_entity.dart';
import 'package:conta/domain/repositories/expense/expense_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:conta/config/exceptions.dart';

class ExpenseService {
  final ExpenseRepository _expenseRepository;

  ExpenseService(this._expenseRepository);

  Future<Either<ProjetoException, List<ExpenseEntity>>> list({
    int? groupId,
    String? dateSpentRangeAfter,
    String? dateSpentRangeBefore,
    bool? isFixed,
    int? month,
    int? year,
  }) async {
    return _expenseRepository.list(
      groupId: groupId,
      dateSpentRangeAfter: dateSpentRangeAfter,
      dateSpentRangeBefore: dateSpentRangeBefore,
      isFixed: isFixed,
      month: month,
      year: year,
    );
  }

  Future<Either<ProjetoException, ExpenseEntity>> create(ExpenseEntity expense) async {
    return _expenseRepository.create(expense);
  }

  Future<Either<ProjetoException, ExpenseEntity>> update(ExpenseEntity expense) async {
    return _expenseRepository.update(expense);
  }

  Future<Either<ProjetoException, bool>> delete(int id) async {
    return _expenseRepository.delete(id);
  }

}
