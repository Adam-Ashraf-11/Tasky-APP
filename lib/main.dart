import 'package:flutter/material.dart';
import 'package:tasky_app/feature/welcome/presentation/views/welcome_view.dart';

void main() {
  runApp(const TakyApp());
}

class TakyApp extends StatelessWidget {
  const TakyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      title: 'Tasky ',
      debugShowCheckedModeBanner: false,
      home: const WelcomeView(),
    );
  }
}
