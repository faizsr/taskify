import 'package:taskify/src/features/auth/data/models/user_model.dart';
import 'package:taskify/src/features/boards/data/models/board_model.dart';

abstract class BoardLocalDataSource {
  // Boards
  Future<void> cacheBoards(List<BoardModel> boards);
  List<BoardModel> getCachedBoards();

  // Users
  Future<void> cacheUsers(List<UserModel> users);
  List<UserModel> getCachedUsers();

  // Current User
  Future<void> cacheCurrentUser(UserModel user);
  UserModel? getCachedCurrentUser();

  Future<void> clearCache();
}
