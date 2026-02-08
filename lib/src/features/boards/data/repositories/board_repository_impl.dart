import 'package:taskify/src/features/auth/domain/entities/user_entity.dart';
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

  @override
  Future<void> updateBoard(BoardEntity board) async {
    await boardRemoteDataSource.updateBoard(board.toModel());
  }

  @override
  Future<void> deleteBoard(String id) async {
    await boardRemoteDataSource.deleteBoard(id);
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = await boardRemoteDataSource.getCurrentUser();
    return user?.toEntity();
  }

  @override
  Stream<List<UserEntity>> getAllUsers() {
    final users = boardRemoteDataSource.getAllUsers();
    return users.map((e) => e.map((e) => e.toEntity()).toList());
  }

  @override
  Stream<List<BoardEntity>> getAllBoards() {
    final boards = boardRemoteDataSource.getAllBoards();
    return boards.map((e) => e.map((e) => e.toEntity()).toList());
  }

  @override
  Stream<BoardEntity> getBoard(String id) {
    return boardRemoteDataSource.getBoard(id).map((e) => e.toEntity());
  }
}
