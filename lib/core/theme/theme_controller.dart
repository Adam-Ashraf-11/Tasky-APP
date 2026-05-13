import 'package:flutter/material.dart';
import 'package:tasky_app/core/services/Preferences_server.dart';
import 'package:tasky_app/core/utils/constant/constant.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.dark,
  );

  init() {
    bool savedTheme = PreferencesServer().getBool(cTheme) ?? true;
    //! بدل if
    themeNotifier.value = savedTheme ? ThemeMode.dark : ThemeMode.light;

    //!
    //  if (savedTheme == true) {
    //    themeNotifier.value = ThemeMode.dark;
    //  } else {
    //    themeNotifier.value = ThemeMode.light;
    //  }
  }

 static toggleTheme() async{
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
    await  PreferencesServer().setBool(cTheme, false);
    } else {
      themeNotifier.value = ThemeMode.dark;
    await  PreferencesServer().setBool(cTheme, true);
    }
  }

  isLight() => themeNotifier.value == ThemeMode.light;
  isDark() => themeNotifier.value == ThemeMode.dark;

}
