import 'package:taskify/src/features/boards/domain/entities/board_entity.dart';

abstract class BoardRepository {
  Future<void> createBoard(BoardEntity board);
}
