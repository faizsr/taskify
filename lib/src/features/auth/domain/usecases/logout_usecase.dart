import 'package:taskify/src/features/auth/domain/repositories/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository authRepository;

  LogoutUsecase({required this.authRepository});

  Future<void> call() async => await authRepository.logout();
}
