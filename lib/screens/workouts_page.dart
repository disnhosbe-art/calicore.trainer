
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

  final filters = [
    'All',
    'Pull-ups',
    'Push-ups',
    'Dips',
    'Muscle-ups',
  ];

  @override
  Widget build(BuildContext context) {
    final filteredExercises = selectedFilter == 'All'
        ? exercises
        : exercises
        .where((e) => e.name == selectedFilter)
        .toList();

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Workouts',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
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
                  ),
                  onSelected: (_) {
                    setState(() => selectedFilter = filter);
                  },
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 24),
        ...filteredExercises.map((exercise) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ExerciseDetailsPage(
                      exercise: exercise,
                      onWorkoutComplete: widget.onWorkoutComplete,
                    ),
                  ),
                );
              },
              child: CaliCard(
                child: Row(
                  children: [
                    Container(
                      width: 95,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A391A),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          exercise.icon,
                          style: const TextStyle(fontSize: 45),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exercise.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            exercise.muscles,
                            style: const TextStyle(
                              color: mutedText,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(
                                Icons.timer_outlined,
                                color: neonGreen,
                                size: 16,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                exercise.duration,
                                style: const TextStyle(
                                  color: neonGreen,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: neonGreen,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
