import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const YogaApp());
}

class YogaApp extends StatelessWidget {
  const YogaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yoga App',
      theme: ThemeData(useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}
