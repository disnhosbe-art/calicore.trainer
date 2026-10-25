
import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../widgets/custom_widgets.dart';
import 'workout_session_page.dart';

class ExerciseStepsPage extends StatefulWidget {
  final Exercise exercise;
  final ValueChanged<int> onWorkoutComplete;

  const ExerciseStepsPage({
    super.key,
    required this.exercise,
    required this.onWorkoutComplete,
  });

  @override
  State<ExerciseStepsPage> createState() =>
      _ExerciseStepsPageState();
}

class _ExerciseStepsPageState extends State<ExerciseStepsPage> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final exercise = widget.exercise;
    final totalSteps = exercise.steps.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.name),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Step ${currentStep + 1} of $totalSteps',
                style: const TextStyle(color: mutedText),
              ),
              const SizedBox(height: 12),
              Row(
                children: List.generate(totalSteps, (index) {
                  return Expanded(
                    child: Container(
                      height: 6,
                      margin: const EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        color: index <= currentStep
                            ? neonGreen
                            : appPanel,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 22),
              Expanded(
                child: CaliCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF193D1B),
                                appPanel,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              exercise.icon,
                              style: const TextStyle(fontSize: 110),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CircleAvatar(
                        backgroundColor: neonGreen,
                        child: Text(
                          '${currentStep + 1}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        exercise.steps[currentStep],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        exercise.instructions[currentStep],
                        style: const TextStyle(
                          height: 1.8,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CaliButton(
                title: currentStep == totalSteps - 1
                    ? 'Finish'
                    : 'Next',
                icon: currentStep == totalSteps - 1
                    ? Icons.check
                    : Icons.arrow_forward,
                onPressed: () {
                  if (currentStep < totalSteps - 1) {
                    setState(() => currentStep++);
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => WorkoutSessionPage(
                          exercise: exercise,
                          onWorkoutComplete:
                          widget.onWorkoutComplete,
                        ),
                      ),
                    );
                  }
                },
              ),
              TextButton.icon(
                onPressed: currentStep > 0
                    ? () => setState(() => currentStep--)
                    : null,
                icon: const Icon(Icons.arrow_back),
                label: const Text('Previous'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
