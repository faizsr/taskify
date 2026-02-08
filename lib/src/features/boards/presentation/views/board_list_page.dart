import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:taskify/src/config/constants/app_constants.dart';
import 'package:taskify/src/config/di/injections.dart';
import 'package:taskify/src/config/router/app_routes.dart';
import 'package:taskify/src/config/styles/app_colors.dart';
import 'package:taskify/src/features/auth/domain/entities/user_entity.dart';
import 'package:taskify/src/features/boards/presentation/controllers/board_controller.dart';
import 'package:taskify/src/features/boards/presentation/widgets/board_card.dart';

class BoardListPage extends StatefulWidget {
  const BoardListPage({super.key});

  @override
  State<BoardListPage> createState() => _BoardListPageState();
}

class _BoardListPageState extends State<BoardListPage> {
  late BoardController boardCtlr;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      boardCtlr = context.read<BoardController>();
      boardCtlr.getAllUsers();
      boardCtlr.getCurrentUser();
      boardCtlr.getAllBoards();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHeader(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<BoardController>(
          builder: (context, value, child) {
            if (value.boards.isNotEmpty) {
              return ListView(
                children: [
                  _buildTitle(context),
                  vSpace12,
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: value.boards.length,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => vSpace16,
                    itemBuilder: (context, index) {
                      return BoardCard(board: value.boards[index]);
                    },
                  ),
                ],
              );
            }

            return _buildEmptyBoardWidget(context);
          },
        ),
      ),
    );
  }

  Center _buildEmptyBoardWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              context.push(AppRoutes.createBoard);
            },
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.blue,
              ),
              child: Icon(Icons.add, size: 20, color: AppColors.white),
            ),
          ),
          vSpace8,
          Text(
            'No boards found',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Boards',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: () {
            context.push(AppRoutes.createBoard);
          },
          child: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.blue,
            ),
            child: Icon(Icons.add, size: 20, color: AppColors.white),
          ),
        ),
      ],
    );
  }

  AppBar _buildHeader() {
    return AppBar(
      leadingWidth: 0,
      actions: [
        IconButton(
          icon: Icon(SolarIconsOutline.logout),
          onPressed: () {
            context.read<BoardController>().clearOnLogout();
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
          Selector<BoardController, UserEntity?>(
            selector: (context, ctlr) => ctlr.currentUser,
            builder: (context, value, child) {
              return Text(
                "Hi${value != null ? ' ${value.name}' : ''},",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(),
              );
            },
          ),
        ],
      ),
    );
  }
}
