import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    loadTasK();
    super.initState();
  }
  //! load task method
  void loadTasK() async {
    final pref = await SharedPreferences.getInstance();
    final getTask = pref.getString('tasks');
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
                todoTasks[index].isDone = v;
              });
              final pref = await SharedPreferences.getInstance();
              final updateTask = todoTasks.map((e) => e.toMap()).toList();
              final allData = pref.getString('tasks');
              if (allData != null) {
                List<dynamic> allDataList = (jsonDecode(allData) as List).map((
                  e,
                ){
                 return TaskModel.fromJson(e);
                }).toList();
                final newIndex = allDataList.indexWhere(
                  (e) => e.id == todoTasks[index].id,
                );
                allDataList[newIndex] = todoTasks[index];
                await pref.setString(
                  'tasks',
                  jsonEncode(allDataList.map((e) => e.toMap()).toList()), 
                );
             loadTasK();
              }
            },
          ),
        ),
      ),
    );
  }

}
