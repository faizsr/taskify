import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:taskify/src/config/constants/app_constants.dart';
import 'package:taskify/src/config/styles/app_colors.dart';
import 'package:taskify/src/core/common/k_drop_down_menu.dart';
import 'package:taskify/src/core/common/k_filled_button.dart';
import 'package:taskify/src/core/common/k_text_field.dart';
import 'package:taskify/src/features/boards/presentation/controllers/board_controller.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final titleCtlr = TextEditingController();
  final descriptionCtlr = TextEditingController();
  final memberSearchCtlr = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final startDateCtlr = TextEditingController();
  final endDateCtlr = TextEditingController();

  String member = '';
  DateTime? startDate;
  DateTime? endDate;

  Future<void> _onCreatePressed() async {}

  Future<void> _pickDate({
    required BuildContext context,
    required bool isStartDate,
  }) async {
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

    final formatted =
        '${picked.day.toString().padLeft(2, '0')}-'
        '${picked.month.runtimeType}-'
        '${picked.year}';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: true,
        title: Text('Create new task'),
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
            _buildAssignMemberField(context),
            vSpace20,
            Row(
              children: [
                Expanded(
                  child: KTextField(
                    title: 'Start date',
                    canRequestFocus: false,
                    controller: startDateCtlr,
                    onTap: () => _pickDate(context: context, isStartDate: true),
                  ),
                ),
                hSpace12,
                Expanded(
                  child: KTextField(
                    title: 'End date',
                    canRequestFocus: false,
                    controller: endDateCtlr,
                    onTap: () =>
                        _pickDate(context: context, isStartDate: false),
                  ),
                ),
              ],
            ),
            vSpace24,

            Selector<BoardController, bool>(
              selector: (context, controller) => controller.isBtnLoading,
              builder: (context, isLoading, child) {
                return KFilledButton(
                  text: 'Create',
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
          KDropDownMenu(
            title: 'Members',
            list: ['one', 'two'],
            controller: memberSearchCtlr,
            hintText: 'Seaerch to assign',
            onSelected: (val) {
              member = val!;
              memberSearchCtlr.clear();
              setState(() {});
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
          Text(member),
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
}
