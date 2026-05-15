import 'package:flutter/material.dart';
import 'package:tasky_app/core/widgets/task_item_widget.dart';

class CustomSliverTasksListView extends StatelessWidget {
  const CustomSliverTasksListView({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.onDelet,
    required this.edit,
  });
  final List<dynamic> tasks;
  final Function(bool?, int) onTap;
  final Function(int?) onDelet;
  final Function() edit;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 60),
      sliver: SliverList.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) => TaskItemWidget(
          model: tasks.elementAt(index),
          onTap: (bool? value) {
            onTap(value, index);
          },
          onDelet: (int id) => onDelet(id),
          edit: () {
            edit();
          },
        ),
      ),
    );
  }
}
