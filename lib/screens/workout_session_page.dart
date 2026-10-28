import 'dart:async';

import 'package:flutter/material.dart';

import '../models/exercise.dart';
import '../models/exercise_translations.dart';
import '../widgets/custom_widgets.dart';
import '../data/exercise_pins.dart';
import '../workouts/pinterest_exercise.dart';

class WorkoutSessionPage extends StatefulWidget {
  final Exercise exercise;
  final ValueChanged<int> onWorkoutComplete;

  const WorkoutSessionPage({
    super.key,
    required this.exercise,
    required this.onWorkoutComplete,
  });

  @override
  State<WorkoutSessionPage> createState() =>
      _WorkoutSessionPageState();
}

class _WorkoutSessionPageState extends State<WorkoutSessionPage> {
  Timer? timer;

  int elapsed = 0;
  int currentSet = 1;
  int currentReps = 0;
  int totalReps = 0;
  int restRemaining = 0;

  bool paused = false;
  bool finished = false;
  bool resting = false;
  bool _completionReported = false;

  static const Color background = Color(0xFF080A08);

  String tr(
      String en,
      String ar,
      String fr,
      String pt,
      ) {
    switch (Localizations.localeOf(context).languageCode) {
      case 'ar':
        return ar;
      case 'fr':
        return fr;
      case 'pt':
        return pt;
      default:
        return en;
    }
  }

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted || paused || finished) return;

      setState(() {
        elapsed++;

        if (resting) {
          restRemaining--;

          if (restRemaining <= 0) {
            restRemaining = 0;
            resting = false;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  void addRep() {
    if (paused || resting || finished) return;

    setState(() {
      currentReps++;
      totalReps++;

      final targetReps =
      widget.exercise.reps > 0 ? widget.exercise.reps : 1;

      final targetSets =
      widget.exercise.sets > 0 ? widget.exercise.sets : 1;

      if (currentReps >= targetReps) {
        if (currentSet >= targetSets) {
          finished = true;
          paused = false;
          resting = false;
          restRemaining = 0;
          timer?.cancel();
        } else {
          currentSet++;
          currentReps = 0;

          restRemaining = widget.exercise.restSeconds;
          resting = restRemaining > 0;
        }
      }
    });
  }

  void skipRest() {
    if (!resting || finished) return;

    setState(() {
      resting = false;
      restRemaining = 0;
    });
  }

  void togglePause() {
    if (finished) return;

    setState(() {
      paused = !paused;
    });
  }

  void finishWorkout() {
    if (!finished || _completionReported) return;

    _completionReported = true;
    widget.onWorkoutComplete(totalReps);

    if (!mounted) return;

    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Widget buildProgressCircle({
    required double progress,
    required bool isResting,
  }) {
    return SizedBox(
      height: 110,
      width: 110,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(
                begin: 0,
                end: progress,
              ),
              duration: const Duration(milliseconds: 450),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return CircularProgressIndicator(
                  value: value,
                  strokeWidth: 9,
                  color: neonGreen,
                  backgroundColor: appPanel,
                  strokeCap: StrokeCap.round,
                );
              },
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isResting ? '$restRemaining' : formatTime(elapsed),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                isResting
                    ? tr('REST', 'راحة', 'REPOS', 'DESCANSO')
                    : '${(progress * 100).round()}%',
                style: const TextStyle(
                  color: neonGreen,
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final exercise = widget.exercise;
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';

    final exerciseName = ExerciseTranslations.name(exercise, locale);

    // Original name is used to find the exercise's Pinterest pin.
    final pinId = exercisePins[exercise.name];

    final targetReps = exercise.reps > 0 ? exercise.reps : 1;
    final targetSets = exercise.sets > 0 ? exercise.sets : 1;

    final int totalTargetReps = targetReps * targetSets;

    final double progress = finished
        ? 1.0
        : (totalReps / totalTargetReps)
        .clamp(0.0, 1.0)
        .toDouble();

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          backgroundColor: background,
          foregroundColor: Colors.white,
          elevation: 0,
          title: Text(
            exerciseName,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
            children: [
              // Animated progress circle and workout counters.
              Row(
                children: [
                  buildProgressCircle(
                    progress: progress,
                    isResting: resting,
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${tr('Set', 'المجموعة', 'Série', 'Série')} '
                              '$currentSet/$targetSets',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '${tr('Reps', 'التكرارات', 'Répétitions', 'Repetições')} '
                              '$currentReps/$targetReps',
                          style: const TextStyle(
                            color: neonGreen,
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          paused
                              ? tr(
                            'Session paused',
                            'التمرين متوقف مؤقتاً',
                            'Séance en pause',
                            'Treino pausado',
                          )
                              : resting
                              ? tr(
                            'Take a rest',
                            'خذ قسطاً من الراحة',
                            'Reposez-vous',
                            'Descanse um pouco',
                          )
                              : finished
                              ? tr(
                            'Great work!',
                            'عمل رائع!',
                            'Excellent travail !',
                            'Bom trabalho!',
                          )
                              : tr(
                            'Keep going!',
                            'استمر!',
                            'Continuez !',
                            'Continue!',
                          ),
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Exercise image: Pinterest first, local asset as fallback.
              Container(
                height: 350,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: appPanel,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: neonGreen.withOpacity(0.35),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: pinId != null
                          ? PinterestExercise(pinId: pinId)
                          : Center(
                        child: Image.asset(
                          exercise.imageAsset,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) {
                            return Text(
                              exercise.icon,
                              style: const TextStyle(
                                fontSize: 90,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Text(
                        finished
                            ? tr(
                          'WORKOUT COMPLETE!',
                          'اكتمل التمرين!',
                          'ENTRAÎNEMENT TERMINÉ !',
                          'TREINO CONCLUÍDO!',
                        )
                            : resting
                            ? tr(
                          'REST TIME',
                          'وقت الراحة',
                          'TEMPS DE REPOS',
                          'TEMPO DE DESCANSO',
                        )
                            : paused
                            ? tr(
                          'PAUSED',
                          'متوقف مؤقتاً',
                          'EN PAUSE',
                          'PAUSADO',
                        )
                            : tr(
                          'KEEP GOING!',
                          'استمر!',
                          'CONTINUEZ !',
                          'CONTINUE!',
                        ),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: neonGreen,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Main action.
              if (finished)
                CaliButton(
                  title: tr(
                    'Finish Workout',
                    'إنهاء التمرين',
                    'Terminer la séance',
                    'Finalizar treino',
                  ),
                  icon: Icons.check_circle,
                  onPressed: finishWorkout,
                )
              else if (resting)
                CaliButton(
                  title: tr(
                    'Skip Rest',
                    'تخطي الراحة',
                    'Passer le repos',
                    'Saltar descanso',
                  ),
                  icon: Icons.skip_next,
                  onPressed: skipRest,
                )
              else
                Opacity(
                  opacity: paused ? 0.45 : 1.0,
                  child: AbsorbPointer(
                    absorbing: paused,
                    child: CaliButton(
                      title: tr(
                        '+ 1 Rep',
                        '+ تكرار واحد',
                        '+ 1 répétition',
                        '+ 1 repetição',
                      ),
                      icon: Icons.add,
                      onPressed: addRep,
                    ),
                  ),
                ),

              const SizedBox(height: 12),

              if (!finished)
                OutlinedButton.icon(
                  onPressed: togglePause,
                  icon: Icon(
                    paused ? Icons.play_arrow : Icons.pause,
                  ),
                  label: Text(
                    paused
                        ? tr(
                      'Resume',
                      'استئناف',
                      'Reprendre',
                      'Retomar',
                    )
                        : tr(
                      'Pause',
                      'إيقاف مؤقت',
                      'Pause',
                      'Pausar',
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: neonGreen,
                    side: const BorderSide(color: neonGreen),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),

              const SizedBox(height: 22),

              // Workout statistics.
              Row(
                children: [
                  Expanded(
                    child: CaliStat(
                      title: tr(
                        'Time',
                        'الوقت',
                        'Temps',
                        'Tempo',
                      ),
                      value: formatTime(elapsed),
                      icon: Icons.timer,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CaliStat(
                      title: tr(
                        'Rest',
                        'الراحة',
                        'Repos',
                        'Descanso',
                      ),
                      value:
                      '${resting ? restRemaining : exercise.restSeconds}s',
                      icon: Icons.hourglass_bottom,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CaliStat(
                      title: tr(
                        'Total Reps',
                        'مجموع التكرارات',
                        'Total répétitions',
                        'Total de repetições',
                      ),
                      value: '$totalReps',
                      icon: Icons.fitness_center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}