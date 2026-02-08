import 'package:taskify/src/config/di/injections.dart';
import 'package:taskify/src/features/boards/data/data_sources/remote/board_remote_data_source.dart';
import 'package:taskify/src/features/boards/data/data_sources/remote/board_remote_data_source_impl.dart';
import 'package:taskify/src/features/boards/data/repositories/board_repository_impl.dart';
import 'package:taskify/src/features/boards/domain/repositories/board_repository.dart';
import 'package:taskify/src/features/boards/domain/usecases/create_board_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/get_all_boards_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/get_all_users_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/get_board_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/get_current_user_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/update_board_usecase.dart';
import 'package:taskify/src/features/boards/presentation/controllers/board_controller.dart';

void initBoardInjections() {
  // Board Remote Data Source
  sl.registerLazySingleton<BoardRemoteDataSource>(
    () => BoardRemoteDataSourceImpl(firestore: sl(), firebaseAuth: sl()),
  );

  // Board Repository
  sl.registerLazySingleton<BoardRepository>(
    () => BoardRepositoryImpl(boardRemoteDataSource: sl()),
  );

  // Board Usecases
  sl.registerLazySingleton<CreateBoardUsecase>(
    () => CreateBoardUsecase(boardRepository: sl()),
  );
  sl.registerLazySingleton<UpdateBoardUsecase>(
    () => UpdateBoardUsecase(boardRepository: sl()),
  );
  sl.registerLazySingleton<GetCurrentUserUsecase>(
    () => GetCurrentUserUsecase(boardRepository: sl()),
  );
  sl.registerLazySingleton<GetAllUsersUsecase>(
    () => GetAllUsersUsecase(boardRepository: sl()),
  );
  sl.registerLazySingleton<GetAllBoardsUsecase>(
    () => GetAllBoardsUsecase(boardRepository: sl()),
  );
  sl.registerLazySingleton<GetBoardUsecase>(
    () => GetBoardUsecase(boardRepository: sl()),
  );

  // Board Controller
  sl.registerFactory(
    () => BoardController(
      createBoardUsecase: sl(),
      updateBoardUsecase: sl(),
      getCurrentUserUsecase: sl(),
      getAllUsersUsecase: sl(),
      getAllBoardsUsecase: sl(),
      getBoardUsecase: sl(),
    ),
  );
}
