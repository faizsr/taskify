import 'package:taskify/src/features/boards/domain/entities/task_entity.dart';
import 'package:taskify/src/features/boards/domain/repositories/board_repository.dart';

class CreateTaskUsecase {
  final BoardRepository boardRepository;

  CreateTaskUsecase({required this.boardRepository});

  Future<void> call(TaskEntity task) async {
    return await boardRepository.createTask(task);
  }
}
