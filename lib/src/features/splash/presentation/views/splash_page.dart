import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:taskify/src/config/di/injections.dart';
import 'package:taskify/src/config/router/app_routes.dart';
import 'package:taskify/src/config/styles/app_colors.dart';
import 'package:taskify/src/core/common/app_background.dart';
import 'package:taskify/src/features/auth/presentation/controllers/auth_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late AuthController authCtlr;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      authCtlr = context.read<AuthController>();
      authCtlr.checkNetworkConnection();
      await Future.delayed(Duration(milliseconds: 2500));
      if (mounted) {
        if (sl<FirebaseAuth>().currentUser != null) {
          context.go(AppRoutes.boards);
        } else {
          context.go(AppRoutes.onboarding);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: AppBar(
          backgroundColor: AppColors.transparent,
          toolbarHeight: 0,
        ),
        body: Center(
          child: Hero(
            tag: 'logo',
            child: Text(
              'Taskify',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
