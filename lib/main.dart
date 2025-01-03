import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_experiment/config/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'features/home/screens/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Soad's Portfolio",
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
