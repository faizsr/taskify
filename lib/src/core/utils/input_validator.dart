class InputValidator {
  static String? required(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required field';
    }
    return null;
  }

  static String? name(String? value) {
    if (value!.isEmpty) {
      return 'Required Field';
    }
    if (value.length < 3) {
      return 'Enter a valid name';
    }
    return null;
  }

  static String? email(String? email) {
    if (email == null || email.isEmpty) {
      return 'Required field';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  static String? password(String? password) {
    if (password == null || password.isEmpty) {
      return 'Required field';
    }

    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    return null;
  }
}
