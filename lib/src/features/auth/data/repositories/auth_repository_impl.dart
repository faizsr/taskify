import 'package:taskify/src/core/utils/enums.dart';
import 'package:taskify/src/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:taskify/src/features/auth/domain/entities/user_entity.dart';
import 'package:taskify/src/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<AuthResponse> login(UserEntity user) async {
    return await authRemoteDataSource.login(user.toModel());
  }

  @override
  Future<AuthResponse> register(UserEntity user) async {
    return await authRemoteDataSource.register(user.toModel());
  }
}
