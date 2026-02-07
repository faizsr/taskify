import 'package:taskify/src/core/utils/enums.dart';
import 'package:taskify/src/features/auth/domain/entities/user_entity.dart';
import 'package:taskify/src/features/auth/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository authRepository;

  RegisterUsecase({required this.authRepository});

  Future<AuthResponse> call(UserEntity user) async {
    return await authRepository.register(user);
  }
}
