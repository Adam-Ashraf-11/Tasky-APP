import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tasky_app/core/enums/pop_menue_actions_enum.dart';
import 'package:tasky_app/core/services/Preferences_server.dart';
import 'package:tasky_app/core/theme/theme_controller.dart';
import 'package:tasky_app/core/widgets/custom_eleveted_button.dart';
import 'package:tasky_app/core/widgets/custom_text_form_feild.dart';
import 'package:tasky_app/feature/home/data/models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.model,
    required this.onTap,
    required this.onDelet,
    required this.edit,
  });
  final TaskModel model;
  final Function(bool?) onTap;
  final Function(int) onDelet;
  final Function edit;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ThemeController().isLight() ? Colors.grey : Colors.transparent,
        ),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Center(
        child: Row(
          children: [
            const Gap(8),
            Checkbox(
              value: model.isDone ?? false,
              onChanged: (bool? v) => onTap(v),
            ),
            const Gap(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    model.taskName,
                    style: (model.isDone ?? false)
                        ? Theme.of(context).textTheme.labelSmall
                        : Theme.of(context).textTheme.labelMedium,
                  ),
                  if (model.taskDescription!.isNotEmpty)
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      model.taskDescription!,
                      style: (model.isDone ?? false)
                          ? Theme.of(context).textTheme.labelSmall
                          : Theme.of(context).textTheme.labelMedium,
                    ),
                ],
              ),
            ),
            PopupMenuButton<PopMenueActionsEnum>(
              icon: Icon(
                Icons.more_vert,
                color: ThemeController().isDark()
                    ? ((model.isDone ?? true) ? Colors.grey : Colors.white)
                    : ((model.isDone ?? true) ? Colors.grey : Colors.black),
              ),
              onSelected: (value) async {
                switch (value) {
                  case PopMenueActionsEnum.done:
                    onTap(!(model.isDone ?? false));
                  case PopMenueActionsEnum.edit:
                    final result = await _showModalBottomSheet(context, model);
                    if (result == true) {
                      edit();
                    }
                  case PopMenueActionsEnum.delete:
                    await _showAlertDialog(context);
                  // ignore: unrelated_type_equality_checks
                }
              },
              itemBuilder: (context) => [
                ...PopMenueActionsEnum.values.map(
                  (e) => PopupMenuItem<PopMenueActionsEnum>(
                    value: e,
                    child: Text(e.name),
                  ),
                ),
                // const PopupMenuItem(
                //   value: 'edit',
                //   child: Text(
                //     'Edit',
                //   ),
                // ),
                // const PopupMenuItem(
                //   value: 'delete',
                //   child: Text(
                //     'Delete',
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _showAlertDialog(context) {
    return showDialog<String>(
      context: context,
      builder: (c) {
        return AlertDialog(
          title: const Text('Delete Task'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onDelet(model.id);
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showModalBottomSheet(context, TaskModel model) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    TextEditingController taskNameController = TextEditingController(
      text: model.taskName,
    );
    TextEditingController taskDescreptionController = TextEditingController(
      text: model.taskDescription,
    );
    bool isHighPriority = model.isHighPriority;
    return showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (c) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Task Name',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            const Gap(8),
                            CustomTextFormFeild(
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please Enter Task Name';
                                }
                                return null;
                              },
                              hint: 'Enter Task Name',
                              controller: taskNameController,
                            ),
                            const Gap(20),
                            Text(
                              'Task Description',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            const Gap(8),
                            CustomTextFormFeild(
                              hint: 'Enter Task Description',
                              controller: taskDescreptionController,
                              maxLines: 6,
                            ),
                            const Gap(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'High Priority  ',
                                  style: Theme.of(context).textTheme.titleLarge!
                                      .copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Switch(
                                  value: isHighPriority,
                                  onChanged: (bool value) {
                                    setState(() {
                                      isHighPriority = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomElevetedButton(
                      title: 'edit Task',
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final taskJson = PreferencesServer().getString(
                            'tasks',
                          );
                          List<dynamic> listTasks = [];
                          if (taskJson != null) {
                            listTasks = jsonDecode(taskJson);
                          }
                          TaskModel newModel = TaskModel(
                            id: model.id,
                            taskName: taskNameController.text,
                            taskDescription: taskDescreptionController.text,
                            isHighPriority: isHighPriority,
                            isDone: model.isDone,
                          );
                          final item = listTasks.firstWhere(
                            (e) => e['id'] == model.id,
                          );
                          final index = listTasks.indexOf(item);
                          listTasks[index] = newModel.toMap();

                          final taskEncode = jsonEncode(listTasks);
                          await PreferencesServer().setString(
                            'tasks',
                            taskEncode,
                          );
                          Navigator.pop(context, true);
                        }
                      },
                    ),
                    const Gap(40),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
