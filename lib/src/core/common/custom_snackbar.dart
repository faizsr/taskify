import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:taskify/src/config/constants/app_constants.dart';
import 'package:taskify/src/config/styles/app_colors.dart';
import 'package:taskify/src/core/utils/navigation_helper.dart';

enum SnackType { success, error, info, noInternet }

void showCustomSnackbar({
  String content = '',
  required SnackType type,
  DismissDirection? dismissDirection,
  Duration duration = const Duration(seconds: 4),
}) {
  final context = NavigationHelper.navigatorKey.currentContext!;
  IconData? leading;
  if (type == SnackType.success) {
    leading = SolarIconsOutline.checkCircle;
  } else if (type == SnackType.error) {
    leading = SolarIconsOutline.dangerCircle;
  } else if (type == SnackType.info) {
    leading = SolarIconsOutline.infoCircle;
  } else if (type == SnackType.noInternet) {
    leading = Icons.wifi_off_outlined;
    content = 'Check your internet connection';
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      duration: duration,
      padding: EdgeInsets.all(12),
      dismissDirection: dismissDirection,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColors.grey.withValues(alpha: 0.8)),
      ),
      clipBehavior: Clip.hardEdge,
      content: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(leading),
          hSpace8,
          Expanded(
            child: Text(content, style: Theme.of(context).textTheme.labelLarge),
          ),
        ],
      ),
      backgroundColor: AppColors.white,
    ),
  );
}
