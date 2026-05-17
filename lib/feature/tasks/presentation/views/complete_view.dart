import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/widgets/custom_app_bar.dart';
import 'package:tasky_app/core/widgets/custom_tasks_list_view.dart';
import 'package:tasky_app/feature/tasks/presentation/manager/tasks_controller.dart';

class CompleteView extends StatelessWidget {
  const CompleteView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TasksController()..init(),
      builder: (context, _) {
        final controller = context.read<TasksController>();
        return Scaffold(
          appBar: customAppBar(title: ' Completed Tasks'),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Consumer
                <TasksController>(
              builder: (context, value, _) {
                return CustomTasksListView(
                  tasks: value.compeletetasks,
                  onTap: (bool? v, int index)  {
                    controller.doneCompeleteTask(v!, index);
                  },
                  onDelet: (int? id) {
                    controller.deleteTask(id);
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