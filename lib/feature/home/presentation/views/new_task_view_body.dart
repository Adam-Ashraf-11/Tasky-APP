import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tasky_app/core/services/Preferences_server.dart';
import 'package:tasky_app/core/utils/constant/constant.dart';
import 'package:tasky_app/core/widgets/custom_eleveted_button.dart';
import 'package:tasky_app/core/widgets/custom_text_form_feild.dart';
import 'package:tasky_app/feature/home/data/models/task_model.dart';

class NewTaskViewBody extends StatefulWidget {
  const NewTaskViewBody({super.key});

  @override
  State<NewTaskViewBody> createState() => _NewTaskViewBodyState();
}

class _NewTaskViewBodyState extends State<NewTaskViewBody> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescreptionController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isHighPriority = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
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
              title: 'Add Task',
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  final taskJson = PreferencesServer().getString(cTasks);
                  List<dynamic> listTasks = [];
                  if (taskJson != null) {
                    listTasks = jsonDecode(taskJson);
                  }
                  TaskModel taskModel = TaskModel(
                    id: listTasks.length + 1,
                    taskName: taskNameController.text,
                    taskDescription: taskDescreptionController.text,
                    isHighPriority: isHighPriority,
                    isDone: false,
                  );

                  listTasks.add(taskModel.toMap()); // listTasks.add(task);
                  final taskEncode = jsonEncode(listTasks);
                  await PreferencesServer().setString(cTasks, taskEncode);
                  Navigator.pop(context, true);
                }
              },
            ),
            const Gap(40),
          ],
        ),
      ),
    );
  }
}
