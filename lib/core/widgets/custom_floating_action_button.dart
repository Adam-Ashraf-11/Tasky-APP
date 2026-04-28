import 'package:flutter/material.dart';
import 'package:tasky_app/core/constant/app_colors.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key, required this.onPressed, required this.title,
  });
  
  final VoidCallback onPressed;
  final String title ;
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 40,
      child: FloatingActionButton.extended(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        backgroundColor: AppColors.green,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        onPressed: onPressed,
        label:  Text(title),
      ),
    );
  }
}