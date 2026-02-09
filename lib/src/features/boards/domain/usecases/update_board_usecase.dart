import 'package:taskify/src/features/boards/domain/entities/board_entity.dart';
import 'package:taskify/src/features/boards/domain/repositories/board_repository.dart';

class UpdateBoardUsecase {
  final BoardRepository boardRepository;

  UpdateBoardUsecase({required this.boardRepository});

  Future<void> call(BoardEntity board) async {
    return await boardRepository.updateBoard(board);
  }
}
