import 'package:flutter/material.dart';
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
        icon: const Icon(Icons.add),
        onPressed: onPressed,
        label:  Text(title),
      ),
    );
  }
}