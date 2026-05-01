import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/core/constant/constant.dart';
import 'package:tasky_app/feature/home/data/models/task_model.dart';

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
    _loadTasK();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
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
              itemBuilder: (context, index) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Center(child: Text(task[index].taskName)),
              ),
              itemCount: task.length,
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
  void _loadTasK() async {
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
