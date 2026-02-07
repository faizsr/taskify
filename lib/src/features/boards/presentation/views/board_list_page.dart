import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:taskify/src/config/constants/app_constants.dart';
import 'package:taskify/src/config/di/injections.dart';
import 'package:taskify/src/config/router/app_routes.dart';
import 'package:taskify/src/config/styles/app_colors.dart';
import 'package:taskify/src/features/boards/presentation/widgets/board_card.dart';

class BoardListPage extends StatelessWidget {
  const BoardListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHeader(context),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildTitle(context),
            vSpace12,
            ListView.separated(
              itemCount: 6,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => vSpace16,
              itemBuilder: (context, index) => BoardCard(),
            ),
          ],
        ),
      ),
    );
  }

  Align _buildTitle(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
        decoration: BoxDecoration(
          color: AppColors.blue.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'Your Boards',
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(color: AppColors.black),
        ),
      ),
    );
  }

  AppBar _buildHeader(BuildContext context) {
    return AppBar(
      leadingWidth: 0,
      actions: [
        IconButton(
          icon: Icon(Icons.add_rounded),
          style: IconButton.styleFrom(
            backgroundColor: AppColors.blue,
            foregroundColor: AppColors.white,
          ),
          onPressed: () {
            sl<FirebaseAuth>().signOut();
            context.go(AppRoutes.login);
          },
        ),
        hSpace4,
      ],
      title: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.lightGrey),
            ),
            child: Icon(SolarIconsBold.user, size: 20),
          ),
          hSpace8,
          Text(
            'Hi Groov,',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(),
          ),
        ],
      ),
    );
  }
}
