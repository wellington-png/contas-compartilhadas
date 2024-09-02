import 'package:conta/domain/models/dto/expense/balance_dto.dart';
import 'package:conta/domain/models/dto/expense/expense_comparison_dto.dart';
import 'package:conta/domain/models/dto/expense/expense_dto.dart';
import 'package:conta/domain/models/entities/expense/balance_entity.dart';
import 'package:conta/domain/models/entities/expense/expense_comparison_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:conta/config/exceptions.dart';
import 'package:conta/config/services/http_service.dart';
import 'package:conta/config/settings.dart';
import 'package:conta/domain/models/entities/expense/expense_entity.dart';
import 'package:conta/domain/repositories/expense/expense_repository.dart';
import 'package:intl/intl.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final HttpService _httpService;

  ExpenseRepositoryImpl({required HttpService httpService})
      : _httpService = httpService;

  @override
  Future<Either<ProjetoException, List<ExpenseEntity>>> list({
    int? groupId,
    String? dateSpentRangeAfter,
    String? dateSpentRangeBefore,
    bool? isFixed,
    int? month,
    int? year,
  }) async {
    try {
      final response = await _httpService.get(
        path: API.expenseList(
          groupId: groupId,
          dateSpentRangeAfter: dateSpentRangeAfter,
          dateSpentRangeBefore: dateSpentRangeBefore,
          isFixed: isFixed,
          month: month,
          year: year,
        ),
        isAuth: true,
      );

      return response.statusCode == 200
          ? Right(
              (response.data as List)
                  .map<ExpenseEntity>((e) => ExpenseDto.fromJson(e))
                  .toList(),
            )
          : Left(ProjetoException(message: "Erro ao listar despesas"));
    } on DioException catch (e) {
      return Left(
        ProjetoException(message: e.response?.data['message'] ?? e.message),
      );
    }
  }

  @override
  Future<Either<ProjetoException, ExpenseEntity>> create(
    ExpenseEntity expense,
  ) async {
    try {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');

      var data = {
        "description": expense.description,
        "amount": expense.amount,
        "date_spent": formatter.format(expense.dateSpent),
        "is_fixed": expense.isFixed,
        "group": expense.group,
      };

      final response = await _httpService.post(
        path: API.addExpense(expense.group),
        data: data,
        isAuth: true,
      );

      return response.statusCode == 201
          ? Right(ExpenseDto.fromJson(response.data))
          : Left(ProjetoException(message: "Erro ao criar despesa"));
    } on DioException catch (e) {
      return Left(
        ProjetoException(message: e.response?.data['message'] ?? e.message),
      );
    }
  }

  @override
  Future<Either<ProjetoException, ExpenseEntity>> update(
    ExpenseEntity expense,
  ) async {
    try {
      final response = await _httpService.put(
        path: API.expenseUpdate(expense.id!),
        data: expense.toJson(),
        isAuth: true,
      );

      return response.statusCode == 200
          ? Right(ExpenseDto.fromJson(response.data))
          : Left(ProjetoException(message: "Erro ao atualizar despesa"));
    } on DioException catch (e) {
      return Left(
        ProjetoException(message: e.response?.data['message'] ?? e.message),
      );
    }
  }

  @override
  Future<Either<ProjetoException, bool>> delete(
    int id,
  ) async {
    try {
      final response = await _httpService.delete(
        path: API.expenseDelete(id),
        isAuth: true,
      );

      return response.statusCode == 204
          ? const Right(true)
          : Left(ProjetoException(message: "Erro ao deletar despesa"));
    } on DioException catch (e) {
      return Left(
        ProjetoException(message: e.response?.data['message'] ?? e.message),
      );
    }
  }

  @override
  Future<Either<ProjetoException, List<ExpenseComparisonEntity>>>
      expenseComparison(
    int id,
    int month,
    int year,
  ) async {
    try {
      final response = await _httpService.get(
        path: API.expenseComparison(id, month, year),
        isAuth: true,
      );

      return response.statusCode == 200
          ? Right(
              (response.data as List)
                  .map<ExpenseComparisonEntity>(
                    (e) => ExpenseComparisonDto.fromJson(e),
                  )
                  .toList(),
            )
          : Left(ProjetoException(message: "Erro ao comparar despesas"));
    } on DioException catch (e) {
      return Left(
        ProjetoException(message: e.response?.data['message'] ?? e.message),
      );
    }
  }

  @override
  Future<Either<ProjetoException, BalanceEntity>> balance() async {
    try {
      final response = await _httpService.get(
        path: API.balance,
        isAuth: true,
      );

      return response.statusCode == 200
          ? Right(BalanceDto.fromJson(response.data))
          : Left(ProjetoException(message: "Erro ao buscar balanço"));
    } on DioException catch (e) {
      return Left(
        ProjetoException(message: e.response?.data['message'] ?? e.message),
      );
    }
  }
}
