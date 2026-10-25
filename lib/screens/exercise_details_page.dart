
import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../widgets/custom_widgets.dart';
import 'exercise_steps_page.dart';
import 'workout_session_page.dart';

class ExerciseDetailsPage extends StatelessWidget {
  final Exercise exercise;
  final ValueChanged<int> onWorkoutComplete;

  const ExerciseDetailsPage({
    super.key,
    required this.exercise,
    required this.onWorkoutComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.name),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Exercise selected'),
                ),
              );
            },
            icon: const Icon(Icons.bookmark_border),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            exercise.muscles,
            style: const TextStyle(color: mutedText),
          ),
          const SizedBox(height: 18),
          Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF24521D),
                  Color(0xFF081512),
                ],
              ),
            ),
            child: Center(
              child: Text(
                exercise.icon,
                style: const TextStyle(fontSize: 120),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: neonGreen),
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.people, color: neonGreen),
                SizedBox(width: 8),
                Text(
                  'Beginner',
                  style: TextStyle(color: neonGreen),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '${exercise.name} helps build strength, '
                'improve posture and develop better body control.',
            style: const TextStyle(
              fontSize: 16,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Expanded(
                child: CaliStat(
                  title: 'Sets',
                  value: '${exercise.sets}',
                  icon: Icons.repeat,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CaliStat(
                  title: 'Reps',
                  value: '${exercise.reps}',
                  icon: Icons.fitness_center,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CaliStat(
                  title: 'Rest',
                  value: '${exercise.restSeconds}s',
                  icon: Icons.timer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ExerciseStepsPage(
                    exercise: exercise,
                    onWorkoutComplete: onWorkoutComplete,
                  ),
                ),
              );
            },
            child: const CaliCard(
              child: Row(
                children: [
                  Icon(Icons.menu_book, color: neonGreen),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Step by Step',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Icon(Icons.chevron_right, color: neonGreen),
                ],
              ),
            ),
          ),
          const SizedBox(height: 25),
          CaliButton(
            title: 'Start',
            icon: Icons.play_arrow,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => WorkoutSessionPage(
                    exercise: exercise,
                    onWorkoutComplete: onWorkoutComplete,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
