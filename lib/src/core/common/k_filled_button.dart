import 'package:flutter/cupertino.dart';
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
    this.isLoading = false,
    this.width,
    this.padding,
  });

  final String text;
  final void Function()? onPressed;
  final Color bgColor;
  final Color? fgColor;
  final bool isLoading;
  final double? width;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width == 0 ? null : ResponsiveHelper.getWidth(context),
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          padding: padding ?? EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? CupertinoActivityIndicator(color: AppColors.white)
            : Text(text),
      ),
    );
  }
}
