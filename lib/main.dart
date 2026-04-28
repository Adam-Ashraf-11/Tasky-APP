import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/core/constant/constant.dart';
import 'package:tasky_app/core/helper/ongenerate_route.dart';
import 'package:tasky_app/feature/home/presentation/views/home_view.dart';
import 'package:tasky_app/feature/welcome/presentation/views/welcome_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
  pref.getString(cUserName);
  runApp(const TakyApp(userName: cUserName));
}

class TakyApp extends StatelessWidget {
  const TakyApp({super.key, required this.userName});
  final String? userName;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: userName != null
          ? HomeView.routeName
          : WelcomeView.routeName,
      onGenerateRoute: onGenerateRoutes,
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xff181818),
      ),
      title: 'Tasky ',
      debugShowCheckedModeBanner: false,
    );
  }
}
