import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/core/constant/constant.dart';
import 'package:tasky_app/core/helper/ongenerate_route.dart';
import 'package:tasky_app/feature/home/presentation/views/main_view.dart';
import 'package:tasky_app/feature/welcome/presentation/views/welcome_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
 String? savedUserName = pref.getString(cUserName);
  runApp( TakyApp(userName: savedUserName));
}

class TakyApp extends StatelessWidget {
  const TakyApp({super.key, required this.userName});
  final String? userName;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: userName == null
          ?WelcomeView.routeName
          :MainView.routeName,
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
