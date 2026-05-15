import 'package:flutter/material.dart';
import 'package:tasky_app/core/theme/theme_controller.dart';
import 'package:tasky_app/core/utils/constant/app_colors.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Poppins',
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.dark,
  colorScheme: const ColorScheme.dark(primaryContainer: Color(0xFF282828)),
  //!  AppBar
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    foregroundColor: Colors.white,
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  //! ElevatedButton
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.green,
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      fixedSize: const Size(double.infinity, 40),
    ),
  ),
  //! TextButton Theme
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: Colors.white),
  ),
  //! TextField
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF282828),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Color(0xFF16b86d), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.red),
    ),
  ),
  //! checkbox Theme
  checkboxTheme: CheckboxThemeData(
    checkColor: WidgetStateProperty.all(Colors.white),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return AppColors.green;
      return null;
    }),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    side: WidgetStateBorderSide.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const BorderSide(color: Colors.transparent, width: 2);
      }
      return BorderSide(
        width: 2,
        color: ThemeController().isDark()
            ? const Color(0xff7f7f7f)
            : const Color(0xffd1dad7),
      );
    }),
  ),
  //! Text Theme
  textTheme: const TextTheme(
    //? display....
    displayMedium: TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    displaySmall: TextStyle(
      fontSize: 11,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),

    //? title....
    titleSmall: TextStyle(
      fontSize: 10,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      fontSize: 24,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
    //? body....
    bodySmall: TextStyle(
      fontSize: 8,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
    bodyLarge: TextStyle(
      fontSize: 28,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),

    //? label....
    labelSmall: TextStyle(
      decoration: TextDecoration.lineThrough,
      decorationColor: Color.fromARGB(255, 255, 0, 0),
      decorationThickness: 5,
      fontSize: 12,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: TextStyle(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
  ),
  //! Switch Theme
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return Colors.white;
      return Colors.grey;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return const Color(0xFF16b86d);
      return Colors.grey.shade300;
    }),
  ),
  //! FloatingActionButton Theme
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF16b86d),
    foregroundColor: Colors.white,
    extendedTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  ),
  primaryIconTheme: const IconThemeData(color: Colors.white),
  //! Bottom Navigation Bar Theme
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.dark,
    type: BottomNavigationBarType.fixed,
  ),
  //! Splash Factory Theme
  splashFactory: NoSplash.splashFactory,
  //! popupMenu Theme
  popupMenuTheme: PopupMenuThemeData(
    color: const Color(0xFF181818),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      side: BorderSide(color: AppColors.green, width: 1),
    ),
    elevation: 10,
    labelTextStyle: WidgetStateProperty.all(
      const TextStyle(color: Colors.white, fontSize: 14),
    ),
  ),
);
