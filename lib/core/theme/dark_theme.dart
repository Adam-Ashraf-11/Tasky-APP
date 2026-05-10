import 'package:flutter/material.dart';
import 'package:tasky_app/core/utils/constant/app_colors.dart';
// تأكد من استيراد ملف الألوان الخاص بك
// import 'path_to_your_colors/app_colors.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  fontFamily: 'Poppins',

  scaffoldBackgroundColor: AppColors.dark,

  //!  AppBar
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.dark,
    elevation: 0,
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
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),

  //! TextField
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[100],
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF16b86d), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red),
    ),
  ),

  // switchTheme: SwitchThemeData(
  //   thumbColor: WidgetStateProperty.all(Colors.white),
  //   trackColor: WidgetStateProperty.resolveWith((states) {
  //     if (states.contains(WidgetState.selected)) return const Color(0xFF16b86d);
  //     return Colors.grey.shade300;
  //   }),
  // ),
);

 //! app color scheme
  // colorScheme: const ColorScheme.light(
  //   onPrimary: Colors.white,
  //   secondary: Color(0xFF16b86d),
  //   surface: Colors.white,
  //   background: Colors.white,
  //   error: Colors.red,
  // ),

  //! Font  
  // textTheme: const TextTheme(
  //   displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
  //   bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
  //   bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
  // ),

