import 'package:flutter/material.dart';


class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.orange),
        title: const Text(
          "About",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          """Calisthenics Training App

This application is designed to help users learn calisthenics exercises and follow structured workout programs.

Users can explore different exercises, view proper techniques, and improve their strength, flexibility, and overall fitness.

The app is simple, user-friendly, and suitable for beginners and advanced users.

Developer:
Sofiane Sadoq
""",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}