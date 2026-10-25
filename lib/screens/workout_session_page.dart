
import 'dart:async';
import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../widgets/custom_widgets.dart';

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

      if (currentReps >= widget.exercise.reps) {
        if (currentSet >= widget.exercise.sets) {
          finished = true;
        } else {
          currentSet++;
          currentReps = 0;
          resting = true;
          restRemaining = widget.exercise.restSeconds;
        }
      }
    });
  }

  void finishWorkout() {
    if (finished) {
      widget.onWorkoutComplete(totalReps);
    }

    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final exercise = widget.exercise;

    final progress = finished
        ? 1.0
        : currentReps / exercise.reps;

    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.name),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              children: [
                SizedBox(
                  height: 115,
                  width: 115,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox.expand(
                        child: CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 9,
                          color: neonGreen,
                          backgroundColor: appPanel,
                        ),
                      ),
                      Text(
                        resting
                            ? '$restRemaining'
                            : formatTime(elapsed),
                        style: const TextStyle(
                          fontSize: 23,
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
                    children: [
                      Text(
                        'Set $currentSet/${exercise.sets}',
                        style: const TextStyle(fontSize: 22),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Reps $currentReps/${exercise.reps}',
                        style: const TextStyle(
                          color: neonGreen,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Container(
              height: 310,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF20451B),
                    appPanel,
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    exercise.icon,
                    style: const TextStyle(fontSize: 105),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    finished
                        ? 'WORKOUT COMPLETE!'
                        : resting
                        ? 'REST TIME'
                        : paused
                        ? 'PAUSED'
                        : 'KEEP GOING!',
                    style: const TextStyle(
                      color: neonGreen,
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            if (finished)
              CaliButton(
                title: 'Finish Workout',
                icon: Icons.check,
                onPressed: finishWorkout,
              )
            else if (resting)
              CaliButton(
                title: 'Skip Rest',
                icon: Icons.skip_next,
                onPressed: () {
                  setState(() {
                    resting = false;
                    restRemaining = 0;
                  });
                },
              )
            else
              CaliButton(
                title: '+ 1 Rep',
                icon: Icons.add,
                onPressed: paused ? () {} : addRep,
              ),
            const SizedBox(height: 12),
            if (!finished)
              OutlinedButton.icon(
                onPressed: () {
                  setState(() => paused = !paused);
                },
                icon: Icon(
                  paused ? Icons.play_arrow : Icons.pause,
                ),
                label: Text(paused ? 'Resume' : 'Pause'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: neonGreen,
                  side: const BorderSide(color: neonGreen),
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: CaliStat(
                    title: 'Time',
                    value: formatTime(elapsed),
                    icon: Icons.timer,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CaliStat(
                    title: 'Rest',
                    value: '${resting ? restRemaining : exercise.restSeconds}s',
                    icon: Icons.hourglass_bottom,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CaliStat(
                    title: 'Total Reps',
                    value: '$totalReps',
                    icon: Icons.fitness_center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
