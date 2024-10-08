import 'package:conta/domain/repositories/invite/invite_repository.dart';
import 'package:conta/domain/repositories/invite/invite_repository_impl.dart';
import 'package:conta/domain/services/invite_service.dart';
import 'package:get_it/get_it.dart';
import 'package:conta/config/services/http_service.dart';
import 'package:conta/config/services/http_service_impl.dart';

import 'package:conta/domain/repositories/auth/auth_local_repository.dart';
import 'package:conta/domain/repositories/auth/auth_local_repository_impl.dart';
import 'package:conta/domain/repositories/auth/auth_remote_repository.dart';
import 'package:conta/domain/repositories/auth/auth_remote_repository_impl.dart';
import 'package:conta/domain/services/auth_service.dart';

import 'package:conta/domain/repositories/user/user_repository_impl.dart';
import 'package:conta/domain/repositories/user/user_repository.dart';
import 'package:conta/domain/services/user_service.dart';

import 'package:conta/domain/repositories/group/group_repository_impl.dart';
import 'package:conta/domain/repositories/group/group_repository.dart';
import 'package:conta/domain/services/group_service.dart';

import 'package:conta/domain/repositories/expense/expense_repository.dart';
import 'package:conta/domain/repositories/expense/expense_repository_impl.dart';
import 'package:conta/domain/services/expense_service.dart';

var getIt = GetIt.I;

void setupInjection() {
  getIt.registerSingleton<HttpService>(HttpServiceImpl());

  getIt.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepositoryImpl(httpService: getIt()),
  );

  getIt.registerLazySingleton<AuthLocalRepository>(
    () => AuthLocalRepositoryImpl(),
  );

  getIt.registerLazySingleton<AuthService>(
    () => AuthService(
      getIt(),
      getIt(),
    ),
  );

  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(httpService: getIt()),
  );

  getIt.registerLazySingleton<UserService>(
    () => UserService(
      getIt(),
    ),
  );

  getIt.registerLazySingleton<GroupRepository>(
    () => GroupRepositoryImpl(httpService: getIt()),
  );

  getIt.registerLazySingleton<GroupService>(
    () => GroupService(getIt()),
  );

  getIt.registerLazySingleton<InviteRepository>(
    () => InviteRepositoryImpl(httpService: getIt()),
  );

  getIt.registerLazySingleton<InviteService>(
    () => InviteService(getIt()),
  );

  getIt.registerLazySingleton<ExpenseRepository>(
    () => ExpenseRepositoryImpl(httpService: getIt()),
  );

  getIt.registerLazySingleton<ExpenseService>(
    () => ExpenseService(getIt()),
  );

}
