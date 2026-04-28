import 'package:flutter/material.dart';
import 'package:tasky_app/core/widgets/custom_floating_action_button.dart';
import 'package:tasky_app/feature/home/presentation/views/home_view_body.dart';
import 'package:tasky_app/feature/home/presentation/views/new_task_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const routeName = 'homeView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NewTaskView.routeName);
        }, title: 'Add New Task',
      ),
      body: const SafeArea(child: HomeViewBody()),
    );
  }
}
