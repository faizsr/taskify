import 'package:taskify/src/config/di/injections.dart';
import 'package:taskify/src/features/boards/data/data_sources/remote/board_remote_data_source.dart';
import 'package:taskify/src/features/boards/data/data_sources/remote/board_remote_data_source_impl.dart';
import 'package:taskify/src/features/boards/data/repositories/board_repository_impl.dart';
import 'package:taskify/src/features/boards/domain/repositories/board_repository.dart';
import 'package:taskify/src/features/boards/domain/usecases/create_board_usecase.dart';
import 'package:taskify/src/features/boards/presentation/controllers/board_controller.dart';

void initBoardInjections() {
  // Board Remote Data Source
  sl.registerLazySingleton<BoardRemoteDataSource>(
    () => BoardRemoteDataSourceImpl(firebaseFirestore: sl()),
  );

  // Board Repository
  sl.registerLazySingleton<BoardRepository>(
    () => BoardRepositoryImpl(boardRemoteDataSource: sl()),
  );

  // Board Usecases
  sl.registerLazySingleton<CreateBoardUsecase>(
    () => CreateBoardUsecase(boardRepository: sl()),
  );

  // Board Controller
  sl.registerFactory(
    () => BoardController(createBoardUsecase: sl()),
  );
}
