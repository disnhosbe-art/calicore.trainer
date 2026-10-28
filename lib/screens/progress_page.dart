
import 'package:flutter/material.dart';
import '../localization/app_localizations.dart';

const Color _green = Color(0xFFB7FF32);
const Color _background = Color(0xFF080B09);
const Color _card = Color(0xFF121713);

String _tr(BuildContext context, String key) =>
    AppLocalizations.of(context).text(key);

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
    final workouts = completed < 0 ? 0 : completed;
    final reps = totalReps < 0 ? 0 : totalReps;
    final progress = (workouts / 12).clamp(0.0, 1.0);

    final levelKey = workouts >= 12
        ? 'level_advanced'
        : workouts >= 8
        ? 'level_intermediate'
        : workouts >= 4
        ? 'level_rising'
        : 'beginner';

    return Container(
      color: _background,
      child: SafeArea(
        bottom: false,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(18, 20, 18, 125),
          children: [
            Text(
              _tr(context, 'your_progress'),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              _tr(context, 'progress_subtitle'),
              style: const TextStyle(color: Colors.white54),
            ),
            const SizedBox(height: 24),

            // 12 WORKOUT CHALLENGE
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF202A1B),
                    _card,
                    _background,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: _green.withValues(alpha: 0.25),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.bolt_rounded, color: _green),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _tr(context, 'workout_challenge'),
                          style: const TextStyle(
                            color: _green,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    height: 175,
                    width: 175,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox.expand(
                          child: CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 12,
                            strokeCap: StrokeCap.round,
                            backgroundColor: Colors.white10,
                            color: _green,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${(progress * 100).round()}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 38,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              _tr(context, 'completed'),
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 10,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    '$workouts / 12 ${_tr(context, 'workouts')}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 9),
                  Text(
                    workouts >= 12
                        ? _tr(context, 'challenge_completed')
                        : '${12 - workouts} ${_tr(context, 'workouts_left')}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),
            Text(
              _tr(context, 'your_statistics'),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: _statCard(
                    icon: Icons.fitness_center_rounded,
                    title: _tr(context, 'workouts'),
                    value: '$workouts',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _statCard(
                    icon: Icons.repeat_rounded,
                    title: _tr(context, 'total_reps'),
                    value: '$reps',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _statCard(
              icon: Icons.emoji_events_rounded,
              title: _tr(context, 'current_level'),
              value: _tr(context, levelKey),
            ),

            const SizedBox(height: 28),
            BodyWeightCard(),
            const SizedBox(height: 30),

            Center(
              child: Column(
                children: [
                  const Icon(
                    Icons.bolt_rounded,
                    color: _green,
                    size: 30,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _tr(context, 'keep_pushing'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: _green,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    _tr(context, 'discipline_motivation'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white38,
                      fontSize: 10,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Icon(icon, color: _green, size: 24),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BodyWeightCard extends StatefulWidget {
  const BodyWeightCard({super.key});

  @override
  State<BodyWeightCard> createState() => _BodyWeightCardState();
}

class _BodyWeightCardState extends State<BodyWeightCard> {
  final TextEditingController _heightController =
  TextEditingController();
  final TextEditingController _weightController =
  TextEditingController();

  double? _height;
  double? _weight;

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _calculate() {
    final height = double.tryParse(
      _heightController.text.trim().replaceAll(',', '.'),
    );
    final weight = double.tryParse(
      _weightController.text.trim().replaceAll(',', '.'),
    );

    if (height == null ||
        weight == null ||
        height < 100 ||
        height > 250 ||
        weight < 20 ||
        weight > 350) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_tr(context, 'invalid_measurements')),
        ),
      );
      return;
    }

    setState(() {
      _height = height;
      _weight = weight;
    });

    FocusScope.of(context).unfocus();
  }

  Widget _measurementField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
          ),
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white30),
            prefixIcon: Icon(icon, color: _green),
            filled: true,
            fillColor: _background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.white12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.white12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: _green),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = _height;
    final weight = _weight;

    double? bmi;
    double? minWeight;
    double? maxWeight;
    String? resultKey;
    String? adviceKey;
    Color resultColor = _green;

    if (height != null && weight != null) {
      final heightM = height / 100;
      bmi = weight / (heightM * heightM);
      minWeight = 18.5 * heightM * heightM;
      maxWeight = 24.9 * heightM * heightM;

      if (bmi < 18.5) {
        resultKey = 'weight_below_range';
        adviceKey = 'advice_below_range';
        resultColor = Colors.orangeAccent;
      } else if (bmi < 25) {
        resultKey = 'weight_healthy_range';
        adviceKey = 'advice_healthy_range';
        resultColor = _green;
      } else {
        resultKey = 'weight_above_range';
        adviceKey = 'advice_above_range';
        resultColor = Colors.redAccent;
      }
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: _green.withValues(alpha: 0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.monitor_weight_outlined,
                color: _green,
                size: 25,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  _tr(context, 'body_weight_check'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _tr(context, 'body_weight_subtitle'),
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 22),
          _measurementField(
            controller: _heightController,
            label: _tr(context, 'height_cm'),
            hint: 'e.g. 175',
            icon: Icons.height_rounded,
          ),
          const SizedBox(height: 14),
          _measurementField(
            controller: _weightController,
            label: _tr(context, 'current_weight_kg'),
            hint: 'e.g. 70',
            icon: Icons.monitor_weight_outlined,
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _calculate,
              icon: const Icon(Icons.calculate_rounded),
              label: Text(_tr(context, 'check_my_weight')),
              style: ElevatedButton.styleFrom(
                backgroundColor: _green,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          if (bmi != null &&
              resultKey != null &&
              adviceKey != null &&
              minWeight != null &&
              maxWeight != null) ...[
            const SizedBox(height: 22),
            const Divider(color: Colors.white12),
            const SizedBox(height: 15),
            Text(
              _tr(context, 'your_result'),
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'BMI: ${bmi.toStringAsFixed(1)}',
              style: TextStyle(
                color: resultColor,
                fontSize: 27,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              _tr(context, resultKey),
              style: TextStyle(
                color: resultColor,
                fontSize: 13,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: resultColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: resultColor.withValues(alpha: 0.25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline_rounded,
                        color: resultColor,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _tr(context, 'personal_guidance'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _tr(context, adviceKey),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _green.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _tr(context, 'adult_weight_range'),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${minWeight.toStringAsFixed(1)} – '
                        '${maxWeight.toStringAsFixed(1)} kg',
                    style: const TextStyle(
                      color: _green,
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _tr(context, 'bmi_disclaimer'),
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 11,
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
