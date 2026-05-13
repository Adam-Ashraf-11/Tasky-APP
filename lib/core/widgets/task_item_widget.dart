import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tasky_app/core/theme/theme_controller.dart';
import 'package:tasky_app/feature/home/data/models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({super.key, required this.model, required this.onTap});
  final TaskModel model;
  final Function(bool?) onTap;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ThemeController().isLight() ? Colors.grey : Colors.transparent,
        ),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Center(
        child: Row(
          children: [
            const Gap(8),
            Checkbox(
              value: model.isDone ?? false,
              onChanged: (bool? v) => onTap(v),
            ),
            const Gap(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    model.taskName,
                    style: (model.isDone ?? false)
                        ? Theme.of(context).textTheme.labelSmall
                        : Theme.of(context).textTheme.labelMedium,
                  ),
                  if (model.taskDescription!.isNotEmpty)
                    Text(
                      model.taskDescription!,
                      style: (model.isDone ?? false)
                          ? Theme.of(context).textTheme.labelSmall
                          : Theme.of(context).textTheme.labelMedium,
                    ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: ThemeController().isDark()
                    ? ((model.isDone ?? true) ? Colors.grey : Colors.white)
                    : ((model.isDone ?? true) ? Colors.grey : Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
