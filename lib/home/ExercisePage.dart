import 'package:flutter/material.dart';

class ExercisePage extends StatelessWidget {
  final String title;
  final String image;
  final String description;
  final String bodyImage;

  const ExercisePage({
    super.key,
    required this.title,
    required this.image,
    required this.description,
    required this.bodyImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Stack(
              children: [

                Image.asset(
                  image,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),

                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent
                      ],
                    ),
                  ),
                ),

                Positioned(
                  top: 40,
                  left: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),

                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                description, // الوصف لي جاي من CrossPage
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 30),

            const Center(
              child: Text(
                "Impact of exercise",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: Image.asset(
                bodyImage, // صورة العضلات المتأثرة
                width: 300,
              ),
            ),

            const SizedBox(height: 40),

          ],
        ),
      ),
    );
  }
}