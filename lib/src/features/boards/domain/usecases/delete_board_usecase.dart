import 'package:taskify/src/features/boards/domain/repositories/board_repository.dart';

class DeleteBoardUsecase {
  final BoardRepository boardRepository;

  DeleteBoardUsecase({required this.boardRepository});

  Future<void> call(String id) async {
    return await boardRepository.deleteBoard(id);
  }
}
