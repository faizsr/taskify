import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:taskify/src/config/constants/app_constants.dart';
import 'package:taskify/src/config/router/app_routes.dart';
import 'package:taskify/src/config/styles/app_colors.dart';
import 'package:taskify/src/core/common/app_background.dart';
import 'package:taskify/src/core/common/k_filled_button.dart';
import 'package:taskify/src/core/common/k_rich_text.dart';
import 'package:taskify/src/core/common/k_text_field.dart';
import 'package:taskify/src/core/utils/input_validator.dart';
import 'package:taskify/src/core/utils/responsive_helper.dart';
import 'package:taskify/src/features/auth/domain/entities/user_entity.dart';
import 'package:taskify/src/features/auth/presentation/controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailCtlr = TextEditingController();
  final passwordCtlr = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> _onSignInPressed() async {
    if (formKey.currentState!.validate()) {
      final authCtlr = context.read<AuthController>();
      final user = UserEntity(
        email: emailCtlr.text,
        password: passwordCtlr.text,
      );
      final result = await authCtlr.login(user);
      if (result && mounted) context.go(AppRoutes.boards);
    }
  }

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
                child: Form(
                  key: formKey,
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

                      KTextField(
                        controller: emailCtlr,
                        hintText: 'Email Address',
                        validator: InputValidator.email,
                        autovalidateMode: AutovalidateMode.onUnfocus,
                      ),
                      vSpace16,
                      KTextField(
                        isPassword: true,
                        hintText: 'Password',
                        controller: passwordCtlr,
                        validator: InputValidator.required,
                        autovalidateMode: AutovalidateMode.onUnfocus,
                      ),
                      vSpace8,
                      buildForgotPasswordBtn(context),
                      vSpace20,
                      Selector<AuthController, bool>(
                        selector: (context, ctlr) => ctlr.isBtnLoading,
                        builder: (context, value, child) {
                          return KFilledButton(
                            text: 'Sign In',
                            isLoading: value,
                            onPressed: _onSignInPressed,
                          );
                        },
                      ),

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
