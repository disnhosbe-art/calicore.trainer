
import 'package:flutter/material.dart';
import '../widgets/custom_widgets.dart';

class ProgressPage extends StatelessWidget {
  final int completed;
  final int totalReps;

  const ProgressPage({
    super.key,
    required this.completed,
    required this.totalReps,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (completed / 12).clamp(0.0, 1.0);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Your Progress',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Every rep makes you stronger.',
          style: TextStyle(color: mutedText),
        ),
        const SizedBox(height: 25),
        CaliCard(
          child: Column(
            children: [
              const Text(
                'WEEKLY PROGRESS',
                style: TextStyle(
                  color: neonGreen,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                height: 160,
                width: 160,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox.expand(
                      child: CircularProgressIndicator(
                        value: progress,
                        color: neonGreen,
                        backgroundColor: Colors.black,
                        strokeWidth: 12,
                      ),
                    ),
                    Text(
                      '${(progress * 100).round()}%',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text('$completed / 12 workouts'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: CaliStat(
                title: 'Workouts',
                value: '$completed',
                icon: Icons.fitness_center,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CaliStat(
                title: 'Total Reps',
                value: '$totalReps',
                icon: Icons.repeat,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const CaliStat(
          title: 'Level',
          value: 'Beginner',
          icon: Icons.emoji_events,
        ),
        const SizedBox(height: 25),
        const Text(
          'KEEP PUSHING YOUR LIMITS',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: neonGreen,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}
