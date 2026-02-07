import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify/src/config/constants/app_constants.dart';
import 'package:taskify/src/config/router/app_routes.dart';
import 'package:taskify/src/config/styles/app_colors.dart';
import 'package:taskify/src/core/common/app_background.dart';
import 'package:taskify/src/core/common/k_filled_button.dart';
import 'package:taskify/src/core/common/k_rich_text.dart';
import 'package:taskify/src/core/common/k_text_field.dart';
import 'package:taskify/src/core/utils/responsive_helper.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                  children: [
                    vSpace40,
                    Text(
                      "Let's Get Started",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    vSpace4,
                    Text(
                      'Sign in to your account',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
                    ),
                    vSpace40,

                    KTextField(hintText: 'Email Address'),
                    vSpace16,
                    KTextField(hintText: 'Password', isPassword: true),
                    vSpace8,
                    buildForgotPasswordBtn(context),
                    vSpace20,
                    KFilledButton(text: 'Sign In', onPressed: () {}),

                    Spacer(),
                    KRichText(
                      text1: "Don't have an account? ",
                      text2: "Sign Up",
                      padding: EdgeInsets.only(bottom: 8),
                      onTap: () => context.push(AppRoutes.register),
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

  GestureDetector buildForgotPasswordBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          'Forgot Password?',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.blue),
        ),
      ),
    );
  }
}
