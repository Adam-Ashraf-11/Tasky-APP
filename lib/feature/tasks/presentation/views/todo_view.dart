import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/widgets/custom_app_bar.dart';
import 'package:tasky_app/core/widgets/custom_tasks_list_view.dart';
import 'package:tasky_app/feature/tasks/presentation/manager/tasks_controller.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});
  static const routeName = 'todo';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TasksController>(
      create: (_) => TasksController()..init(),
      builder: (context, _) {
        final controller = context.watch<TasksController>();
        return Scaffold(
          appBar: customAppBar(title: 'To Do Tasks'),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Consumer<TasksController>(
                builder: (context, value, _) {
                  return CustomTasksListView(
                    tasks: value.todoTasks,
                    onTap: (bool? v, int index) {
                      controller.doneTask(v!, index);
                    },
                    onDelet: (int? id) {
                      controller.deleteTask(id);
                    },
                    edit: () {
                      controller.loadTasK();
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
