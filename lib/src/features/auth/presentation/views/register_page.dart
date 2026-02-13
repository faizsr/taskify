import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:solar_icons/solar_icons.dart';
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
import 'package:taskify/src/features/auth/presentation/widgets/auth_layout_builder.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailCtlr = TextEditingController();
  final nameCtlr = TextEditingController();
  final passwordCtlr = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> _onSignUpPressed() async {
    if (formKey.currentState!.validate()) {
      final authCtlr = context.read<AuthController>();
      final user = UserEntity(
        name: nameCtlr.text,
        email: emailCtlr.text,
        password: passwordCtlr.text,
      );
      final result = await authCtlr.register(user);
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
        body: AuthLayoutBuilder(
          child: Column(
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
                  child: Form(
                    key: formKey,
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
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppColors.grey),
                        ),
                        vSpace40,

                        KTextField(
                          hintText: 'Email Address',
                          controller: emailCtlr,
                          validator: InputValidator.email,
                          autovalidateMode: AutovalidateMode.onUnfocus,
                        ),
                        vSpace16,
                        KTextField(
                          hintText: 'Your name',
                          controller: nameCtlr,
                          validator: InputValidator.name,
                          autovalidateMode: AutovalidateMode.onUnfocus,
                        ),
                        vSpace16,
                        KTextField(
                          hintText: 'Password',
                          isPassword: true,
                          controller: passwordCtlr,
                          validator: InputValidator.password,
                          autovalidateMode: AutovalidateMode.onUnfocus,
                        ),
                        vSpace20,
                        Selector<AuthController, bool>(
                          selector: (context, ctlr) => ctlr.isBtnLoading,
                          builder: (context, value, child) {
                            return KFilledButton(
                              text: 'Sign Up',
                              isLoading: value,
                              onPressed: _onSignUpPressed,
                            );
                          },
                        ),
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
              ),
            ],
          ),
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
