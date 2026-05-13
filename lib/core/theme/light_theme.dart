import 'package:flutter/material.dart';
import 'package:tasky_app/core/theme/theme_controller.dart';
import 'package:tasky_app/core/utils/constant/app_colors.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Poppins',
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.light,
  colorScheme: const ColorScheme.light(primaryContainer: Colors.white),

  iconTheme: const IconThemeData(color: Colors.black),
  //!  AppBar
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    foregroundColor: Colors.black,
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Colors.black,
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

  //! TextField
  inputDecorationTheme: InputDecorationTheme(
       filled: true,
    fillColor: Colors.white,
    
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.grey),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Color(0xFF16b86d), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.red),
    ),
  ),

  //! Text Theme
  textTheme: const TextTheme(
    //?  Small....
    titleSmall: TextStyle(
      fontSize: 10,
      color: Colors.black,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      fontSize: 11,
      color: Colors.black,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontSize: 8,
      color: Colors.black,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      decoration: TextDecoration.lineThrough,
      decorationColor: Color.fromARGB(255, 59, 55, 55),
      decorationThickness: 5,
      fontSize: 12,
      color: Colors.black,
      fontWeight: FontWeight.w400,
    ),
    //?  medium
    displayMedium: TextStyle(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      fontSize: 14,
      color: Colors.black,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      color: Colors.black,
      fontWeight: FontWeight.w400,
    ),
    //?  large
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      fontSize: 28,
      color: Colors.black,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      fontSize: 24,
      color: Colors.black,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.w400,
    ),
  ),
  //! Switch Theme
  switchTheme: SwitchThemeData(
    trackOutlineColor: WidgetStateProperty.all(Colors.grey) ,
    thumbColor: WidgetStateProperty.all(Colors.grey),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return const Color(0xFF16b86d);
      return Colors.grey.shade300;
    }),
  ),

  //! Checkbox Theme
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

  //! FloatingActionButton Theme
  floatingActionButtonTheme: const FloatingActionButtonThemeData(

    backgroundColor: Color(0xFF16b86d),
    foregroundColor: Colors.white,
    extendedTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  ),

bottomNavigationBarTheme: const BottomNavigationBarThemeData(
  backgroundColor: AppColors.light,
  type: BottomNavigationBarType.fixed,
  selectedItemColor: AppColors.green,
  unselectedItemColor: Colors.black,
 
),
splashFactory: NoSplash.splashFactory,
primaryIconTheme: const IconThemeData(
  color: Colors.black
)
);

 
 //* app color scheme
  // colorScheme: const ColorScheme.light(
  //   onPrimary: Colors.white,
  //   secondary: Color(0xFF16b86d),
  //   surface: Colors.white,
  //   background: Colors.white,
  //   error: Colors.red,
  // ),


