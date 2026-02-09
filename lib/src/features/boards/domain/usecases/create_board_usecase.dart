import 'package:taskify/src/features/boards/domain/entities/board_entity.dart';
import 'package:taskify/src/features/boards/domain/repositories/board_repository.dart';

class CreateBoardUsecase {
  final BoardRepository boardRepository;

  CreateBoardUsecase({required this.boardRepository});

  Future<void> call(BoardEntity board) async {
    return await boardRepository.createBoard(board);
  }
}
