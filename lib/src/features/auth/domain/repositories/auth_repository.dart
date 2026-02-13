import 'package:taskify/src/core/utils/enums.dart';
import 'package:taskify/src/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<AuthResponse> login(UserEntity user);
  Future<AuthResponse> register(UserEntity user);
  Future<void> logout();
}
