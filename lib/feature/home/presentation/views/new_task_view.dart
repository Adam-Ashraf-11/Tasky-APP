import 'package:flutter/material.dart';
import 'package:tasky_app/core/widgets/custom_app_bar.dart';
import 'package:tasky_app/feature/home/presentation/views/new_task_view_body.dart';

class NewTaskView extends StatelessWidget {
  const NewTaskView({super.key});
  static const routeName = 'new-task';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'New Task'),
      body: const NewTaskViewBody(),
    );
  }
}
