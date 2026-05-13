import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tasky_app/core/theme/theme_controller.dart';
import 'package:tasky_app/core/utils/constant/app_colors.dart';

class ArchievedTasks extends StatelessWidget {
  const ArchievedTasks({
    super.key,
    required this.allTasks,
    required this.completedTasks,
    required this.percentage,
  });
  final int allTasks;
  final int completedTasks;
  final int percentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        border: Border.all(
          color: ThemeController().isLight() ? Colors.grey : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                'Achieved Tasks',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const Gap(4),
              Text(
                '$completedTasks Out of $allTasks Done',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 48,
                height: 48,
                child: Transform.rotate(
                  angle: percentage * pi / 100,
                  child: CircularProgressIndicator(
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.green,
                    ),
                    value: percentage / 100, // دائرة كاملة
                    strokeWidth: 6,
                    backgroundColor: Colors.grey,
                  ),
                ),
              ),
              Text(
                '$percentage%',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
