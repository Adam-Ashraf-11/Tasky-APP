import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tasky_app/core/services/Preferences_server.dart';
import 'package:tasky_app/core/utils/constant/constant.dart';
import 'package:tasky_app/feature/home/data/models/task_model.dart';

class TasksController with ChangeNotifier {
  List<dynamic> tasks = [];
  List<dynamic> todoTasks = [];
  List<dynamic> compeletetasks = [];
  List<dynamic> highPriorityTasks = [];

  init() {
    loadTasK();
  }

  //! load task method
  void loadTasK() async {
    final getTask = PreferencesServer().getString(cTasks);
    if (getTask != null) {
      final taskDeCoded = jsonDecode(getTask);
      tasks = taskDeCoded.map((e) => TaskModel.fromJson(e)).toList();
      todoTasks = tasks.where((element) => !element.isDone).toList();
      compeletetasks = tasks.where((element) => element.isDone).toList();
      highPriorityTasks = tasks.reversed
          .where((element) => element.isHighPriority)
          .toList();
      notifyListeners();
    }
  }

  void doneTodoTask(bool v, int index) async {
    todoTasks[index].isDone = v;
    final indexWhere = tasks.indexWhere((e) => e.id == todoTasks[index].id);
    tasks[indexWhere] = todoTasks[index];

    await PreferencesServer().setString(
      cTasks,
      jsonEncode(tasks.map((e) => e.toMap()).toList()),
    );
    loadTasK();
    // }
  }

  void doneCompeleteTask(bool v, int index) async {
    compeletetasks[index].isDone = v;
    final indexWhere = tasks.indexWhere(
      (e) => e.id == compeletetasks[index].id,
    );
    tasks[indexWhere] = compeletetasks[index];
    await PreferencesServer().setString(
      cTasks,
      jsonEncode(tasks.map((e) => e.toMap()).toList()),
    );
    loadTasK();
  }

  void doneHighPriorityTask(bool v, int id) async {
    final indexWhere = tasks.indexWhere(
      (e) => e.id == id,
    );
    if (indexWhere != -1) {
      tasks[indexWhere].isDone= v;
      await PreferencesServer().setString(
        cTasks,
        jsonEncode(tasks.map((e) => e.toMap()).toList()),
      );
      loadTasK();
    }
  }

  deleteTask(int? id) async {
    if (id == null) return;
    tasks.removeWhere((element) => element.id == id);
    todoTasks.removeWhere((element) => element.id == id);
    compeletetasks.removeWhere((element) => element.id == id);
    highPriorityTasks.removeWhere((element) => element.id == id);
    final updateTask = tasks.map((e) => e.toMap()).toList();
    PreferencesServer().setString(cTasks, jsonEncode(updateTask));
    notifyListeners();
  }
}
