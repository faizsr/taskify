import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:taskify/src/config/constants/app_constants.dart';
import 'package:taskify/src/config/styles/app_colors.dart';

class BoardCard extends StatelessWidget {
  const BoardCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrey),
        boxShadow: [
          BoxShadow(
            color: AppColors.lightBlue.withValues(alpha: 0.1),
            blurRadius: 10,
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
                      'Project One',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'Created by: John',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.lightBlue,
                      ),
                    ),
                  ],
                ),
                Text(
                  '18 Jan 2026',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.lightGrey),
          ListView.separated(
            itemCount: 2,
            shrinkWrap: true,
            padding: EdgeInsets.all(12),
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => vSpace12,
            itemBuilder: (context, index) {
              return _buildTaskCard(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context) {
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
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Assinged to You',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
                      ),
                      vSpace2,
                      Text(
                        'Auth Feature',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      vSpace8,
                      Container(
                        padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.grey.withValues(alpha: 0.4),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              SolarIconsOutline.calendarMinimalistic,
                              size: 16,
                            ),
                            hSpace4,
                            Text(
                              '28 Jan 2026',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppColors.grey.withValues(alpha: 0.2),
                  ),
                  child: Text(
                    'To do',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
