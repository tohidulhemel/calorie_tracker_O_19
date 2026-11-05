
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'utils/app_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Calorie Tracker',

      theme: ThemeData(
        useMaterial3: true,
        primaryColor: AppColors.primaryColor,

        scaffoldBackgroundColor: AppColors.backgroundColor,

        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),

        cardTheme: const CardThemeData(
          color: AppColors.cardColor,
          elevation: 2,
          margin: EdgeInsets.zero,
        ),
      ),

      home: const HomeScreen(),
    );
  }
}
