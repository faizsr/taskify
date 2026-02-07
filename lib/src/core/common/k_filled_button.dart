import 'package:flutter/material.dart';
import 'package:taskify/src/config/styles/app_colors.dart';
import 'package:taskify/src/core/utils/responsive_helper.dart';

class KFilledButton extends StatelessWidget {
  const KFilledButton({
    super.key,
    required this.text,
    this.onPressed,
    this.bgColor = AppColors.blue,
    this.fgColor,
  });

  final String text;
  final void Function()? onPressed;
  final Color bgColor;
  final Color? fgColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ResponsiveHelper.getWidth(context),
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          padding: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
