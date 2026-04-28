import 'package:flutter/material.dart';
import 'package:tasky_app/feature/home/presentation/views/home_view.dart';
import 'package:tasky_app/feature/home/presentation/views/new_task_view.dart';
import 'package:tasky_app/feature/welcome/presentation/views/welcome_view.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case WelcomeView.routeName:
      return MaterialPageRoute(builder: (_) => const WelcomeView());
      case HomeView.routeName:
      return MaterialPageRoute(builder: (_) => const HomeView());
      case NewTaskView.routeName:
      return MaterialPageRoute(builder: (_) => const NewTaskView());
    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}
