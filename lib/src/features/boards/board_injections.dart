import 'package:hive_ce/hive.dart';
import 'package:taskify/src/config/di/injections.dart';
import 'package:taskify/src/features/auth/data/models/user_model.dart';
import 'package:taskify/src/features/boards/data/data_sources/local/board_local_data_source.dart';
import 'package:taskify/src/features/boards/data/data_sources/local/board_local_data_source_impl.dart';
import 'package:taskify/src/features/boards/data/data_sources/remote/board_remote_data_source.dart';
import 'package:taskify/src/features/boards/data/data_sources/remote/board_remote_data_source_impl.dart';
import 'package:taskify/src/features/boards/data/models/board_model.dart';
import 'package:taskify/src/features/boards/data/models/task_model.dart';
import 'package:taskify/src/features/boards/data/repositories/board_repository_impl.dart';
import 'package:taskify/src/features/boards/domain/repositories/board_repository.dart';
import 'package:taskify/src/features/boards/domain/usecases/clear_cache_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/create_board_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/create_task_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/delete_board_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/delete_task_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/get_all_boards_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/get_all_tasks_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/get_all_users_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/get_board_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/get_current_user_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/update_board_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/update_task_usecase.dart';
import 'package:taskify/src/features/boards/presentation/controllers/board_controller.dart';

Future<void> initHiveBoxes() async {
  Hive
    ..registerAdapter(TaskModelAdapter()) // FIRST
    ..registerAdapter(BoardModelAdapter())
    ..registerAdapter(UserModelAdapter());
  await Hive.openBox<BoardModel>('boards_box');
  await Hive.openBox<UserModel>('users_box');
  await Hive.openBox<UserModel>('current_user_box');
}

void initBoardInjections() {
  // Board Local Data Source
  sl.registerLazySingleton<BoardLocalDataSource>(
    () => BoardLocalDataSourceImpl(
      boardsBox: Hive.box<BoardModel>('boards_box'),
      usersBox: Hive.box<UserModel>('users_box'),
      currentUserBox: Hive.box<UserModel>('current_user_box'),
    ),
  );

  // Board Remote Data Source
  sl.registerLazySingleton<BoardRemoteDataSource>(
    () => BoardRemoteDataSourceImpl(firestore: sl(), firebaseAuth: sl()),
  );

  // Board Repository
  sl.registerLazySingleton<BoardRepository>(
    () => BoardRepositoryImpl(
      boardRemoteDataSource: sl(),
      boardLocalDataSource: sl(),
    ),
  );

  // Board Usecases
  sl.registerLazySingleton<CreateBoardUsecase>(
    () => CreateBoardUsecase(boardRepository: sl()),
  );
  sl.registerLazySingleton<UpdateBoardUsecase>(
    () => UpdateBoardUsecase(boardRepository: sl()),
  );
  sl.registerLazySingleton<DeleteBoardUsecase>(
    () => DeleteBoardUsecase(boardRepository: sl()),
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
  sl.registerLazySingleton<CreateTaskUsecase>(
    () => CreateTaskUsecase(boardRepository: sl()),
  );
  sl.registerLazySingleton<UpdateTaskUsecase>(
    () => UpdateTaskUsecase(boardRepository: sl()),
  );
  sl.registerLazySingleton<DeleteTaskUsecase>(
    () => DeleteTaskUsecase(boardRepository: sl()),
  );
  sl.registerLazySingleton<GetAllTasksUsecase>(
    () => GetAllTasksUsecase(boardRepository: sl()),
  );
  sl.registerLazySingleton<ClearCacheUsecase>(
    () => ClearCacheUsecase(boardRepository: sl()),
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
      createTaskUsecase: sl(),
      updateTaskUsecase: sl(),
      deleteTaskUsecase: sl(),
      getAllTasksUsecase: sl(),
      deleteBoardUsecase: sl(),
    ),
  );
}
