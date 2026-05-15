import 'dart:convert';
import 'dart:io';
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
  String? userImage;
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
      userImage = PreferencesServer().getString(cUserImage);
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
      _calculatePercentage();
    });
    final updateTask = task.map((e) => e.toMap()).toList();
    await PreferencesServer().setString('tasks', jsonEncode(updateTask));
  }

  deleteTask(int? id) async {
    if (id == null) return;
    setState(() {
      task.removeWhere((element) => element.id == id);
      _calculatePercentage();
    });
    final updateTask = task.map((e) => e.toMap()).toList();
    await PreferencesServer().setString('tasks', jsonEncode(updateTask));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () async {
          var result = await Navigator.pushNamed(
            context,
            NewTaskView.routeName,
          );
          if (result == true) {
            loadTasK();
          }
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
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: (userImage != null)
                            ? FileImage(File(userImage!))
                            : const AssetImage('assets/images/Thumbnail.png'),
                      ),
                      const Gap(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good Evening,$userName',
                            style: Theme.of(context).textTheme.displayMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'One task at a time.One step\n closer.',
                            style: Theme.of(context).textTheme.displayMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Gap(20),
                  Text(
                    '$userName , Your Work is \nalmost Done !',
                    style: Theme.of(context).textTheme.displayLarge,
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
                  Text(
                    'My Tasks',
                    style: Theme.of(context).textTheme.labelLarge,
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
              onDelet: (int? id) {
                deleteTask(id);
              },
              edit: () {
                loadTasK();
              },
            ),
          ],
        ),
      ),
    );
  }
}
