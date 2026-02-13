import 'package:taskify/src/features/auth/domain/entities/user_entity.dart';
import 'package:taskify/src/features/boards/data/data_sources/local/board_local_data_source.dart';
import 'package:taskify/src/features/boards/data/data_sources/remote/board_remote_data_source.dart';
import 'package:taskify/src/features/boards/domain/entities/board_entity.dart';
import 'package:taskify/src/features/boards/domain/entities/task_entity.dart';
import 'package:taskify/src/features/boards/domain/repositories/board_repository.dart';

class BoardRepositoryImpl implements BoardRepository {
  final BoardRemoteDataSource boardRemoteDataSource;
  final BoardLocalDataSource boardLocalDataSource;

  BoardRepositoryImpl({
    required this.boardRemoteDataSource,
    required this.boardLocalDataSource,
  });

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
  Stream<List<UserEntity>> getAllUsers() async* {
    // Cached first
    final cachedUsers = boardLocalDataSource.getCachedUsers();
    if (cachedUsers.isNotEmpty) {
      yield cachedUsers.map((e) => e.toEntity()).toList();
    }

    // Remote stream
    await for (final users in boardRemoteDataSource.getAllUsers()) {
      await boardLocalDataSource.cacheUsers(users);
      yield users.map((e) => e.toEntity()).toList();
    }
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    // 1️⃣ Local first
    final cachedUser = boardLocalDataSource.getCachedCurrentUser();
    if (cachedUser != null) {
      return cachedUser.toEntity();
    }

    // 2️⃣ Remote fallback
    final user = await boardRemoteDataSource.getCurrentUser();
    if (user != null) {
      await boardLocalDataSource.cacheCurrentUser(user);
      return user.toEntity();
    }
    return null;
  }

  @override
  Stream<List<BoardEntity>> getAllBoards() async* {
    // 1️⃣ Emit cached boards first
    final cachedBoards = boardLocalDataSource.getCachedBoards();
    if (cachedBoards.isNotEmpty) {
      yield cachedBoards.map((e) => e.toEntity()).toList();
    }

    // 2️⃣ Listen to remote and cache updates
    await for (final boards in boardRemoteDataSource.getAllBoards()) {
      await boardLocalDataSource.cacheBoards(boards);
      yield boards.map((e) => e.toEntity()).toList();
    }
  }

  @override
  Stream<BoardEntity> getBoard(String id) {
    return boardRemoteDataSource.getBoard(id).map((e) => e.toEntity());
  }

  @override
  Future<void> createTask(TaskEntity task) async {
    return await boardRemoteDataSource.createTask(task.toModel());
  }

  @override
  Future<void> deleteTask(String id) async {
    return await boardRemoteDataSource.deleteTask(id);
  }

  @override
  Stream<List<TaskEntity>> getAllTasks(String boardId) {
    final tasks = boardRemoteDataSource.getAllTasks(boardId);
    return tasks.map((e) => e.map((e) => e.toEntity()).toList());
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    return await boardRemoteDataSource.updateTask(task.toModel());
  }

  @override
  Future<void> clearCache() => boardLocalDataSource.clearCache();
}
