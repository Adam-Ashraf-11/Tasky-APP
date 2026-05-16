import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tasky_app/core/services/Preferences_server.dart';
import 'package:tasky_app/core/widgets/custom_app_bar.dart';
import 'package:tasky_app/core/widgets/custom_tasks_list_view.dart';
import 'package:tasky_app/feature/home/data/models/task_model.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});
  static const routeName = 'todo';
  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  List<dynamic> todoTasks = [];
  @override
  void initState() {
    super.initState();
    loadTasK();
  }

  //! load task method
  void loadTasK() async {
    final getTask = PreferencesServer().getString('tasks');
    if (getTask != null) {
      final taskDeCoded = jsonDecode(getTask);
      setState(() {
        todoTasks = taskDeCoded
            .map((e) => TaskModel.fromJson(e))
            .where((element) => element.isDone == false)
            .toList();
      });
    }
  }

   deleteTask(int? id) async {
    List<dynamic> tasks = [];
    final getTask = PreferencesServer().getString('tasks');
    if (getTask != null) {
      final taskDeCoded = jsonDecode(getTask) as List<dynamic>;
      tasks = taskDeCoded.map((e) => TaskModel.fromJson(e)).toList();
      tasks.removeWhere((element) => element.id == id);
      if (id == null) return;
      setState(() {
        todoTasks.removeWhere((element) => element.id == id);
      });
      final updateTask = tasks.map((e) => e.toMap()).toList();
       PreferencesServer().setString('tasks', jsonEncode(updateTask));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'To Do Tasks'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: CustomTasksListView(
            tasks: todoTasks,
            onTap: (bool? v, int index) async {
              setState(() {
                todoTasks[index].isDone = v ?? false;
              });
              final allData = PreferencesServer().getString('tasks');
              if (allData != null) {
                List<dynamic> allDataList = (jsonDecode(allData) as List).map((
                  e,
                ) {
                  return TaskModel.fromJson(e);
                }).toList();
                final targetId = todoTasks[index].id;
                final dbIndex = allDataList.indexWhere((e) => e.id == targetId);
                if (dbIndex != -1) {
                  allDataList[dbIndex].isDone = v ?? false;
                  await PreferencesServer().setString(
                    'tasks',
                    jsonEncode(allDataList.map((e) => e.toMap()).toList()),
                  );
                }
                loadTasK();
                // final newIndex = allDataList.indexWhere(
                //   (e) => e.id == todoTasks[index].id,
                // );
                // allDataList[newIndex] = todoTasks[index];
                // await PreferencesServer().setString(
                //   'tasks',
                //   jsonEncode(allDataList.map((e) => e.toMap()).toList()),
                // );
                // loadTasK();
              }
            },
            onDelet: (int? id) => deleteTask(id), edit: (){
              loadTasK();
            },
          ),
        ),
      ),
    );
  }
}
