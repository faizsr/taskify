import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:taskify/src/config/constants/app_constants.dart';
import 'package:taskify/src/config/styles/app_colors.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  String selectedStatus = 'to-do';

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.lightBlue.withValues(alpha: 0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              hSpace12,
              Text(
                'Assigned to You',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.blue),
              ),
              Spacer(),
              Text(
                '28 Jan 2026',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
              ),
              PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(value: 'edit', child: Text('Edit')),
                    PopupMenuItem(value: 'delete', child: Text('Delete')),
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
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Task Title',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                vSpace4,
                Text(
                  'Task description description description description description description',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.black.withValues(alpha: 0.8),
                  ),
                ),
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
                            '18 Jan 2026',
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
          initialSelection: 'to-do',
          textStyle: Theme.of(context).textTheme.titleSmall,
          dropdownMenuEntries: const [
            DropdownMenuEntry(value: 'to-do', label: 'To do'),
            DropdownMenuEntry(value: 'in-progress', label: 'In progress'),
            DropdownMenuEntry(value: 'done', label: 'Done'),
          ],
          showTrailingIcon: false,
          onSelected: (value) => setState(() => selectedStatus = value!),
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
            fillColor: selectedStatus == 'to-do'
                ? AppColors.grey.withValues(alpha: 0.2)
                : selectedStatus == 'done'
                ? Colors.amberAccent
                : AppColors.lightBlue,
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
