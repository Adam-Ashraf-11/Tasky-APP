import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/widgets/task_item_widget.dart';
import 'package:tasky_app/feature/home/presentation/manager/home_controller.dart';

class CustomSliverTasksListView extends StatelessWidget {
  const CustomSliverTasksListView({
    super.key,
    // required this.tasks,
    // required this.onTap,
    // required this.onDelet,
    // required this.edit,
  });
  // final List<dynamic> tasks;
  // final Function(bool?, int) onTap;
  // final Function(int?) onDelet;
  // final Function() edit;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder:
          (BuildContext context, HomeController controller, Widget? child) {
            return controller.task.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'No Tasks',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.only(bottom: 60),
                    sliver: SliverList.builder(
                      itemCount: controller.task.length,
                      itemBuilder: (context, index) => TaskItemWidget(
                        model: controller.task.elementAt(index),
                        onTap: (bool? value) {
                          controller.doneTask(value, index);
                        },
                        onDelet: (int id) => controller.deleteTask(id),
                        edit: () {
                          controller.loadTasK();
                        },
                      ),
                    ),
                  );
          },
    );
  }
}
