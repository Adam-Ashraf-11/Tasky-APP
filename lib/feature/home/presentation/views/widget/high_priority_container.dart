import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/theme/theme_controller.dart';
import 'package:tasky_app/core/utils/constant/app_colors.dart';
import 'package:tasky_app/feature/home/presentation/manager/home_controller.dart';
import 'package:tasky_app/feature/tasks/presentation/views/high_priority_view.dart';

class HighPriorityContainer extends StatelessWidget {
  const HighPriorityContainer({
    super.key,
    // required this.tasks,
    // required this.onTap,
    // required this.refrash,
  });
  // final List<dynamic> tasks;
  // final Function(bool? v, int index) onTap;
  // final VoidCallback refrash;
  @override
  Widget build(BuildContext context) {
    // final highPriorityTasks = tasks.reversed.where((e) => e.isHighPriority).take(4).toList();
    
    return Consumer(
      builder: (BuildContext context, HomeController controller, Widget? child) {
             final tasksList = controller.task;

        final bool hasMoreTasks =
     tasksList.reversed.where((e) => e.isHighPriority).length > 4;
        return Container(
          padding: EdgeInsets.all(!hasMoreTasks ? 8 : 0),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: ThemeController().isLight()
                  ? Colors.grey
                  : Colors.transparent,
            ),
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16, top: 8),
                      child: Text(
                        'High Priority Tasks',
                        style: TextStyle(
                          color: AppColors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Gap(8),
                    ListView.builder(
                      itemCount:
                          tasksList.reversed.where((e) => e.isHighPriority).length >
                              4
                          ? 4
                          : tasksList.reversed
                                .where((e) => e.isHighPriority)
                                .length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final e = tasksList.reversed
                            .where((e) => e.isHighPriority)
                            .take(4)
                            .toList()[index];
                        return Row(
                          children: [
                            Checkbox(
                              value: e.isDone ?? false,
                              onChanged: (bool? v) {
                                final index = tasksList.indexWhere(
                                  (element) => element.id == e.id,
                                );
                                controller.doneTask(v, index);
                              
                              },
                            ),
                            Expanded(
                              child: Text(
                                e.taskName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: (e.isDone ?? false)
                                    ? Theme.of(context).textTheme.labelSmall
                                    : Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              if (hasMoreTasks)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: GestureDetector(
                    onTap: () async {
                      await Navigator.pushNamed(
                        context,
                        HighPriorityView.routeName,
                      );
                      controller.loadTasK();
                      // refrash();
                    },
                    child: Container(
                      width: 55,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        border: Border.all(color: const Color(0xff6d6d6d)),
                      ),
                      child: SvgPicture.asset(
                        'assets/images/arrow-up-right.svg',
                        colorFilter: ColorFilter.mode(
                          ThemeController().isLight()
                              ? Colors.black
                              : Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
