import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify/src/config/constants/app_assets.dart';
import 'package:taskify/src/config/constants/app_constants.dart';
import 'package:taskify/src/config/router/app_routes.dart';
import 'package:taskify/src/config/styles/app_colors.dart';
import 'package:taskify/src/core/common/app_background.dart';
import 'package:taskify/src/core/common/k_filled_button.dart';
import 'package:taskify/src/core/utils/responsive_helper.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    double w = ResponsiveHelper.getWidth(context);

    return AppBackground(
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: AppBar(
          backgroundColor: AppColors.transparent,
          toolbarHeight: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'logo',
                    child: Text(
                      'Taskify',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Text(
                    'Task made simple.',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.white.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 12,
              width: w * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(200),
                  topRight: Radius.circular(200),
                ),
                color: AppColors.lightBlue.withValues(alpha: 0.8),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Transform.scale(
                      scale: 1.2,
                      child: Image.asset(AppAssets.taskManagement),
                    ),
                    Spacer(),
                    Text(
                      'Smart collaboration for everyday work',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    vSpace32,
                    KFilledButton(
                      text: 'Get Started',
                      fgColor: AppColors.blue,
                      bgColor: AppColors.lightBlue.withValues(alpha: 0.2),
                      onPressed: () => context.push(AppRoutes.login),
                    ),
                    vSpace40,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
