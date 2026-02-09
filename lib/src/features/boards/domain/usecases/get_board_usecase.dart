import 'package:taskify/src/features/boards/domain/entities/board_entity.dart';
import 'package:taskify/src/features/boards/domain/repositories/board_repository.dart';

class GetBoardUsecase {
  final BoardRepository boardRepository;

  GetBoardUsecase({required this.boardRepository});

  Stream<BoardEntity> call(String id) {
    return boardRepository.getBoard(id);
  }
}
