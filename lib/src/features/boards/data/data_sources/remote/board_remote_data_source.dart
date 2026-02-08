import 'package:taskify/src/features/auth/data/models/user_model.dart';
import 'package:taskify/src/features/boards/data/models/board_model.dart';

abstract class BoardRemoteDataSource {
  Future<void> createBoard(BoardModel board);
  Future<void> updateBoard(BoardModel board);
  Future<void> deleteBoard(String id);

  Future<UserModel?> getCurrentUser();
  Stream<List<UserModel>> getAllUsers();
  Stream<List<BoardModel>> getAllBoards();

  Stream<BoardModel> getBoard(String id);
}
