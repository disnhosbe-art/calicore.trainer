import 'package:flutter/material.dart';

class PushupPage extends StatefulWidget {
  const PushupPage({super.key});

  @override
  State<PushupPage> createState() => _PushupPageState();
}

class _PushupPageState extends State<PushupPage> {

  final List<Map<String, dynamic>> workoutProgram = [

    {
      "day": "Day 1 - Chest & Triceps",
      "exercises": [
        "Push Ups - 4 x 12",
        "Bench Dips - 3 x 10",
        "Plank - 3 x 30s"
      ]
    },

    {
      "day": "Day 2 - Back",
      "exercises": [
        "Pull Ups - 4 x 6",
        "Australian Pull Ups - 3 x 10",
        "Hanging Knee Raise - 3 x 12"
      ]
    },

    {
      "day": "Day 3 - Legs",
      "exercises": [
        "Squats - 4 x 15",
        "Lunges - 3 x 10 each leg",
        "Calf Raises - 3 x 20"
      ]
    },

    {
      "day": "Day 4 - Abs",
      "exercises": [
        "Leg Raises - 3 x 12",
        "Russian Twist - 3 x 20",
        "Plank - 3 x 45s"
      ]
    }

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Weekly Workout",
          style: TextStyle(color: Colors.orange),
        ),
        iconTheme: const IconThemeData(color: Colors.orange),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: workoutProgram.length,
        itemBuilder: (context, index) {

          final day = workoutProgram[index];
          final exercises = day["exercises"] as List;

          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: const Color(0xFF1C1F2A),
              borderRadius: BorderRadius.circular(20),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  day["day"],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),

                const SizedBox(height: 15),

                ...exercises.map((exercise) {

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),

                    child: Row(
                      children: [

                        const Icon(
                          Icons.fitness_center,
                          color: Colors.orange,
                          size: 18,
                        ),

                        const SizedBox(width: 10),

                        Text(
                          exercise,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),

                      ],
                    ),

                  );

                }).toList(),

              ],
            ),
          );

        },
      ),
    );
  }
}