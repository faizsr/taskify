import 'package:taskify/src/features/boards/domain/repositories/board_repository.dart';

class ClearCacheUsecase {
  final BoardRepository boardRepository;

  ClearCacheUsecase({required this.boardRepository});

  Future<void> call() => boardRepository.clearCache();
}
