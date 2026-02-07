import 'package:flutter/widgets.dart';
import 'package:taskify/src/core/common/custom_snackbar.dart';
import 'package:taskify/src/core/utils/enums.dart';
import 'package:taskify/src/features/auth/domain/entities/user_entity.dart';
import 'package:taskify/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:taskify/src/features/auth/domain/usecases/register_usecase.dart';

class AuthController extends ChangeNotifier {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;

  AuthController({required this.loginUsecase, required this.registerUsecase});

  bool isBtnLoading = false;

  String _getErrorMessage(AuthResponse response) {
    switch (response) {
      case AuthResponse.success:
        return 'Success';
      case AuthResponse.invalidEmail:
        return 'Invalid email address. Please check and try again.';
      case AuthResponse.notFound:
        return 'User not found. Please sign up first.';
      case AuthResponse.wrongPassword:
        return 'Wrong password. Please try again.';
      case AuthResponse.tooManyRequests:
        return 'Too many failed attempts. Please try again later.';
      case AuthResponse.tokenExpired:
        return 'Session expired. Please log in again.';
      case AuthResponse.invalidCredentials:
        return 'Invalid email or password.';
      case AuthResponse.emailAlreadyInUse:
        return 'Email already in use. Please use a different email.';
      case AuthResponse.error:
        return 'An error occurred. Please try again.';
    }
  }

  Future<bool> login(UserEntity user) async {
    isBtnLoading = true;
    notifyListeners();

    final response = await loginUsecase.call(user);

    if (response == AuthResponse.success) {
      showCustomSnackbar(type: SnackType.success, content: 'Login successful');
      return true;
    } else {
      showCustomSnackbar(
        type: SnackType.error,
        content: _getErrorMessage(response),
      );
    }

    isBtnLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> register(UserEntity user) async {
    isBtnLoading = true;
    notifyListeners();

    final response = await registerUsecase.call(user);

    if (response == AuthResponse.success) {
      showCustomSnackbar(
        type: SnackType.success,
        content: 'Registration completed successfully',
      );
      return true;
    } else {
      showCustomSnackbar(
        type: SnackType.error,
        content: _getErrorMessage(response),
      );
    }

    isBtnLoading = false;
    notifyListeners();
    return false;
  }
}
