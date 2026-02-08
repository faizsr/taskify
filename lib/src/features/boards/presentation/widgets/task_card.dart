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
import 'package:taskify/src/core/common/confirm_dialog.dart';
import 'package:taskify/src/core/common/custom_snackbar.dart';
import 'package:taskify/src/features/auth/domain/entities/user_entity.dart';
import 'package:taskify/src/features/auth/presentation/controllers/auth_controller.dart';
import 'package:taskify/src/features/boards/domain/entities/task_entity.dart';
import 'package:taskify/src/features/boards/presentation/controllers/board_controller.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.task, required this.canEdit});

  final TaskEntity task;
  final bool canEdit;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late AuthController authCtlr;
  late BoardController boardCtlr;

  String selectedStatus = 'to-do';

  void _updateTaskStatus(String? value) {
    final task = TaskEntity(id: widget.task.id, status: value!);
    boardCtlr.updateTask(task);
    setState(() => selectedStatus = value);
  }

  void _deleteTask() {
    if (!authCtlr.isNetworkConnected) {
      showCustomSnackbar(type: SnackType.noInternet);
      return;
    }
    String subTitle =
        'You’re about to delete this task. This action is irreversible.';
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
            final status = await boardCtlr.deleteTask(widget.task.id);
            if (status && context.mounted) context.pop();
          },
        );
      },
    );
  }

  void _editTask() {
    if (!authCtlr.isNetworkConnected) {
      showCustomSnackbar(type: SnackType.noInternet);
      return;
    }
    context.push(
      AppRoutes.editTask,
      extra: {'boardId': widget.task.boardId, 'task': widget.task},
    );
  }

  @override
  void initState() {
    authCtlr = context.read<AuthController>();
    boardCtlr = context.read<BoardController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.lightBlue.withValues(alpha: 0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: widget.canEdit
                ? EdgeInsets.only(left: 12)
                : EdgeInsets.fromLTRB(12, 12, 12, 12),
            child: Row(
              children: [
                Selector<BoardController, List<UserEntity>>(
                  selector: (context, ctlr) => ctlr.allUsers,
                  builder: (context, value, child) {
                    final currentUserId = sl<FirebaseAuth>().currentUser?.uid;
                    final user = value.firstWhere(
                      (e) => e.uid == widget.task.assignedTo,
                      orElse: () => UserEntity(),
                    );
                    return Text(
                      'Assigned to ${user.uid == currentUserId ? 'You' : user.name}',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: AppColors.blue),
                    );
                  },
                ),
                Spacer(),
                Text(
                  DateFormat('dd MMM yyyy').format(widget.task.createdAt!),
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
                ),
                if (widget.canEdit) ...[
                  // IconButton(
                  //   onPressed: _deleteTask,
                  //   icon: Icon(SolarIconsOutline.trashBinMinimalistic),
                  //   iconSize: 20,
                  // ),
                  PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: 'edit',
                          onTap: _editTask,
                          child: Text('Edit'),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          onTap: _deleteTask,
                          child: Text('Delete'),
                        ),
                      ];
                    },
                    iconSize: 20,
                    elevation: 0,
                    color: AppColors.white,
                    position: PopupMenuPosition.under,
                    menuPadding: const EdgeInsets.all(2),
                    popUpAnimationStyle: AnimationStyle(
                      curve: Curves.easeIn,
                      reverseCurve: Curves.easeOut,
                      duration: const Duration(milliseconds: 400),
                      reverseDuration: const Duration(milliseconds: 400),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    offset: Offset(-12, 0),
                    onSelected: (value) {},
                  ),
                ],
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.task.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (widget.task.description.isNotEmpty) ...[
                  vSpace4,
                  Text(
                    widget.task.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.black.withValues(alpha: 0.8),
                    ),
                  ),
                ],
                vSpace12,

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
                        children: [
                          Icon(
                            SolarIconsOutline.calendar,
                            color: AppColors.blue,
                            size: 20,
                          ),
                          hSpace12,
                          Text(
                            DateFormat(
                              'dd MMM yyyy',
                            ).format(widget.task.dueDate!),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),

                    _buildTaskStatusDropDown(context),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Stack _buildTaskStatusDropDown(BuildContext context) {
    return Stack(
      children: [
        DropdownMenu<String>(
          initialSelection: widget.task.status,
          textStyle: Theme.of(context).textTheme.titleSmall,
          dropdownMenuEntries: const [
            DropdownMenuEntry(value: 'to-do', label: 'To do'),
            DropdownMenuEntry(value: 'in-progress', label: 'In progress'),
            DropdownMenuEntry(value: 'done', label: 'Done'),
          ],
          showTrailingIcon: false,
          onSelected: _updateTaskStatus,
          menuStyle: MenuStyle(
            elevation: WidgetStatePropertyAll(0),
            backgroundColor: WidgetStatePropertyAll(AppColors.white),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: AppColors.lightGrey),
              ),
            ),
            padding: const WidgetStatePropertyAll(EdgeInsets.zero),
          ),
          enableSearch: false,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            isCollapsed: true,
            fillColor: widget.task.status == 'to-do'
                ? AppColors.lightGrey
                : widget.task.status == 'done'
                ? Colors.amberAccent
                : Colors.lightBlueAccent,
            contentPadding: const EdgeInsets.all(8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        Positioned(
          right: 4,
          top: 0,
          bottom: 0,
          child: Icon(Icons.arrow_drop_down, color: AppColors.black),
        ),
      ],
    );
  }
}
