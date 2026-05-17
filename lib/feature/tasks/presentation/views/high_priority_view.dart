
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/widgets/custom_app_bar.dart';
import 'package:tasky_app/core/widgets/custom_tasks_list_view.dart';
import 'package:tasky_app/feature/tasks/presentation/manager/tasks_controller.dart';

class HighPriorityView extends StatelessWidget {
  const HighPriorityView({super.key});

  static const routeName = 'high-priority';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TasksController>(
      create: (_) => TasksController()..init(),
      builder: (context, _) {
        final controller = context.watch<TasksController>();
        return Scaffold(
          appBar: customAppBar(title: 'High Priority Tasks'),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Consumer<TasksController>(
              builder: (context, value, child) {
                return CustomTasksListView(
                  tasks: value. highPriorityTasks,
                  onTap: (bool? v, int index) async {
                   controller.doneHighPriorityTask(v!, index);
                  },
                  onDelet: (int id) {
                   controller. deleteTask(id);
                  },
                  edit: () {
                  controller.init();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
