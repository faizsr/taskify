import 'package:flutter/material.dart';
import 'package:taskify/src/config/constants/app_constants.dart';
import 'package:taskify/src/config/styles/app_colors.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    fontFamily: googleSans,
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.white),
  );
}
