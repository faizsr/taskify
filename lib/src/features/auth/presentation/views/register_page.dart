import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:taskify/src/config/constants/app_constants.dart';
import 'package:taskify/src/config/styles/app_colors.dart';
import 'package:taskify/src/core/common/app_background.dart';
import 'package:taskify/src/core/common/k_filled_button.dart';
import 'package:taskify/src/core/common/k_rich_text.dart';
import 'package:taskify/src/core/common/k_text_field.dart';
import 'package:taskify/src/core/utils/responsive_helper.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
            _buildHeader(context),
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
                    vSpace40,
                    Text(
                      "Create your account",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    vSpace4,
                    Text(
                      'Sign up to get started',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
                    ),
                    vSpace40,

                    KTextField(hintText: 'Email Address'),
                    vSpace16,
                    KTextField(hintText: 'Your name'),
                    vSpace16,
                    KTextField(hintText: 'Password', isPassword: true),
                    vSpace20,
                    KFilledButton(text: 'Sign Up', onPressed: () {}),
                    vSpace12,

                    Spacer(),
                    KRichText(
                      text1: "Already have an account? ",
                      text2: "Sign In",
                      padding: EdgeInsets.only(bottom: 8),
                      onTap: () => context.pop(),
                    ),
                    vSpace16,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildHeader(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Positioned(
            left: 8,
            child: IconButton(
              onPressed: () => context.pop(),
              icon: Icon(SolarIconsOutline.arrowLeft, color: AppColors.white),
            ),
          ),
          Center(
            child: Text(
              'Taskify',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
