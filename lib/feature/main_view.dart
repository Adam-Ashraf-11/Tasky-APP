import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky_app/core/utils/constant/app_colors.dart';
import 'package:tasky_app/feature/tasks/presentation/views/complete_view.dart';
import 'package:tasky_app/feature/home/presentation/views/home_view.dart';
import 'package:tasky_app/feature/profile/presentation/view/profile_view.dart';
import 'package:tasky_app/feature/tasks/presentation/views/todo_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});
  static const routeName = 'main';

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> screens = const [
    HomeView(),
    TodoView(),
    CompleteView(),
    ProfileView(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: _buildSvg('assets/images/home_icon.svg', 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildSvg('assets/images/todo_icon.svg', 1),
            label: 'To Do',
          ),
          BottomNavigationBarItem(
            icon: _buildSvg('assets/images/complete_icon.svg', 2),
            label: 'Complete',
          ),
          BottomNavigationBarItem(
            icon: _buildSvg('assets/images/profile_icon.svg', 3),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(child: screens[currentIndex]),
    );
  }
  SvgPicture _buildSvg(String path, index) {
    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(
        currentIndex == index ? AppColors.green : Colors.grey,
        BlendMode.srcIn,
      ),
    );
  }
}
