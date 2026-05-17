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
      child: Scaffold(
        floatingActionButton: Builder(
          builder: (BuildContext context) {
            return CustomFloatingActionButton(
              onPressed: () async {
                var result = await Navigator.pushNamed(
                  context,
                  NewTaskView.routeName,
                );
                if (result == true) {
                  context.read<HomeController>().loadTasK();
                }
              },
              title: 'Add New Task',
            );
          },
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
                        Selector<HomeController, String?>(
                          selector: (context, HomeController controller) =>
                              controller.userImage,
                          builder: (context, String? userImage, Widget? child) {
                            return CircleAvatar(
                              radius: 30,
                              backgroundImage: (userImage != null)
                                  ? FileImage(File(userImage))
                                  : const AssetImage(
                                      'assets/images/Thumbnail.png',
                                    ),
                            );
                          },
                        ),
                        const Gap(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Selector(
                              selector: (context, HomeController controller) =>
                                  controller.userName,
                              builder:
                                  (
                                    BuildContext context,
                                    String? userName,
                                    Widget? child,
                                  ) {
                                    return Text(
                                      'Good Evening, $userName',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    );
                                  },
                            ),
                            Text(
                              'One task at a time.One step\n closer.',
                              style: Theme.of(context).textTheme.displayMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Gap(20),
                    Selector(
                      selector: (context, HomeController controller) =>
                          controller.userName,
                      builder:
                          (
                            BuildContext context,
                            String? userName,
                            Widget? child,
                          ) {
                            return Text(
                              '$userName , Your Work is \nalmost Done !',
                              style: Theme.of(context).textTheme.displayLarge,
                            );
                          },
                    ),
                    const Gap(20),
                    const ArchievedTasks(),
                    const Gap(10),
                    const HighPriorityContainer(),
                    const Gap(10),
                    Text(
                      'My Tasks',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const Gap(10),
                  ],
                ),
              ),
              const CustomSliverTasksListView(),
            ],
          ),
        ),
      ),
    );
  }
}
