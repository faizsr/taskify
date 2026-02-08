import 'package:taskify/src/features/auth/data/models/user_model.dart';
import 'package:taskify/src/features/boards/data/models/board_model.dart';
import 'package:taskify/src/features/boards/data/models/task_model.dart';

abstract class BoardRemoteDataSource {
  Future<void> createBoard(BoardModel board);
  Future<void> updateBoard(BoardModel board);
  Future<void> deleteBoard(String id);

  Stream<List<BoardModel>> getAllBoards();
  Stream<BoardModel> getBoard(String id);

  Future<void> createTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(String id);

  Stream<List<TaskModel>> getAllTasks(String boardId);

  Future<UserModel?> getCurrentUser();
  Stream<List<UserModel>> getAllUsers();
}
