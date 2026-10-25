
import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../widgets/custom_widgets.dart';

class HomePage extends StatelessWidget {
  final int completed;
  final VoidCallback onStart;

  const HomePage({
    super.key,
    required this.completed,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Row(
          children: [
            const Icon(Icons.bolt, color: neonGreen, size: 38),
            const Text(
              'Cali',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
            const Text(
              'Core',
              style: TextStyle(
                color: neonGreen,
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'CaliCore',
                  applicationVersion: '1.0.0',
                  children: [
                    const Text('Train smart. Get strong.'),
                  ],
                );
              },
              icon: const Icon(Icons.settings_outlined),
            ),
          ],
        ),
        const Text(
          'TRAIN SMART • GET STRONG',
          style: TextStyle(
            color: mutedText,
            fontSize: 10,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 22),
        Container(
          height: 280,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF245318),
                Color(0xFF0C2216),
                appBg,
              ],
            ),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.fitness_center,
                color: neonGreen,
                size: 115,
              ),
              SizedBox(height: 22),
              Text(
                'BETTER THAN',
                style: TextStyle(
                  color: neonGreen,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Text(
                'YESTERDAY',
                style: TextStyle(
                  color: neonGreen,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        CaliCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Plan',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Beginner • Week 1',
                style: TextStyle(color: mutedText),
              ),
              const Divider(height: 30),
              Row(
                children: [
                  SizedBox(
                    width: 85,
                    height: 85,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox.expand(
                          child: CircularProgressIndicator(
                            value: (completed / 12).clamp(0.0, 1.0),
                            strokeWidth: 8,
                            backgroundColor: Colors.black,
                            color: neonGreen,
                          ),
                        ),
                        Text(
                          '$completed/12',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: exercises.map((exercise) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.fitness_center,
                                color: neonGreen,
                                size: 16,
                              ),
                              const SizedBox(width: 10),
                              Text(exercise.name),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'Workouts Completed',
                  style: TextStyle(color: mutedText),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        CaliButton(
          title: 'Start Workout',
          icon: Icons.play_arrow,
          onPressed: onStart,
        ),
      ],
    );
  }
}
