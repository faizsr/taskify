import 'package:flutter/material.dart';
import 'package:taskify/src/config/constants/app_assets.dart';
import 'package:taskify/src/config/constants/app_constants.dart';
import 'package:taskify/src/config/styles/app_colors.dart';
import 'package:taskify/src/core/common/app_background.dart';
import 'package:taskify/src/core/utils/responsive_helper.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: Center(
                child: Text(
                  'Taskify',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              height: 12,
              width: 370,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(200),
                  topRight: Radius.circular(200),
                ),
                color: AppColors.lightBlue.withValues(alpha: 0.8),
              ),
            ),
            Expanded(
              flex: 4,
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
                      scale: 1.3,
                      child: Image.asset(AppAssets.taskManagement),
                    ),
                    Spacer(),
                    Text(
                      'Smart collaboration for everyday work',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    vSpace32,
                    SizedBox(
                      width: ResponsiveHelper.getWidth(context),
                      child: FilledButton(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          padding: EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: AppColors.lightBlue.withValues(
                            alpha: 0.2,
                          ),
                          foregroundColor: AppColors.blue,
                        ),
                        child: Text('Get Started'),
                      ),
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
