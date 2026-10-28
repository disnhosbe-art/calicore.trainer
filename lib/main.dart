import 'package:flutter/material.dart';
import 'ProfileScreen.dart';
import 'onboarding/onboarding_flow.dart';

void main() {
  runApp(const CaliCoreMainApp());
}

class CaliCoreMainApp extends StatelessWidget {
  const CaliCoreMainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CaliCore ARC MODE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F0F14),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD4FF00),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const Welcome(),
    );
  }
}