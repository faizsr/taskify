import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:taskify/src/config/constants/app_constants.dart';
import 'package:taskify/src/config/styles/app_colors.dart';
import 'package:taskify/src/core/common/k_drop_down_menu.dart';
import 'package:taskify/src/core/common/k_filled_button.dart';
import 'package:taskify/src/core/common/k_text_field.dart';
import 'package:taskify/src/features/auth/domain/entities/user_entity.dart';
import 'package:taskify/src/features/boards/domain/entities/task_entity.dart';
import 'package:taskify/src/features/boards/presentation/controllers/board_controller.dart';

class CreateEditTaskPage extends StatefulWidget {
  final String boardId;
  final TaskEntity? task;

  const CreateEditTaskPage({super.key, this.task, required this.boardId});

  @override
  State<CreateEditTaskPage> createState() => _CreateEditTaskPageState();
}

class _CreateEditTaskPageState extends State<CreateEditTaskPage> {
  final titleCtlr = TextEditingController();
  final descriptionCtlr = TextEditingController();
  final memberSearchCtlr = TextEditingController();
  final startDateCtlr = TextEditingController();
  final endDateCtlr = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String member = '';
  DateTime? startDate;
  DateTime? endDate;

  Future<void> _onCreatePressed() async {
    final boardCtlr = context.read<BoardController>();
    bool success = false;
    if (formKey.currentState!.validate()) {
      if (widget.task == null) {
        final task = TaskEntity(
          boardId: widget.boardId,
          title: titleCtlr.text,
          description: descriptionCtlr.text,
          status: 'to-do',
          assignedTo: member,
          startDate: startDate,
          dueDate: endDate,
          createdAt: DateTime.now(),
        );
        success = await boardCtlr.createTask(task);
      } else {
        final task = TaskEntity(
          id: widget.task!.id,
          title: titleCtlr.text,
          description: descriptionCtlr.text,
          dueDate: endDate,
        );
        success = await boardCtlr.updateTask(task);
      }
    }
    if (success && mounted) context.pop();
  }

  @override
  void initState() {
    if (widget.task != null) {
      titleCtlr.text = widget.task!.title;
      descriptionCtlr.text = widget.task!.description;
      endDate = widget.task!.dueDate;
      endDateCtlr.text = DateFormat(
        'dd MMM yyyy',
      ).format(widget.task!.dueDate!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: true,
        title: Text(widget.task != null ? 'Edit task' : 'Create new task'),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(SolarIconsOutline.arrowLeft),
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            KTextField(
              title: 'Title',
              controller: titleCtlr,
              hintText: 'Project title',
            ),
            vSpace20,
            KTextField(
              maxLines: 5,
              title: 'Description',
              padding: EdgeInsets.all(16),
              controller: descriptionCtlr,
              hintText: 'Describe more about the project',
            ),
            vSpace20,

            if (widget.task == null) ...[
              _buildAssignMemberField(context),
              vSpace20,
            ],

            Row(
              children: [
                if (widget.task == null) ...[
                  Expanded(
                    child: KTextField(
                      title: 'Start date',
                      canRequestFocus: true,
                      controller: startDateCtlr,
                      onTap: () => _pickDate(isStartDate: true),
                    ),
                  ),
                  hSpace12,
                ],
                Expanded(
                  child: KTextField(
                    title: 'Due date',
                    canRequestFocus: true,
                    controller: endDateCtlr,
                    onTap: () => _pickDate(isStartDate: false),
                  ),
                ),
              ],
            ),
            vSpace24,

            Selector<BoardController, bool>(
              selector: (context, controller) => controller.isBtnLoading,
              builder: (context, isLoading, child) {
                return KFilledButton(
                  text: widget.task != null ? 'Update' : 'Create',
                  isLoading: isLoading,
                  onPressed: _onCreatePressed,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Column _buildAssignMemberField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Assign to', style: Theme.of(context).textTheme.titleMedium),
        vSpace4,

        if (member.isNotEmpty) ...[
          _buildMemberEmailCard(member),
        ] else ...[
          Consumer<BoardController>(
            builder: (context, value, child) {
              final currentUser = value.currentUser;
              final users = List<UserEntity>.from(value.allUsers)
                ..removeWhere((e) => e.uid == currentUser?.uid);
              final emails = users.map((e) => e.email).toList();
              return KDropDownMenu(
                list: emails.isEmpty ? ['none'] : emails,
                controller: memberSearchCtlr,
                hintText: 'Seaerch to assign',
                onSelected: (val) {
                  if (val != 'none') {
                    final user = users.firstWhere((e) => e.email == val);
                    member = user.uid;
                    memberSearchCtlr.clear();
                    setState(() {});
                  }
                },
              );
            },
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
          Selector<BoardController, List<UserEntity>>(
            selector: (context, ctlr) => ctlr.allUsers,
            builder: (context, value, child) {
              final user = value.firstWhere(
                (e) => e.uid == member,
                orElse: () => UserEntity(),
              );
              return Text(user.email);
            },
          ),
          hSpace8,
          GestureDetector(
            onTap: () => setState(() => member = ''),
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

  Future<void> _pickDate({required bool isStartDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? startDate ?? DateTime.now()
          : endDate ?? startDate ?? DateTime.now(),
      firstDate: isStartDate ? DateTime(1950) : startDate ?? DateTime(1950),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(
            context,
          ).copyWith(colorScheme: ColorScheme.light(surface: AppColors.white)),
          child: child!,
        );
      },
    );

    if (picked == null) return;

    final formatted = DateFormat('dd MMM yyy').format(picked);

    setState(() {
      if (isStartDate) {
        startDate = picked;
        startDateCtlr.text = formatted;

        // Reset end date if it becomes invalid
        if (endDate != null && endDate!.isBefore(picked)) {
          endDate = null;
          endDateCtlr.clear();
        }
      } else {
        endDate = picked;
        endDateCtlr.text = formatted;
      }
    });
  }
}
