import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const BarHeroApp());
}

class BarHeroApp extends StatelessWidget {
  const BarHeroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BarHero',
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey[900],

        appBarTheme: AppBarTheme(
          backgroundColor: Colors.red[900],
          elevation: 2,
        ),

        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFF333333),
          labelStyle: TextStyle(color: Colors.white70),
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide.none,
          ),
        ),

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}
