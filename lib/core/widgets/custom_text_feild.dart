import 'package:flutter/material.dart';
import 'package:tasky_app/core/constant/app_colors.dart';

class CustomTextFeild extends StatelessWidget {
  const CustomTextFeild({super.key, required this.hint});
  final String hint;
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      cursorColor: AppColors.green,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: const Color(0xff282828),
        border: OutlineInputBorder(
          borderSide:  BorderSide.none,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
