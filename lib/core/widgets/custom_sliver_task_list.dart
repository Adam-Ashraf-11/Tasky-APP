import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tasky_app/core/utils/constant/app_colors.dart';

class CustomSliverTasksListView extends StatelessWidget {
  const CustomSliverTasksListView({
    super.key,
    required this.tasks,
    required this.onTap,
  });
  final List<dynamic> tasks;
  final Function(bool?, int) onTap;
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 60),
      sliver: SliverList.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) => Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xff282828),
          ),
          child: Center(
            child: Row(
              children: [
                const Gap(8),
                Checkbox(
                  checkColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  activeColor: AppColors.green,
                  value: tasks[index].isDone ?? false,
                  onChanged: (bool? v) {
                    onTap(v, index);
                  },
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
                        tasks[index].taskName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: (tasks[index].isDone ?? false)
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          decorationColor: Colors.red,
                          decorationThickness: 5,
                        ),
                      ),
                      if (tasks[index].taskDescription.isNotEmpty)
                        Text(
                          tasks[index].taskDescription,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ),
      
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: (tasks[index].isDone ?? true)
                        ? Colors.grey
                        : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
