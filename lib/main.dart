import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(const SmartVillageApp());

class SmartVillageApp extends StatelessWidget {
  const SmartVillageApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Village',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
      ),
      home: const HomeScreen(),
    );
  }
}