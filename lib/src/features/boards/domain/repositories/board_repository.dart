import 'package:taskify/src/features/auth/domain/entities/user_entity.dart';
import 'package:taskify/src/features/boards/domain/entities/board_entity.dart';
import 'package:taskify/src/features/boards/domain/entities/task_entity.dart';

abstract class BoardRepository {
  Future<void> createBoard(BoardEntity board);
  Future<void> updateBoard(BoardEntity board);
  Future<void> deleteBoard(String id);

  Stream<List<BoardEntity>> getAllBoards();
  Stream<BoardEntity> getBoard(String id);

  Future<void> createTask(TaskEntity task);
  Future<void> updateTask(TaskEntity task);
  Future<void> deleteTask(String id);

  Stream<List<TaskEntity>> getAllTasks(String boardId);

  Future<UserEntity?> getCurrentUser();
  Stream<List<UserEntity>> getAllUsers();

  Future<void> clearCache();
}
