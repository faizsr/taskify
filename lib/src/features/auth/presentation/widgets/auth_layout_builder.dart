import 'package:flutter/material.dart';

class AuthLayoutBuilder extends StatelessWidget {
  final Widget child;

  const AuthLayoutBuilder({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
              minWidth: constraints.maxWidth,
            ),
            child: IntrinsicHeight(child: child),
          ),
        );
      },
    );
  }
}
