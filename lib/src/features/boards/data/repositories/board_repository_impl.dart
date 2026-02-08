import 'package:taskify/src/features/boards/data/data_sources/remote/board_remote_data_source.dart';
import 'package:taskify/src/features/boards/domain/entities/board_entity.dart';
import 'package:taskify/src/features/boards/domain/repositories/board_repository.dart';

class BoardRepositoryImpl implements BoardRepository {
  final BoardRemoteDataSource boardRemoteDataSource;

  BoardRepositoryImpl({required this.boardRemoteDataSource});

  @override
  Future<void> createBoard(BoardEntity board) async {
    await boardRemoteDataSource.createBoard(board.toModel());
  }
}
