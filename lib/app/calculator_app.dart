import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../widgets/calculator_screen.dart';

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advanced Calculator',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const CalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}