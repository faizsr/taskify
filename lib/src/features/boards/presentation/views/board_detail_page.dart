import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:taskify/src/config/constants/app_constants.dart';
import 'package:taskify/src/config/router/app_routes.dart';
import 'package:taskify/src/config/styles/app_colors.dart';
import 'package:taskify/src/core/common/confirm_dialog.dart';
import 'package:taskify/src/core/common/k_filled_button.dart';
import 'package:taskify/src/features/auth/domain/entities/user_entity.dart';
import 'package:taskify/src/features/boards/domain/entities/board_entity.dart';
import 'package:taskify/src/features/boards/domain/entities/task_entity.dart';
import 'package:taskify/src/features/boards/presentation/controllers/board_controller.dart';
import 'package:taskify/src/features/boards/presentation/widgets/task_card.dart';

class BoardDetailPage extends StatefulWidget {
  final String id;
  const BoardDetailPage({super.key, required this.id});

  @override
  State<BoardDetailPage> createState() => _BoardDetailPageState();
}

class _BoardDetailPageState extends State<BoardDetailPage> {
  bool canEdit = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final boardCtlr = context.read<BoardController>();
      boardCtlr.getBoard(widget.id);
      boardCtlr.getAllTasks(widget.id);
    });
    super.initState();
  }

  void _onDeletePressed() {
    String subTitle =
        'You’re about to delete this board. This action is irreversible.';
    showDialog(
      context: context,
      barrierColor: AppColors.black.withValues(alpha: 0.6),
      builder: (context) {
        return ConfirmDialog(
          icon: '?',
          disableCancel: true,
          title: 'Confirm Delete',
          subTitle: subTitle,
          onPressed: () async {
            context.pop();
            final boardCtlr = context.read<BoardController>();
            final status = await boardCtlr.deleteBoard(widget.id);
            if (status && context.mounted) context.pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BoardController>(
      builder: (context, value, child) {
        if (value.board != null) {
          canEdit = value.currentUser?.uid == value.board?.createdBy;
          return Scaffold(
            appBar: _buildAppBar(value.board!),
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildDescription(value.board!),
                vSpace20,
                _buildMembersSection(value.board!, value.allUsers),
                vSpace28,
                _buildTaskStatus(context, value),
                vSpace24,
                _buildTaskList(value.tasks),
              ],
            ),
          );
        }

        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Row _buildTaskStatus(BuildContext context, BoardController value) {
    final currentUserId = value.currentUser?.uid ?? '';
    final user = value.allUsers.firstWhere(
      (e) => e.uid == value.board?.createdBy,
      orElse: () => UserEntity(),
    );
    return Row(
      children: [
        _buildStatusCard(
          context: context,
          icon: SolarIconsOutline.calendar,
          title: 'Created At',
          value: DateFormat('dd MMM yyyy').format(value.board!.createdAt!),
        ),
        hSpace12,
        _buildStatusCard(
          context: context,
          icon: SolarIconsOutline.documentAdd,
          title: 'Created By',
          value: user.uid == currentUserId ? 'You' : user.name,
        ),
      ],
    );
  }

  Widget _buildDescription(BoardEntity board) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: Theme.of(context).textTheme.titleMedium),
        vSpace8,
        Text(
          board.description,
          maxLines: null,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildMembersSection(BoardEntity board, List<UserEntity> users) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Members (${board.members.length})',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (board.members.isEmpty) ...[
              GestureDetector(
                onTap: () {
                  context.push(AppRoutes.editBoard, extra: {'board': board});
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
          ],
        ),
        if (board.members.isNotEmpty) ...[
          vSpace12,
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(board.members.length, (index) {
              final user = users.firstWhere(
                (e) => e.uid == board.members[index],
                orElse: () => UserEntity(),
              );
              return _buildMemberEmailCard(user.email);
            }),
          ),
        ],
      ],
    );
  }

  Container _buildMemberEmailCard(String member) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 4, 4, 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColors.lightBlue.withValues(alpha: 0.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(member),
          hSpace8,
          GestureDetector(
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
              child: Icon(Icons.close, size: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.lightGrey),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.lightBlue),
            hSpace12,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
                ),
                vSpace2,
                Text(value, style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskList(List<TaskEntity> tasks) {
    if (tasks.isEmpty) {
      return KFilledButton(
        text: 'Create Task',
        onPressed: () {
          context.push(AppRoutes.createTask, extra: {'boardId': widget.id});
        },
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tasks',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                context.push(
                  AppRoutes.createTask,
                  extra: {'boardId': widget.id},
                );
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
        ),
        vSpace12,
        ListView.separated(
          itemCount: tasks.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => vSpace16,
          itemBuilder: (context, index) {
            return TaskCard(task: tasks[index], canEdit: canEdit);
          },
        ),
      ],
    );
  }

  AppBar _buildAppBar(BoardEntity board) {
    return AppBar(
      titleSpacing: 0,
      title: Text(board.title),
      centerTitle: canEdit,
      leading: IconButton(
        icon: Icon(SolarIconsOutline.arrowLeft),
        onPressed: () => context.pop(),
      ),
      actions: canEdit
          ? [
              IconButton(
                icon: Icon(SolarIconsOutline.pen2),
                onPressed: () {
                  context.push(AppRoutes.editBoard, extra: {'board': board});
                },
              ),
              IconButton(
                icon: Icon(SolarIconsOutline.trashBinMinimalistic),
                onPressed: _onDeletePressed,
              ),
            ]
          : [],
    );
  }
}
