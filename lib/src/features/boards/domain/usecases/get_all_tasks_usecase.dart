import 'package:taskify/src/features/boards/domain/entities/task_entity.dart';
import 'package:taskify/src/features/boards/domain/repositories/board_repository.dart';

class GetAllTasksUsecase {
  final BoardRepository boardRepository;

  GetAllTasksUsecase({required this.boardRepository});

  Stream<List<TaskEntity>> call(String boardId) {
    return boardRepository.getAllTasks(boardId);
  }
}
