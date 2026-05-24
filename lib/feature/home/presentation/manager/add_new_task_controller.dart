import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky_app/core/services/Preferences_server.dart';
import 'package:tasky_app/core/utils/constant/constant.dart';
import 'package:tasky_app/feature/home/data/models/task_model.dart';

class AddNewTaskController with ChangeNotifier {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescreptionController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isHighPriority = true;


  void addNewTask(BuildContext context) async {
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
    notifyListeners();
  }

  void toogle(bool value) {
    isHighPriority = value;
    notifyListeners();
  }
}
