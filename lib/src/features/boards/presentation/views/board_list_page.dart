import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:taskify/src/config/constants/app_constants.dart';
import 'package:taskify/src/config/di/injections.dart';
import 'package:taskify/src/config/router/app_routes.dart';
import 'package:taskify/src/config/styles/app_colors.dart';
import 'package:taskify/src/core/common/k_filled_button.dart';
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

  Widget _buildTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Your Boards',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        KFilledButton(
          width: 0,
          text: 'Create',
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          onPressed: () {
            context.push(AppRoutes.createBoard);
          },
        ),
      ],
    );
  }

  AppBar _buildHeader(BuildContext context) {
    return AppBar(
      leadingWidth: 0,
      actions: [
        IconButton(
          icon: Icon(SolarIconsOutline.logout),
          onPressed: () {
            sl<FirebaseAuth>().signOut();
            context.pop();
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
