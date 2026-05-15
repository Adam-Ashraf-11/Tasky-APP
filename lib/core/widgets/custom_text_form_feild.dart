import 'package:flutter/material.dart';
import 'package:tasky_app/core/utils/constant/app_colors.dart';

class CustomTextFormFeild extends StatelessWidget {
  const CustomTextFormFeild({
    super.key,
    required this.hint,
    this.controller,
    this.validator,
    this.maxLines = 1,
  });
  final String hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      validator: validator,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 15),
      cursorColor: AppColors.green,
      controller: controller,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: const Color(0xff9E9E9E)),
     
      ),
    );
  }
}
