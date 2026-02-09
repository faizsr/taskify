import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomFadeTransition extends CustomTransitionPage {
  CustomFadeTransition({super.key, required super.child})
    : super(
        transitionsBuilder: (ctx, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: child,
          );
        },
      );
}
