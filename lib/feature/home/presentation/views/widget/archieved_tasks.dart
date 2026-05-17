import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/theme/theme_controller.dart';
import 'package:tasky_app/core/utils/constant/app_colors.dart';
import 'package:tasky_app/feature/home/presentation/manager/home_controller.dart';

class ArchievedTasks extends StatelessWidget {
  const ArchievedTasks({
    super.key,
    // required this.allTasks,
    // required this.completedTasks,
    // required this.percentage,
  });
  // final int allTasks;
  // final int completedTasks;
  // final int percentage;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, HomeController controller, Widget? child) {
        return Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            border: Border.all(
              color: ThemeController().isLight()
                  ? Colors.grey
                  : Colors.transparent,
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
                    '${controller.completedTasks} Out of ${ controller.allTasks} Done',
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
                      angle: controller. percentage * pi / 100,
                      child: CircularProgressIndicator(
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.green,
                        ),
                        value: controller. percentage  / 100, // دائرة كاملة
                        strokeWidth: 6,
                        backgroundColor: Colors.grey,
                      ),
                    ),
                  ),
                  Text(
                    '${controller. percentage}%',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
