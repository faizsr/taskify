import 'package:taskify/src/features/boards/domain/entities/board_entity.dart';
import 'package:taskify/src/features/boards/domain/repositories/board_repository.dart';

class GetAllBoardsUsecase {
  final BoardRepository boardRepository;

  GetAllBoardsUsecase({required this.boardRepository});

  Stream<List<BoardEntity>> call() {
    return boardRepository.getAllBoards();
  }
}
