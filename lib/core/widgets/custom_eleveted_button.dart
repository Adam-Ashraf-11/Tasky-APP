import 'package:flutter/material.dart';

class CustomElevetedButton extends StatelessWidget {
  const CustomElevetedButton({super.key, this.w, required this.title, required this.onPressed});
  final double? w;
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title , style: const TextStyle(color: Colors.white),),
    );
  }
}
