import 'package:taskify/src/config/di/injections.dart';
import 'package:taskify/src/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:taskify/src/features/auth/data/data_sources/remote/auth_remote_data_source_impl.dart';
import 'package:taskify/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:taskify/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:taskify/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:taskify/src/features/auth/domain/usecases/logout_usecase.dart';
import 'package:taskify/src/features/auth/domain/usecases/register_usecase.dart';
import 'package:taskify/src/features/auth/presentation/controllers/auth_controller.dart';

void initAuthInjections() {
  // Auth Remote Data Source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: sl(), firebaseFirestore: sl()),
  );

  // Auth Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDataSource: sl()),
  );

  // Auth Usecases
  sl.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(authRepository: sl()),
  );
  sl.registerLazySingleton<RegisterUsecase>(
    () => RegisterUsecase(authRepository: sl()),
  );
  sl.registerLazySingleton<LogoutUsecase>(
    () => LogoutUsecase(authRepository: sl()),
  );

  // Auth Provider
  sl.registerFactory(
    () => AuthController(
      loginUsecase: sl(),
      logoutUsecase: sl(),
      registerUsecase: sl(),
      clearCacheUsecase: sl(),
    ),
  );
}
