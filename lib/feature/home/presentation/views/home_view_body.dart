import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/core/constant/constant.dart';
import 'package:tasky_app/core/widgets/custom_floating_action_button.dart';
import 'package:tasky_app/core/widgets/custom_tasks_list_view.dart';
import 'package:tasky_app/feature/home/data/models/task_model.dart';
import 'package:tasky_app/feature/home/presentation/views/new_task_view.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  String? userName;

  List<dynamic> task = [];
  @override
  void initState() {
    addUserName();
    loadTasK();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(200)),
                    child: Image.asset(
                      'assets/images/Thumbnail.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                  const Gap(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Evening,$userName',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'One task at a time.One step\n closer.',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(20),
              Text(
                '$userName , Your Work is \nalmost Done !',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: CustomTasksListView(
                  tasks: task,
                  onTap: (bool? value, int? index) async {
                    setState(() {
                      task[index!].isDone = value;
                    });
                    final pref = await SharedPreferences.getInstance();
                    final updateTask = task.map((e) => e.toMap()).toList();
                    await pref.setString('tasks', jsonEncode(updateTask));
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            right: 0,
            child: CustomFloatingActionButton(
              onPressed: () async {
                await Navigator.pushNamed(context, NewTaskView.routeName);
                loadTasK();
              },
              title: 'Add New Task',
            ),
          ),
        ],
      ),
    );
  }
  //! add user method
  void addUserName() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      userName = pref.getString(cUserName);
    });
  } //usernam

  //! load task method
  void loadTasK() async {
    final pref = await SharedPreferences.getInstance();
    final getTask = pref.getString('tasks');
    if (getTask != null) {
      final taskDeCoded = jsonDecode(getTask);
      setState(() {
        task = taskDeCoded.map((e) => TaskModel.fromJson(e)).toList();
      });
    }
  }
}
