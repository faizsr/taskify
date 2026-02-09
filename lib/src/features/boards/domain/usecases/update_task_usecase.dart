import 'package:taskify/src/features/boards/domain/entities/task_entity.dart';
import 'package:taskify/src/features/boards/domain/repositories/board_repository.dart';

class UpdateTaskUsecase {
  final BoardRepository boardRepository;

  UpdateTaskUsecase({required this.boardRepository});

  Future<void> call(TaskEntity task) async {
    return await boardRepository.updateTask(task);
  }
}
