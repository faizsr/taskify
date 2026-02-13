import 'package:hive_ce/hive.dart';
import 'package:taskify/src/features/auth/data/models/user_model.dart';
import 'package:taskify/src/features/boards/data/models/board_model.dart';
import 'board_local_data_source.dart';

class BoardLocalDataSourceImpl implements BoardLocalDataSource {
  final Box<BoardModel> boardsBox;
  final Box<UserModel> usersBox;
  final Box<UserModel> currentUserBox;

  BoardLocalDataSourceImpl({
    required this.boardsBox,
    required this.usersBox,
    required this.currentUserBox,
  });

  @override
  Future<void> cacheBoards(List<BoardModel> boards) async {
    await boardsBox.clear();
    for (final board in boards) {
      await boardsBox.put(board.id, board);
    }
  }

  @override
  List<BoardModel> getCachedBoards() {
    return boardsBox.values.toList();
  }

  @override
  Future<void> cacheUsers(List<UserModel> users) async {
    await usersBox.clear();
    for (final user in users) {
      await usersBox.put(user.uid, user);
    }
  }

  @override
  List<UserModel> getCachedUsers() {
    return usersBox.values.toList();
  }

  @override
  Future<void> cacheCurrentUser(UserModel user) async {
    await currentUserBox.put('current', user);
  }

  @override
  UserModel? getCachedCurrentUser() {
    return currentUserBox.get('current');
  }

  @override
  Future<void> clearCache() async {
    await boardsBox.clear();
    await usersBox.clear();
    await currentUserBox.clear();
  }
}
