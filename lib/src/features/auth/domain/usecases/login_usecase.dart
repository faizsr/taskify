import 'package:taskify/src/core/utils/enums.dart';
import 'package:taskify/src/features/auth/domain/entities/user_entity.dart';
import 'package:taskify/src/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository authRepository;

  LoginUsecase({required this.authRepository});

  Future<AuthResponse> call(UserEntity user) async {
    return await authRepository.login(user);
  }
}
