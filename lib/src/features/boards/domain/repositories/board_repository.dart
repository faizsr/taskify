import 'package:taskify/src/features/auth/domain/entities/user_entity.dart';
import 'package:taskify/src/features/boards/domain/entities/board_entity.dart';

abstract class BoardRepository {
  Future<void> createBoard(BoardEntity board);
  Future<void> updateBoard(BoardEntity board);
  Future<void> deleteBoard(String id);

  Future<UserEntity?> getCurrentUser();
  Stream<List<UserEntity>> getAllUsers();
  Stream<List<BoardEntity>> getAllBoards();
  Stream<BoardEntity> getBoard(String id);
}
