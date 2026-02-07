import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskify/src/core/utils/enums.dart';
import 'package:taskify/src/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:taskify/src/features/auth/data/models/user_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  @override
  Future<AuthResponse> login(UserModel user) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      return AuthResponse.success;
    } on FirebaseAuthException catch (e) {
      log('Login error code: ${e.code}');
      if (e.code == 'invalid-email') {
        return AuthResponse.invalidEmail;
      }
      if (e.code == 'user-not-found') {
        return AuthResponse.notFound;
      }
      if (e.code == 'wrong-password') {
        return AuthResponse.wrongPassword;
      }
      if (e.code == 'too-many-requests') {
        return AuthResponse.tooManyRequests;
      }
      if (e.code == 'user-token-expired') {
        return AuthResponse.tokenExpired;
      }
      if (e.code == 'invalid-credential') {
        return AuthResponse.invalidCredentials;
      }
    }
    return AuthResponse.error;
  }

  @override
  Future<AuthResponse> register(UserModel user) async {
    try {
      final response = await firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      final newUser = user.copyWith(
        uid: response.user?.uid,
        createdAt: response.user?.metadata.creationTime,
      );
      await firebaseFirestore.collection('users').add(newUser.toJson());

      return AuthResponse.success;
    } on FirebaseAuthException catch (e) {
      log('Register error code: ${e.code}');
      if (e.code == 'invalid-email') {
        return AuthResponse.invalidEmail;
      }
      if (e.code == 'too-many-requests') {
        return AuthResponse.tooManyRequests;
      }
      if (e.code == 'user-token-expired') {
        return AuthResponse.tokenExpired;
      }
      if (e.code == 'email-already-in-use') {
        return AuthResponse.emailAlreadyInUse;
      }
    }
    return AuthResponse.error;
  }
}
