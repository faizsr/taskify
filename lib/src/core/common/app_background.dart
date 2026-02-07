import 'package:flutter/material.dart';
import 'package:taskify/src/config/styles/app_colors.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    const LinearGradient backgroundGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [AppColors.darkBlue, AppColors.blue],
    );
    return Container(
      decoration: BoxDecoration(gradient: backgroundGradient),
      child: child,
    );
  }
}
