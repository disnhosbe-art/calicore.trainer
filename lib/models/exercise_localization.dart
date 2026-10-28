import 'package:flutter/widgets.dart';

import '../localization/app_localizations.dart';
import 'exercise.dart';

extension ExerciseLocalization on Exercise {
  String translatedName(BuildContext context) {
    return _translate(
      context,
      'exercise_$name',
      fallback: name,
    );
  }

  String translatedMuscles(BuildContext context) {
    return _translate(
      context,
      'muscles_$muscles',
      fallback: muscles,
    );
  }

  String translatedStep(BuildContext context, int index) {
    if (index < 0 || index >= steps.length) {
      return '';
    }

    return _translate(
      context,
      'step_${name}_$index',
      fallback: steps[index],
    );
  }

  String translatedInstruction(BuildContext context, int index) {
    if (index < 0 || index >= instructions.length) {
      return '';
    }

    return _translate(
      context,
      'instruction_${name}_$index',
      fallback: instructions[index],
    );
  }

  String _translate(
      BuildContext context,
      String key, {
        required String fallback,
      }) {
    final translated = AppLocalizations.of(context).text(key);

    if (translated.isEmpty || translated == key) {
      return fallback;
    }

    return translated;
  }
}