import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/exercise.dart';
import '../localization/app_localizations.dart';
import '../widgets/custom_widgets.dart';
import 'exercise_steps_page.dart';
import 'workout_session_page.dart';
import '../models/exercise_localization.dart';

class ExerciseDetailsPage extends StatefulWidget {
  final Exercise exercise;
  final ValueChanged<int> onWorkoutComplete;

  const ExerciseDetailsPage({
    super.key,
    required this.exercise,
    required this.onWorkoutComplete,
  });

  @override
  State<ExerciseDetailsPage> createState() =>
      _ExerciseDetailsPageState();
}

class _ExerciseDetailsPageState extends State<ExerciseDetailsPage> {
  bool _isFavorite = false;
  bool _isLoadingFavorite = true;

  static const String _favoritesKey = 'favorite_exercises';

  @override
  void initState() {
    super.initState();
    _checkFavorite();
  }

  Future<void> _checkFavorite() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getStringList(_favoritesKey) ?? [];

      final exists = saved.any((item) {
        try {
          final data = jsonDecode(item) as Map<String, dynamic>;
          return data['name'] == widget.exercise.name;
        } catch (_) {
          return false;
        }
      });

      if (!mounted) return;

      setState(() {
        _isFavorite = exists;
        _isLoadingFavorite = false;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _isLoadingFavorite = false;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    if (_isLoadingFavorite) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getStringList(_favoritesKey) ?? [];
      final exercise = widget.exercise;

      final index = saved.indexWhere((item) {
        try {
          final data = jsonDecode(item) as Map<String, dynamic>;
          return data['name'] == exercise.name;
        } catch (_) {
          return false;
        }
      });

      final adding = index == -1;

      final encoded = jsonEncode({
        'name': exercise.name,
        'muscles': exercise.muscles,
        'duration': exercise.duration,
        'icon': exercise.icon,
        'imageAsset': exercise.imageAsset,
        'sets': exercise.sets,
        'reps': exercise.reps,
        'restSeconds': exercise.restSeconds,
      });

      if (adding) {
        saved.add(encoded);
      } else {
        saved.removeAt(index);
      }

      await prefs.setStringList(_favoritesKey, saved);

      if (!mounted) return;

      setState(() {
        _isFavorite = adding;
      });

      final l10n = AppLocalizations.of(context);
      final message = adding
          ? l10n.text('favorite_added')
          : l10n.text('favorite_removed');

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              '$message: ${exercise.translatedName(context)}',
            ),
            backgroundColor: const Color(0xFF121612),
          ),
        );
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not update favorites. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final exercise = widget.exercise;
    final l10n = AppLocalizations.of(context);

    final exerciseName = exercise.translatedName(context);
    final muscles = exercise.translatedMuscles(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(exerciseName),
        actions: [
          IconButton(
            onPressed:
            _isLoadingFavorite ? null : _toggleFavorite,
            tooltip: l10n.text(
              _isFavorite
                  ? 'remove_from_favorites'
                  : 'add_to_favorites',
            ),
            icon: Icon(
              _isFavorite
                  ? Icons.bookmark
                  : Icons.bookmark_border,
              color: _isFavorite ? neonGreen : null,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            muscles,
            style: const TextStyle(color: mutedText),
          ),

          const SizedBox(height: 18),

          // EXERCISE IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 300,
              width: double.infinity,
              color: const Color(0xFF101010),
              child: Image.asset(
                exercise.imageAsset,
                width: double.infinity,
                height: 300,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.fitness_center,
                      color: Color(0xFFFFC928),
                      size: 80,
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 18),

          // LEVEL
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: neonGreen),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.people,
                    color: neonGreen,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n.text('beginner'),
                    style: const TextStyle(color: neonGreen),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Text(
            '$exerciseName ${l10n.text('exercise_description')}',
            style: const TextStyle(
              fontSize: 16,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 25),

          // EXERCISE STATS
          Row(
            children: [
              Expanded(
                child: CaliStat(
                  title: l10n.text('sets'),
                  value: '${exercise.sets}',
                  icon: Icons.repeat,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CaliStat(
                  title: l10n.text('reps'),
                  value: '${exercise.reps}',
                  icon: Icons.fitness_center,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CaliStat(
                  title: l10n.text('rest'),
                  value: '${exercise.restSeconds}s',
                  icon: Icons.timer,
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          // STEP-BY-STEP
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ExerciseStepsPage(
                    exercise: exercise,
                    onWorkoutComplete: widget.onWorkoutComplete,
                  ),
                ),
              );
            },
            child: CaliCard(
              child: Row(
                children: [
                  const Icon(
                    Icons.menu_book,
                    color: neonGreen,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l10n.text('step_by_step'),
                      style: const TextStyle(fontSize: 18),
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

          const SizedBox(height: 25),

          // START WORKOUT
          CaliButton(
            title: l10n.text('start'),
            icon: Icons.play_arrow,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => WorkoutSessionPage(
                    exercise: exercise,
                    onWorkoutComplete: widget.onWorkoutComplete,
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