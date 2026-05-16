import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/widgets/custom_floating_action_button.dart';
import 'package:tasky_app/core/widgets/custom_sliver_task_list.dart';
import 'package:tasky_app/feature/home/presentation/manager/home_controller.dart';
import 'package:tasky_app/feature/home/presentation/views/new_task_view.dart';
import 'package:tasky_app/feature/home/presentation/views/widget/archieved_tasks.dart';
import 'package:tasky_app/feature/home/presentation/views/widget/high_priority_container.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override

  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (BuildContext context) => HomeController()..init(),
      child: Consumer<HomeController>(
        builder: (BuildContext context, HomeController value, Widget? child) {
          final controller = context.read<HomeController>();
          return Scaffold(
            floatingActionButton: CustomFloatingActionButton(
              onPressed: () async {
                var result = await Navigator.pushNamed(
                  context,
                  NewTaskView.routeName,
                );
                if (result == true) {
                  controller.loadTasK();
                }
              },
              title: 'Add New Task',
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: (value.userImage != null)
                                  ? FileImage(File(value.userImage!))
                                  : const AssetImage(
                                      'assets/images/Thumbnail.png',
                                    ),
                            ),
                            const Gap(10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Good Evening,${value.userName}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'One task at a time.One step\n closer.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Gap(20),
                        Text(
                          '${value.userName} , Your Work is \nalmost Done !',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        const Gap(20),
                        ArchievedTasks(
                          allTasks: value.allTasks,
                          completedTasks: value.completedTasks,
                          percentage: value.percentage,
                        ),
                        const Gap(10),
                        HighPriorityContainer(
                          refrash: () => controller.loadTasK(),
                          tasks: value.task,
                          onTap: (bool? v, int index) {
                            controller.doneTask(v, index);
                          },
                        ),
                        const Gap(10),
                        Text(
                          'My Tasks',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const Gap(10),
                      ],
                    ),
                  ),
                  CustomSliverTasksListView(
                    tasks: value.task,
                    onTap: (bool? value, int? index) {
                      controller.doneTask(value, index!);
                    },
                    onDelet: (int? id) {
                      controller.deleteTask(id);
                    },
                    edit: () {
                      controller.loadTasK();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
