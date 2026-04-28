import 'package:flutter/material.dart';
import 'package:tasky_app/core/constant/app_colors.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 40,
      child: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        backgroundColor: AppColors.green,
        foregroundColor: Colors.white,
        icon: Icon(Icons.add),
        onPressed: null,
        label: Text('Add New Task'),
      ),
    );
  }
}