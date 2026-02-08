import 'package:go_router/go_router.dart';
import 'package:taskify/src/config/router/app_page_transition.dart';
import 'package:taskify/src/config/router/app_routes.dart';
import 'package:taskify/src/core/utils/navigation_helper.dart';
import 'package:taskify/src/features/auth/presentation/views/login_page.dart';
import 'package:taskify/src/features/auth/presentation/views/register_page.dart';
import 'package:taskify/src/features/boards/presentation/views/board_detail_page.dart';
import 'package:taskify/src/features/boards/presentation/views/board_list_page.dart';
import 'package:taskify/src/features/boards/presentation/views/create_edit_board_page.dart';
import 'package:taskify/src/features/boards/presentation/views/create_edit_task_page.dart';
import 'package:taskify/src/features/onboarding/presentation/views/onboarding_page.dart';
import 'package:taskify/src/features/splash/presentation/views/splash_page.dart';

class AppRouterConfig {
  static GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    navigatorKey: NavigationHelper.navigatorKey,
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

      GoRoute(
        path: AppRoutes.boards,
        pageBuilder: (context, state) {
          return CustomFadeTransition(child: BoardListPage());
        },
      ),

      GoRoute(
        path: AppRoutes.createBoard,
        pageBuilder: (context, state) {
          return CustomFadeTransition(child: CreateBoardPage());
        },
      ),

      GoRoute(
        path: AppRoutes.editBoard,
        pageBuilder: (context, state) {
          final extra = state.extra as Map;
          return CustomFadeTransition(
            child: CreateBoardPage(board: extra['board']),
          );
        },
      ),

      GoRoute(
        path: AppRoutes.boardDetail,
        pageBuilder: (context, state) {
          final extra = state.extra as Map;
          return CustomFadeTransition(child: BoardDetailPage(id: extra['id']));
        },
      ),

      GoRoute(
        path: AppRoutes.createTask,
        pageBuilder: (context, state) {
          final extra = state.extra as Map;
          return CustomFadeTransition(
            child: CreateEditTaskPage(boardId: extra['boardId']),
          );
        },
      ),
    ],
  );
}
