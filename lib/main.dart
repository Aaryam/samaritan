import 'package:flutter/material.dart';
import 'package:samaritan/misc/utilities.dart';
import 'package:samaritan/screens/startscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Samaritan',
      theme: ThemeData(
        primarySwatch: SamaritanColors.primaryColor,
      ),
      home: const StartScreen(),
    );
  }
}
