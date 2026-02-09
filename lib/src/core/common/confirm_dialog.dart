import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify/src/config/constants/app_constants.dart';
import 'package:taskify/src/config/styles/app_colors.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    this.title = '',
    this.subTitle = '',
    this.icon = '',
    this.onPressed,
    this.actionBtnText,
    this.disableCancel = false,
    this.isLoading = false,
    this.onCancelPressed,
  });

  final String title;
  final String subTitle;
  final String icon;
  final bool isLoading;
  final bool disableCancel;
  final String? actionBtnText;
  final void Function()? onPressed;
  final void Function()? onCancelPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.white.withValues(alpha: 0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                Container(
                  width: 32,
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.blue),
                  ),
                  child: Text(
                    icon,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: AppColors.blue),
                  ),
                ),
              ],
            ),
            vSpace4,
            Text(
              subTitle,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
            ),
            vSpace12,
            Divider(height: 1),
            vSpace4,
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      if (onCancelPressed != null) onCancelPressed!();
                      context.pop();
                    },
                    child: Text('Cancel'),
                  ),
                ),
                SizedBox(height: 30, child: VerticalDivider(width: 1)),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(padding: EdgeInsets.all(8)),
                    onPressed: onPressed,
                    child: Text(actionBtnText ?? 'Confirm'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
