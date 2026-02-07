import 'package:go_router/go_router.dart';
import 'package:taskify/src/config/router/app_page_transition.dart';
import 'package:taskify/src/config/router/app_routes.dart';
import 'package:taskify/src/features/auth/presentation/views/login_page.dart';
import 'package:taskify/src/features/auth/presentation/views/register_page.dart';
import 'package:taskify/src/features/onboarding/presentation/views/onboarding_page.dart';
import 'package:taskify/src/features/splash/presentation/views/splash_page.dart';

class AppRouterConfig {
  static GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => SplashPage(),
      ),

      GoRoute(
        path: AppRoutes.onboarding,
        pageBuilder: (context, state) {
          return CustomFadeTransition(child: OnboardingPage());
        },
      ),

      GoRoute(
        path: AppRoutes.login,
        pageBuilder: (context, state) {
          return CustomFadeTransition(child: LoginPage());
        },
      ),

      GoRoute(
        path: AppRoutes.register,
        pageBuilder: (context, state) {
          return CustomFadeTransition(child: RegisterPage());
        },
      ),
    ],
  );
}
