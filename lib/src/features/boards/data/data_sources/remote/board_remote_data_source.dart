import 'package:taskify/src/features/boards/data/models/board_model.dart';

abstract class BoardRemoteDataSource {
  Future<void> createBoard(BoardModel board);
}