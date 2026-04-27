import 'package:flutter/material.dart';
import 'package:tasky_app/core/helper/ongenerate_route.dart';
import 'package:tasky_app/feature/welcome/presentation/views/welcome_view.dart';

void main() {
  runApp(const TakyApp());
}

class TakyApp extends StatelessWidget {
  const TakyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeView.routeName,
      onGenerateRoute: onGenerateRoutes,
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Color(0xff181818),
      ),
      title: 'Tasky ',
      debugShowCheckedModeBanner: false,
    );
  }
}
