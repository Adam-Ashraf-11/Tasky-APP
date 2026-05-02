import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/core/constant/app_colors.dart';
import 'package:tasky_app/core/constant/constant.dart';
import 'package:tasky_app/core/widgets/custom_floating_action_button.dart';
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
              Expanded(
                child: ListView.builder(
                  padding:const EdgeInsets.only(bottom: 60),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Container(
                    height: 56,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xff282828),
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          const Gap(8),
                          Checkbox(
                            checkColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            activeColor: AppColors.green,
                            value: task[index].isDone ?? false,
                            onChanged: (v) async {
                              log(v.toString());
                              setState(() {
                                task[index].isDone = v;
                              });
                              final pref = await SharedPreferences.getInstance();
                              final updateTask = task
                                  .map((e) => e.toMap())
                                  .toList();
                              await pref.setString('tasks', jsonEncode(updateTask));
                            },
                          ),
                          const Gap(8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  task[index].taskName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    decoration: (task[index].isDone ?? false)
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    decorationColor: Colors.red,
                                    decorationThickness: 5,
                                  ),
                                ),
                                if (task[index].taskDescription.isNotEmpty)
                                Text(
                                  task[index].taskDescription ,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
          
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.more_vert,
                              color: (task[index].isDone ?? true)
                                  ? Colors.grey
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  itemCount: task.length,
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
