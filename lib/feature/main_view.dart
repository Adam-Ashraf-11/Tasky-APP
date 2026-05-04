import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky_app/core/constant/app_colors.dart';
import 'package:tasky_app/feature/complete_view.dart';
import 'package:tasky_app/feature/home/presentation/views/home_view.dart';
import 'package:tasky_app/feature/profile_view.dart';
import 'package:tasky_app/feature/todo_view.dart';

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
        backgroundColor: const Color(0xff181818),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.green,
        unselectedItemColor: Colors.grey,

        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/home_icon.svg',
              colorFilter: ColorFilter.mode(
                currentIndex == 0 ? AppColors.green : Colors.white,
                BlendMode.srcIn,
              ),
            ),

            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/todo_icon.svg',

              colorFilter: ColorFilter.mode(
                currentIndex == 1 ? AppColors.green : Colors.white,
                BlendMode.srcIn,
              ),
            ),
            label: 'To Do',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/complete_icon.svg',
              colorFilter: ColorFilter.mode(
                currentIndex == 2 ? AppColors.green : Colors.white,
                BlendMode.srcIn,
              ),
            ),
            label: 'Complete',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/profile_icon.svg',
              colorFilter: ColorFilter.mode(
                currentIndex == 3 ? AppColors.green : Colors.white,
                BlendMode.srcIn,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: screens[currentIndex],
    );
  }
}
