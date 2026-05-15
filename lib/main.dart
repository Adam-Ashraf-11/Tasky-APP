import 'package:flutter/material.dart';
import 'package:tasky_app/core/theme/dark_theme.dart';
import 'package:tasky_app/core/theme/light_theme.dart';
import 'package:tasky_app/core/theme/theme_controller.dart';
import 'package:tasky_app/core/utils/constant/constant.dart';
import 'package:tasky_app/core/helper/ongenerate_route.dart';
import 'package:tasky_app/core/services/Preferences_server.dart';
import 'package:tasky_app/feature/main_view.dart';
import 'package:tasky_app/feature/welcome/presentation/views/welcome_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesServer().init();
  String? savedUserName = PreferencesServer().getString(cUserName);

  ThemeController().init();

  runApp(TakyApp(userName: savedUserName));
}

class TakyApp extends StatelessWidget {
  const TakyApp({super.key, required this.userName});
  final String? userName;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeNotifier,
      builder: (context, value, Widget? child) {
        return MaterialApp(
          initialRoute: userName == null
              ? WelcomeView.routeName
              : MainView.routeName,
          onGenerateRoute: onGenerateRoutes,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: value,
          title: 'Tasky ',
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

//popup menu

