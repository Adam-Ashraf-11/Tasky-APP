import 'package:flutter/material.dart';
import 'package:tasky_app/core/constant/app_colors.dart';

class CustomTextFormFeild extends StatelessWidget {
  const CustomTextFormFeild({super.key, required this.hint, this.controller, this.validator});
  final String hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator:validator ,
      controller:controller ,
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
