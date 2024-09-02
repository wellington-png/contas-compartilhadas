import 'package:conta/domain/models/dto/group/group_details_dto.dart';
import 'package:conta/domain/models/dto/group/group_dto.dart';
import 'package:conta/domain/models/entities/group/group_details_entity.dart';
import 'package:conta/domain/models/entities/group/group_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:conta/config/exceptions.dart';
import 'package:conta/config/services/http_service.dart';
import 'package:conta/config/settings.dart';

import 'package:conta/domain/repositories/group/group_repository.dart';

class GroupRepositoryImpl implements GroupRepository {
  final HttpService _httpService;

  GroupRepositoryImpl({required HttpService httpService})
      : _httpService = httpService;

  @override
  Future<Either<ProjetoException, List<GroupEntity>>> list() async {
    try {
      Response response = await _httpService.get(
        path: API.groupList,
        isAuth: true,
      );
      return response.statusCode == 200
          ? Right(
              response.data
                  .map<GroupEntity>((e) => GroupDto.fromJson(e))
                  .toList(),
            )
          : Left(ProjetoException(message: "Erro ao criar usuarios"));
    } on DioException catch (e) {
      return Left(
        ProjetoException(message: e.response?.data['message'] ?? e.message),
      );
    }
  }

  @override
  Future<Either<ProjetoException, GroupDetailsEntity>> details(int id) async {
    try {
      Response response = await _httpService.get(
        path: API.groupDetails(id),
        isAuth: true,
      );
      return response.statusCode == 200
          ? Right(GroupDetailsDto.fromJson(response.data))
          : Left(ProjetoException(message: "Erro ao carregar grupo"));
    } on DioException catch (e) {
      return Left(
        ProjetoException(message: e.response?.data['message'] ?? e.message),
      );
    }
  }

  @override
  Future<Either<ProjetoException, GroupEntity>> create(
      String name) async {
    try {
      Response response = await _httpService.post(
        path: API.groupCreate,
        isAuth: true,
        data: {"name": name},
      );
      return response.statusCode == 201
          ? Right(GroupDto.fromJson(response.data))
          : Left(ProjetoException(message: "Erro ao criar grupo"));
    } on DioException catch (e) {
      return Left(
        ProjetoException(message: e.response?.data['message'] ?? e.message),
      );
    }
  }

  @override
  Future<Either<ProjetoException, GroupDetailsEntity>> updateName(
    int id,
    String name,
  ) async {
    try {
      Response response = await _httpService.put(
        path: API.groupUpdate(id),
        isAuth: true,
        data: {"name": name},
      );

      return response.statusCode == 200
          ? Right(GroupDetailsDto.fromJson(response.data))
          : Left(ProjetoException(message: "Erro ao atualizar grupo"));
    } on DioException catch (e) {
      return Left(
        ProjetoException(message: e.response?.data['message'] ?? e.message),
      );
    }
  }

  @override
  Future<Either<ProjetoException, GroupDetailsEntity>> delete(int id) async {
    try {
      Response response = await _httpService.delete(
        path: API.groupDelete(id),
        isAuth: true,
      );

      return response.statusCode == 204
          ? Right(GroupDetailsDto.fromJson(response.data))
          : Left(ProjetoException(message: "Erro ao deletar grupo"));
    } on DioException catch (e) {
      return Left(
        ProjetoException(message: e.response?.data['message'] ?? e.message),
      );
    }
  }

  @override
  Future<Either<ProjetoException, String>> removeMember(
    int id,
    int memberId,
  ) async {
    try {
      final data = {"user_id": memberId};

      Response response = await _httpService.put(
        path: API.removeMember(id),
        isAuth: true,
        data: data,
      );
      return response.statusCode == 204
          ? const Right("Membro removido com sucesso")
          : Left(ProjetoException(message: "Erro ao remover membro"));
    } on DioException catch (e) {
      return Left(
        ProjetoException(message: e.response?.data['message'] ?? e.message),
      );
    }
  }
}
