import 'package:flutter/material.dart';
import 'package:tasky_app/core/widgets/task_item_widget.dart';

class CustomTasksListView extends StatelessWidget {
  const CustomTasksListView({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.onDelet,
    required this.edit,
  });

  final List<dynamic> tasks;
  final Function(bool?, int) onTap;
  final Function(int) onDelet;
  final Function edit;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 60),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => TaskItemWidget(
        model: tasks.elementAt(index),
        onTap: (bool? v) {
          onTap(v, index);
        },
        onDelet: (int id) => onDelet(id),
        edit: () {
          edit();
        },
      ),
      itemCount: tasks.length,
    );
  }
}
