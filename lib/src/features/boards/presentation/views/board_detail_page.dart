import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:taskify/src/config/constants/app_constants.dart';
import 'package:taskify/src/config/styles/app_colors.dart';
import 'package:taskify/src/features/boards/presentation/widgets/task_card.dart';

class BoardDetailPage extends StatelessWidget {
  final String boardTitle;
  final String boardDescription;
  final List<String> members;
  final DateTime? createdAt;

  const BoardDetailPage({
    super.key,
    this.boardTitle = 'Design System',
    this.boardDescription =
        'Collaborate on our latest design system updates and improvements',
    this.members = const ['user1', 'user2', 'user3'],
    this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDescription(context),
          vSpace16,
          _buildMembersSection(context),
          vSpace28,
          Row(
            children: [
              _buildStatusCard(
                context: context,
                icon: SolarIconsOutline.calendar,
                title: 'Created At',
                value: '18 Jan 2026',
              ),
              hSpace12,
              _buildStatusCard(
                context: context,
                icon: SolarIconsOutline.documentAdd,
                title: 'Created By',
                value: 'You',
              ),
            ],
          ),
          vSpace24,
          _buildTaskList(context),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      centerTitle: true,
      title: Text(boardTitle),
      leading: IconButton(
        icon: Icon(SolarIconsOutline.arrowLeft),
        onPressed: () => context.pop(),
      ),
      actions: [
        IconButton(
          icon: Icon(SolarIconsOutline.trashBinMinimalistic),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: Theme.of(context).textTheme.titleMedium),
        TextFormField(
          maxLines: null,
          initialValue: boardDescription,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(border: InputBorder.none),
          onTapUpOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
      ],
    );
  }

  Widget _buildMembersSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Members (${members.length})',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        vSpace12,
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children:
              List.generate(
                members.length,
                (index) => _buildMemberEmailCard(members[index]),
              ).followedBy([
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.blue,
                  ),
                  child: Icon(Icons.add, size: 20, color: AppColors.white),
                ),
              ]).toList(),
        ),
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

  Widget _buildTaskList(BuildContext context) {
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
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.blue,
              ),
              child: Icon(Icons.add, size: 20, color: AppColors.white),
            ),
          ],
        ),
        vSpace12,
        ListView.separated(
          itemCount: 5,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => vSpace16,
          itemBuilder: (context, index) {
            return TaskCard();
          },
        ),
      ],
    );
  }
}
