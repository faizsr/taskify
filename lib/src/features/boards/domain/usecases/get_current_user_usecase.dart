import 'package:taskify/src/features/auth/domain/entities/user_entity.dart';
import 'package:taskify/src/features/boards/domain/repositories/board_repository.dart';

class GetCurrentUserUsecase {
  final BoardRepository boardRepository;

  GetCurrentUserUsecase({required this.boardRepository});

  Future<UserEntity?> call() async {
    return await boardRepository.getCurrentUser();
  }
}
