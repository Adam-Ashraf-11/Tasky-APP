import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky_app/core/services/Preferences_server.dart';
import 'package:tasky_app/core/widgets/custom_app_bar.dart';
import 'package:tasky_app/core/widgets/custom_tasks_list_view.dart';
import 'package:tasky_app/feature/home/data/models/task_model.dart';

class HighPriorityView extends StatefulWidget {
  const HighPriorityView({super.key});

  static const routeName = 'high-priority';

  @override
  State<HighPriorityView> createState() => _HighPriorityViewState();
}

class _HighPriorityViewState extends State<HighPriorityView> {
  List<dynamic> task = [];

  @override
  initState() {
    loadTasK();
    super.initState();
  }

  void loadTasK() async {
    final getTask = PreferencesServer().getString('tasks');
    if (getTask != null) {
      final List<dynamic> taskDeCoded = jsonDecode(getTask);
      setState(() {
        task = taskDeCoded.reversed
            .map((e) => TaskModel.fromJson(e))
            .toList()
            .where((element) => element.isHighPriority == true)
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: customAppBar(title: 'High Priority Tasks'),
    
    body:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: CustomTasksListView(
            tasks: task,
            onTap: (bool? v, int index) async {
              setState(() {
                task[index].isDone = v;
              });
              final updateTask = task.map((e) => e.toMap()).toList();
              final allData = PreferencesServer().getString('tasks');
              if (allData != null) {
                List<dynamic> allDataList = (jsonDecode(allData) as List).map((
                  e,
                ){
                 return TaskModel.fromJson(e);
                }).toList();
                final newIndex = allDataList.indexWhere(
                  (e) => e.id == task[index].id,
                );
                allDataList[newIndex] = task[index];
                await PreferencesServer().setString(
                  'tasks',
                  jsonEncode(allDataList.map((e) => e.toMap()).toList()), 
                );
             loadTasK();
              }
            },
          ),
        ),
    );
  }
}
