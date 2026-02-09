import 'package:taskify/src/features/auth/domain/entities/user_entity.dart';
import 'package:taskify/src/features/boards/domain/repositories/board_repository.dart';

class GetAllUsersUsecase {
  final BoardRepository boardRepository;

  GetAllUsersUsecase({required this.boardRepository});

  Stream<List<UserEntity>> call() {
    return boardRepository.getAllUsers();
  }
}
