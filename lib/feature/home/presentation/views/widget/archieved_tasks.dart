import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tasky_app/core/constant/app_colors.dart';

class ArchievedTasks extends StatelessWidget {
  const ArchievedTasks({
    super.key,
    required this.allTasks,
    required this.completedTasks,
    required this.percentage,
  });
  final int allTasks;
  final int completedTasks;
  final int percentage;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xff282828),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const Text(
                'Achieved Tasks',
                style: TextStyle(color: Colors.white),
              ),
              const Gap(4),
              Text(
                '$completedTasks Out of $allTasks Done',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 48,
                height: 48,
                child: Transform.rotate(
                  angle: percentage * pi / 100,
                  child: CircularProgressIndicator(
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.green,
                    ),
                    value: percentage / 100, // دائرة كاملة
                    strokeWidth: 6,
                    backgroundColor: Colors.grey,
                  ),
                ),
              ),
              Text(
                '$percentage%',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
