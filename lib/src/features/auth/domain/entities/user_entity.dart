import 'package:taskify/src/features/auth/data/models/user_model.dart';

class UserEntity {
  final String uid;
  final String name;
  final String email;
  final String password;
  final DateTime? createdAt;

  UserEntity({
    this.uid = '',
    this.name = '',
    this.email = '',
    this.password = '',
    this.createdAt,
  });

  UserModel toModel() {
    return UserModel(
      uid: uid,
      name: name,
      email: email,
      password: password,
      createdAt: createdAt,
    );
  }
}
