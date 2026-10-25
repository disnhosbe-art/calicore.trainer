
class Exercise {
  final String name;
  final String muscles;
  final String duration;
  final String icon;
  final int sets;
  final int reps;
  final int restSeconds;
  final List<String> steps;
  final List<String> instructions;

  const Exercise({
    required this.name,
    required this.muscles,
    required this.duration,
    required this.icon,
    required this.sets,
    required this.reps,
    required this.restSeconds,
    required this.steps,
    required this.instructions,
  });
}

const List<Exercise> exercises = [
  Exercise(
    name: 'Pull-ups',
    muscles: 'Back & Biceps',
    duration: '4–6 min',
    icon: '💪',
    sets: 3,
    reps: 12,
    restSeconds: 60,
    steps: [
      'Start Position',
      'Pull Up',
      'Top Position',
      'Lower Down',
    ],
    instructions: [
      'Hang from the bar with straight arms.\n'
          'Keep your body tight.\nEngage your core.',
      'Pull your body up using your back and biceps.\n'
          'Keep your elbows close.\nAvoid swinging.',
      'Bring your chin above the bar.\n'
          'Squeeze your back and biceps.\nStay stable.',
      'Lower your body slowly.\n'
          'Extend your arms fully.\nRepeat.',
    ],
  ),
  Exercise(
    name: 'Push-ups',
    muscles: 'Chest & Triceps',
    duration: '3–5 min',
    icon: '🔥',
    sets: 3,
    reps: 15,
    restSeconds: 60,
    steps: [
      'Start Position',
      'Lower Down',
      'Bottom Position',
      'Push Up',
    ],
    instructions: [
      'Place hands slightly wider than shoulders.\n'
          'Keep your body straight.',
      'Bend your elbows slowly.\n'
          'Lower your chest toward the floor.',
      'Keep your core tight.\n'
          'Do not let your hips drop.',
      'Push through your palms.\n'
          'Return to the starting position.',
    ],
  ),
  Exercise(
    name: 'Dips',
    muscles: 'Chest & Triceps',
    duration: '3–5 min',
    icon: '⚡',
    sets: 3,
    reps: 12,
    restSeconds: 60,
    steps: [
      'Start Position',
      'Lower Body',
      'Bottom Position',
      'Push Up',
    ],
    instructions: [
      'Hold the parallel bars.\n'
          'Support your body with straight arms.',
      'Bend your elbows slowly.\n'
          'Keep shoulders controlled.',
      'Lower to a comfortable depth.\n'
          'Keep your body stable.',
      'Push your body upward.\n'
          'Return to straight arms.',
    ],
  ),
  Exercise(
    name: 'Muscle-ups',
    muscles: 'Full Body',
    duration: '5–10 min',
    icon: '🏋️',
    sets: 3,
    reps: 6,
    restSeconds: 90,
    steps: [
      'Start Position',
      'Explosive Pull',
      'Transition',
      'Press Up',
    ],
    instructions: [
      'Grip the bar firmly.\n'
          'Engage your shoulders and core.',
      'Pull your chest toward the bar explosively.',
      'Lean forward over the bar.\n'
          'Rotate your wrists into position.',
      'Press upward until your arms are straight.\n'
          'Lower yourself with control.',
    ],
  ),
];
