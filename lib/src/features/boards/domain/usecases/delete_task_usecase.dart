import 'package:taskify/src/features/boards/domain/repositories/board_repository.dart';

class DeleteTaskUsecase {
  final BoardRepository boardRepository;

  DeleteTaskUsecase({required this.boardRepository});

  Future<void> call(String id) async {
    return await boardRepository.deleteTask(id);
  }
}
