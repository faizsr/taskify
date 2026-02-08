import 'package:taskify/src/features/auth/domain/entities/user_entity.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String password;
  final DateTime? createdAt;

  UserModel({
    this.uid = '',
    this.name = '',
    this.email = '',
    this.password = '',
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      uid: uid,
      name: name,
      email: email,
      password: password,
      createdAt: createdAt,
    );
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? password,
    DateTime? createdAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
