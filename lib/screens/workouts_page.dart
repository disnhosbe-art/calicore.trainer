import 'package:flutter/material.dart';

import '../models/exercise.dart';
import '../widgets/custom_widgets.dart';
import 'exercise_details_page.dart';

class WorkoutsPage extends StatefulWidget {
  final ValueChanged<int> onWorkoutComplete;

  const WorkoutsPage({
    super.key,
    required this.onWorkoutComplete,
  });

  @override
  State<WorkoutsPage> createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsPage> {
  String selectedFilter = 'All';

  final List<String> filters = [
    'All',
    'Back',
    'Chest',
    'Legs',
    'Shoulders',
    'Arms',
    'Core',
    'Advanced',
  ];

  String categoryOf(String name) {
    final n = name.toLowerCase();

    if ([
      'muscle-ups',
      'archer pull-ups',
      'explosive pull-ups',
      'front lever raises',
    ].contains(n)) {
      return 'Advanced';
    }

    if (n.contains('pull-up') ||
        n.contains('chin-up') ||
        n.contains('australian')) {
      return 'Back';
    }

    if (n == 'dips' ||
        n.contains('diamond push') ||
        n.contains('wide push') ||
        n.contains('decline push') ||
        n.contains('incline push') ||
        n == 'push-ups' ||
        n.contains('pseudo planche')) {
      return 'Chest';
    }

    if (n.contains('squat') ||
        n.contains('lunge') ||
        n.contains('calf')) {
      return 'Legs';
    }

    if (n.contains('pike') ||
        n.contains('handstand') ||
        n.contains('wall walk') ||
        n.contains('y-raises')) {
      return 'Shoulders';
    }

    if (n.contains('bicep') || n.contains('triceps')) {
      return 'Arms';
    }

    if (n.contains('l-sit') ||
        n.contains('leg raises') ||
        n.contains('russian') ||
        n.contains('bicycle')) {
      return 'Core';
    }

    return 'All';
  }

  @override
  Widget build(BuildContext context) {
    final filteredExercises = selectedFilter == 'All'
        ? exercises
        : exercises.where((exercise) {
      return categoryOf(exercise.name) == selectedFilter;
    }).toList();

    // Extra space for the bottom navigation bar.
    final bottomSpace = MediaQuery.of(context).padding.bottom + 100.0;

    return ListView(
      key: const PageStorageKey<String>('workouts_list'),
      padding: EdgeInsets.fromLTRB(20, 40, 20, bottomSpace),
      children: [
        const Text(
          'Workouts',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 9),

        const Text(
          'MASTER YOUR BODY. UNLOCK NEW SKILLS.',
          style: TextStyle(
            color: mutedText,
            fontSize: 12,
            letterSpacing: 1,
          ),
        ),

        const SizedBox(height: 20),

        // Workout filters
        SizedBox(
          height: 45,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: filters.map((filter) {
              final selected = filter == selectedFilter;

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(filter),
                  selected: selected,
                  selectedColor: neonGreen,
                  backgroundColor: appPanel,
                  labelStyle: TextStyle(
                    color: selected ? Colors.black : Colors.white,
                    fontWeight:
                    selected ? FontWeight.bold : FontWeight.normal,
                  ),
                  onSelected: (_) {
                    setState(() {
                      selectedFilter = filter;
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 10),

        // Exercises grid
        for (int i = 0; i < filteredExercises.length; i += 2)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int j = i;
              j < i + 2 && j < filteredExercises.length;
              j++)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: j == i ? 7 : 0,
                      left: j == i + 1 ? 7 : 0,
                      bottom: 14,
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ExerciseDetailsPage(
                              exercise: filteredExercises[j],
                              onWorkoutComplete: widget.onWorkoutComplete,
                            ),
                          ),
                        );
                      },
                      child: CaliCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.asset(
                                  filteredExercises[j].imageAsset,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) {
                                    return Container(
                                      color: const Color(0xFF1A391A),
                                      child: Center(
                                        child: Text(
                                          filteredExercises[j].icon,
                                          style: const TextStyle(
                                            fontSize: 45,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            Text(
                              filteredExercises[j].name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              filteredExercises[j].muscles,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: mutedText,
                                fontSize: 11,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              '${filteredExercises[j].sets} sets × '
                                  '${filteredExercises[j].reps} reps',
                              style: const TextStyle(
                                color: neonGreen,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              // Keep the last card aligned when the number is odd.
              if (filteredExercises.length.isOdd &&
                  i + 1 >= filteredExercises.length)
                const Expanded(
                  child: SizedBox(),
                ),
            ],
          ),

        if (filteredExercises.isEmpty)
          const Padding(
            padding: EdgeInsets.all(28),
            child: Center(
              child: Text(
                'No exercises in this category yet.',
                style: TextStyle(
                  color: mutedText,
                ),
              ),
            ),
          ),
      ],
    );
  }
}