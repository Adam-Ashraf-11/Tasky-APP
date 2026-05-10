import 'package:flutter/material.dart';
import 'package:tasky_app/core/theme/light_theme.dart';
import 'package:tasky_app/core/utils/constant/app_colors.dart';
import 'package:tasky_app/core/utils/constant/constant.dart';
import 'package:tasky_app/core/helper/ongenerate_route.dart';
import 'package:tasky_app/core/services/Preferences_server.dart';
import 'package:tasky_app/feature/main_view.dart';
import 'package:tasky_app/feature/welcome/presentation/views/welcome_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesServer().init();
  String? savedUserName = PreferencesServer().getString(cUserName);   // final pref = await SharedPreferences.getInstance();
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
      theme: lightTheme,
      title: 'Tasky ',
      debugShowCheckedModeBanner: false,
    );
  }
}
