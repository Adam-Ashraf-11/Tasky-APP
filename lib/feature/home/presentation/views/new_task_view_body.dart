import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/core/constant/app_colors.dart';
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
                    const Text(
                      'Task Name',
                      style: TextStyle(color: Colors.white, fontSize: 16),
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
                    const Text(
                      'Task Description',
                      style: TextStyle(color: Colors.white, fontSize: 16),
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
                        const Text(
                          'High Priority  ',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Switch(
                          inactiveTrackColor: Colors.grey,
                          activeTrackColor: AppColors.green,
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
              w: MediaQuery.sizeOf(context).width,
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  final TaskModel taskModel = TaskModel(
                    taskName: taskNameController.text,
                    taskDescription: taskDescreptionController.text,
                    isHighPriority: isHighPriority,
                  );
                  final pref = await SharedPreferences.getInstance();
                  final taskJson = pref.getString('tasks');
                   List<dynamic> listTasks = [];
                  if (taskJson != null) {
                    listTasks = jsonDecode(taskJson);
                  }
                  listTasks.add(taskModel.toMap()); // listTasks.add(task);
                  final taskEncode = jsonEncode(listTasks);
                  await pref.setString('tasks', taskEncode);
                  Navigator.pop(context , true);
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
