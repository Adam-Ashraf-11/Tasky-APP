import 'package:flutter/material.dart';
import 'package:tasky_app/core/constant/app_colors.dart';

class CustomElevetedButton extends StatelessWidget {
  const CustomElevetedButton({super.key, this.w, required this.title});
  final double? w;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.green,
        fixedSize: Size(w ?? 343, 40),
      ),

      onPressed: () {},
      child: Text(title , style: const TextStyle(color: Colors.white),),
    );
  }
}
