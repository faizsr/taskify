import 'package:taskify/src/core/utils/enums.dart';
import 'package:taskify/src/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponse> login(UserModel user);
  Future<AuthResponse> register(UserModel user);
  Future<void> logout();
}
