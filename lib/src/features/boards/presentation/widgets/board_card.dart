import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:taskify/src/config/constants/app_constants.dart';
import 'package:taskify/src/config/di/injections.dart';
import 'package:taskify/src/config/router/app_routes.dart';
import 'package:taskify/src/config/styles/app_colors.dart';
import 'package:taskify/src/features/auth/domain/entities/user_entity.dart';
import 'package:taskify/src/features/boards/domain/entities/board_entity.dart';
import 'package:taskify/src/features/boards/domain/entities/task_entity.dart';
import 'package:taskify/src/features/boards/presentation/controllers/board_controller.dart';

class BoardCard extends StatelessWidget {
  final BoardEntity board;

  const BoardCard({super.key, required this.board});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.boardDetail, extra: {'id': board.id});
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.lightGrey),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: AppColors.grey.withValues(alpha: 0.2),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        board.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Consumer<BoardController>(
                        builder: (context, value, child) {
                          final currentUserId = value.currentUser?.uid ?? '';
                          final user = value.allUsers.firstWhere(
                            (e) => e.uid == board.createdBy,
                            orElse: () => UserEntity(),
                          );

                          return Text(
                            'Created by: ${user.uid == currentUserId ? 'You' : user.name}',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: AppColors.black.withValues(alpha: 0.8),
                                ),
                          );
                        },
                      ),
                    ],
                  ),
                  Text(
                    DateFormat('dd MMM yyyy').format(board.createdAt!),
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: AppColors.lightGrey),
            if (board.taskEntities.isEmpty) ...[
              SizedBox(
                height: 100,
                child: Center(
                  child: Text(
                    'No tasks found',
                    style: TextStyle(color: AppColors.grey),
                  ),
                ),
              ),
            ] else ...[
              ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.all(12),
                itemCount: board.taskEntities.length == 2 ? 2 : 1,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => vSpace12,
                itemBuilder: (context, index) {
                  return _buildTaskCard(context, board.taskEntities[index]);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context, TaskEntity task) {
    return Row(
      children: [
        Text('||'),
        hSpace12,
        Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(8, 8, 12, 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.lightBlue.withValues(alpha: 0.1),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      task.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Selector<BoardController, List<UserEntity>>(
                      selector: (context, ctlr) => ctlr.allUsers,
                      builder: (context, value, child) {
                        final currentUserId =
                            sl<FirebaseAuth>().currentUser?.uid;
                        final user = value.firstWhere(
                          (e) => e.uid == task.assignedTo,
                          orElse: () => UserEntity(),
                        );
                        return Text(
                          'Assigned to ${user.uid == currentUserId ? 'You' : user.name}',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppColors.blue),
                        );
                      },
                    ),
                  ],
                ),
                vSpace8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.lightGrey),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            SolarIconsOutline.calendar,
                            color: AppColors.blue,
                            size: 20,
                          ),
                          hSpace12,
                          Text(
                            DateFormat('dd MMM yyyy').format(task.dueDate!),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: task.status == 'to-do'
                            ? AppColors.lightGrey
                            : task.status == 'done'
                            ? Colors.amberAccent
                            : Colors.lightBlueAccent,
                      ),
                      child: Text(
                        task.status == 'to-do'
                            ? 'To do'
                            : task.status == 'done'
                            ? 'Done'
                            : 'In progress',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
