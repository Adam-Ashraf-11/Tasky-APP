import 'package:flutter/material.dart';
import 'package:tasky_app/core/widgets/custom_floating_action_button.dart';
import 'package:tasky_app/feature/home/presentation/views/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const routeName = 'homeView';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      floatingActionButton: CustomFloatingActionButton(),
      body: SafeArea(child: HomeViewBody()),
    );
  }
}