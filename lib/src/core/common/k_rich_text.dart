import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskify/src/config/constants/app_constants.dart';
import 'package:taskify/src/config/styles/app_colors.dart';

class KRichText extends StatelessWidget {
  const KRichText({
    super.key,
    this.onTap,
    this.text1 = '',
    this.text2 = '',
    this.align = TextAlign.center,
    this.padding = EdgeInsets.zero,
    this.text1Color,
    this.text2Color,
    this.text1Style,
    this.text2Style,
    this.maxLines,
  });

  final String text1;
  final String text2;
  final void Function()? onTap;
  final TextAlign align;
  final EdgeInsetsGeometry padding;
  final Color? text1Color;
  final Color? text2Color;
  final TextStyle? text1Style;
  final TextStyle? text2Style;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: RichText(
        textAlign: align,
        maxLines: maxLines,
        overflow: maxLines != null ? TextOverflow.ellipsis : TextOverflow.clip,
        text: TextSpan(
          recognizer: TapGestureRecognizer()..onTap = onTap,
          style: TextStyle(height: 1.4, fontFamily: googleSans),
          children: [
            if (text1.isNotEmpty)
              TextSpan(
                text: text1,
                recognizer: TapGestureRecognizer()..onTap = onTap,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
              ),
            if (text2.isNotEmpty)
              TextSpan(
                text: text2,
                recognizer: TapGestureRecognizer()..onTap = onTap,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.blue),
              ),
          ],
        ),
      ),
    );
  }
}
