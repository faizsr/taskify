import 'package:flutter/material.dart';
import 'package:taskify/src/config/styles/app_theme.dart';
import 'package:taskify/src/features/onboarding/presentation/views/onboarding_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskify',
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      home: const OnboardingPage(),
    );
  }
}
