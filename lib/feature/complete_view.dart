import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/core/widgets/custom_app_bar.dart';
import 'package:tasky_app/core/widgets/custom_tasks_list_view.dart';
import 'package:tasky_app/feature/home/data/models/task_model.dart';

class CompleteView extends StatefulWidget {
  const CompleteView({super.key});

  @override
  State<CompleteView> createState() => _CompleteViewState();
}

class _CompleteViewState extends State<CompleteView> {
  List<dynamic> compeletetasks = [];
  @override
  void initState() {
    loadTasK();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: ' Completed Tasks'),
      body: SafeArea(
        child: CustomTasksListView(
          tasks: compeletetasks,
          onTap: (bool? v, int index) async {
             setState(() {
                compeletetasks[index].isDone = v;
              });
              final pref = await SharedPreferences.getInstance();
              final updateTask = compeletetasks.map((e) => e.toMap()).toList();

              final allData = pref.getString('tasks');
              if (allData != null) {
                List<dynamic> allDataList = (jsonDecode(allData) as List).map((
                  e,
                ) {
                  return TaskModel.fromJson(e);
                }).toList();
                final newIndex = allDataList.indexWhere(
                  (e) => e.id == compeletetasks[index].id,
                );
                allDataList[newIndex] = compeletetasks[index];
                await pref.setString(
                  'tasks',
                  jsonEncode(allDataList.map((e) => e.toMap()).toList()),
                  
                );
             loadTasK();
              }
          }
        ),
      ),
    );
  }

  //! load task method
  void loadTasK() async {
    final pref = await SharedPreferences.getInstance();
    final getTask = pref.getString('tasks');
    if (getTask != null) {
      final taskDeCoded = jsonDecode(getTask);
      setState(() {
        compeletetasks = taskDeCoded
            .map((e) => TaskModel.fromJson(e))
            .where((element) => element.isDone == true)
            .toList();
      });
    }
  }
}
