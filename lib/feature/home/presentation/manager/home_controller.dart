import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky_app/core/services/Preferences_server.dart';
import 'package:tasky_app/core/utils/constant/constant.dart';
import 'package:tasky_app/feature/home/data/models/task_model.dart';

class HomeController with ChangeNotifier {
  String? userName;

  List<dynamic> task = [];
  String? userImage;
  int completedTasks = 0;
  int allTasks = 0;
  int percentage = 0;

 

  init() {
    addUserData();
    loadTasK();
  }

  //! add user method
  void addUserData() async {
    userName = PreferencesServer().getString(cUserName);
    userImage = PreferencesServer().getString(cUserImage);

    notifyListeners();
  } //usernam

  //! load task method
  void loadTasK() async {
    final getTask = PreferencesServer().getString('tasks');
    if (getTask != null) {
      final taskDeCoded = jsonDecode(getTask);

      task = taskDeCoded.map((e) => TaskModel.fromJson(e)).toList();
      calculatePercentage();
    }
  }

  //! calculate percentage
  calculatePercentage() {
    allTasks = task.length;
    completedTasks = task.where((element) => element.isDone == true).length;
    percentage = allTasks == 0
        ? 0
        : ((completedTasks / allTasks) * 100).toInt();
    notifyListeners();
  }

  //! done task
  doneTask(bool? v, int index) async {
    task[index].isDone = v;
    calculatePercentage();
    final updateTask = task.map((e) => e.toMap()).toList();
    await PreferencesServer().setString('tasks', jsonEncode(updateTask));
    notifyListeners();
  }

  // ! delete task
  deleteTask(int? id) async {
    if (id == null) return;

    task.removeWhere((element) => element.id == id);
    calculatePercentage();
    final updateTask = task.map((e) => e.toMap()).toList();
    await PreferencesServer().setString('tasks', jsonEncode(updateTask));
    notifyListeners();
  }
}
