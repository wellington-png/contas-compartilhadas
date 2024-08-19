import 'package:get_it/get_it.dart';
import 'package:projeto_final_mobile/config/services/http_service.dart';
import 'package:projeto_final_mobile/config/services/http_service_impl.dart';

import 'package:projeto_final_mobile/domain/repositories/auth/auth_local_repository.dart';
import 'package:projeto_final_mobile/domain/repositories/auth/auth_local_repository_impl.dart';
import 'package:projeto_final_mobile/domain/repositories/auth/auth_remote_repository.dart';
import 'package:projeto_final_mobile/domain/repositories/auth/auth_remote_repository_impl.dart';
import 'package:projeto_final_mobile/domain/services/auth_service.dart';

var getIt = GetIt.I;

void setupInjection() {
  getIt.registerSingleton<HttpService>(HttpServiceImpl());

  getIt.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepositoryImpl(httpService: getIt()),
  );

  getIt.registerLazySingleton<AuthLocalRepository>(
      () => AuthLocalRepositoryImpl());

  getIt.registerLazySingleton<AuthService>(() => AuthService(getIt(), getIt()));
}
