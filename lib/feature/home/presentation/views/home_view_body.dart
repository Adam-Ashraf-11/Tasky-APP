import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tasky_app/core/services/Preferences_server.dart';
import 'package:tasky_app/core/utils/constant/constant.dart';
import 'package:tasky_app/core/widgets/custom_floating_action_button.dart';
import 'package:tasky_app/core/widgets/custom_sliver_task_list.dart';
import 'package:tasky_app/feature/home/data/models/task_model.dart';
import 'package:tasky_app/feature/home/presentation/views/new_task_view.dart';
import 'package:tasky_app/feature/home/presentation/views/widget/archieved_tasks.dart';
import 'package:tasky_app/feature/home/presentation/views/widget/high_priority_container.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  String? userName;

  List<dynamic> task = [];

  int completedTasks = 0;
  int allTasks = 0;
  int percentage = 0;
  @override
  void initState() {
    addUserName();
    loadTasK();
    super.initState();
  }

  //! add user method
  void addUserName() async {
    setState(() {
      userName = PreferencesServer().getString(cUserName);
    });
  } //usernam

  //! load task method
  void loadTasK() async {
    final getTask = PreferencesServer().getString('tasks');
    if (getTask != null) {
      final taskDeCoded = jsonDecode(getTask);
      setState(() {
        task = taskDeCoded.map((e) => TaskModel.fromJson(e)).toList();
        _calculatePercentage();
      });
    }
  }

  //! calculate percentage
  _calculatePercentage() {
    setState(() {
      allTasks = task.length;
      completedTasks = task.where((element) => element.isDone == true).length;
      percentage = allTasks == 0
          ? 0
          : ((completedTasks / allTasks) * 100).toInt();
    });
  }

  //! done task
  doneTask(bool? v, int index) async {
    setState(() {
      task[index].isDone = v;
    });
    final updateTask = task.map((e) => e.toMap()).toList();
    await PreferencesServer().setString('tasks', jsonEncode(updateTask));
    _calculatePercentage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, NewTaskView.routeName);
          loadTasK();
        },
        title: 'Add New Task',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(200),
                        ),
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
                  const Gap(20),
                  ArchievedTasks(
                    allTasks: allTasks,
                    completedTasks: completedTasks,
                    percentage: percentage,
                  ),
                  const Gap(10),
                  HighPriorityContainer(
                    refrash: () => loadTasK(),
                    tasks: task,
                    onTap: (bool? v, int index) {
                      doneTask(v, index);
                    },
                  ),
                                    const Gap(10),

                  const Text(
                    'My Tasks',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const Gap(10),
                ],
              ),
            ),
            CustomSliverTasksListView(
              tasks: task,
              onTap: (bool? value, int? index) {
                doneTask(value, index!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
