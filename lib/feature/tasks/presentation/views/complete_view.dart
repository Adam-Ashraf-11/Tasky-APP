import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tasky_app/core/services/Preferences_server.dart';
import 'package:tasky_app/core/utils/constant/constant.dart';
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

  deleteTask(int? id) async {
    List<dynamic> ctasks = [];
       final getTask = PreferencesServer().getString(cTasks);
    if (getTask != null) {
      
      final taskDeCoded  = jsonDecode(getTask)as List<dynamic>;
      ctasks = taskDeCoded.map((e) => TaskModel.fromJson(e)).toList();
      ctasks.removeWhere((element) => element.id == id);
       
    if (id == null) return;
          setState(() {
        compeletetasks.removeWhere((element) => element.id == id);
      });
      final updateTask = ctasks.map((e) => e.toMap()).toList();
      await PreferencesServer().setString(cTasks, jsonEncode(updateTask));
      
     }
  }

 


 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: ' Completed Tasks'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: CustomTasksListView(
          tasks: compeletetasks,
          onTap: (bool? v, int index) async {
            setState(() {
              compeletetasks[index].isDone = v;
            });
            final allData = PreferencesServer().getString(cTasks);
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
              await PreferencesServer().setString(
                cTasks,
                jsonEncode(allDataList.map((e) => e.toMap()).toList()),
              );
              loadTasK();
            }
          }, onDelet: (int? id) => deleteTask(id), edit: (){
            loadTasK();
          },
        
        ),
      ),
    );
  }

  //! load task method
  void loadTasK() async {
    final getTask = PreferencesServer().getString(cTasks);
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
