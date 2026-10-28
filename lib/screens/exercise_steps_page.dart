import 'package:flutter/material.dart';

import '../models/exercise.dart';
import '../widgets/custom_widgets.dart';
import '../localization/exercise_localizations.dart';
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
  State<ExerciseStepsPage> createState() => _ExerciseStepsPageState();
}

class _ExerciseStepsPageState extends State<ExerciseStepsPage> {
  int currentStep = 0;

  String tr(String en, Locale locale) {
    const translations = {
      'ar': {
        'No steps available': 'لا توجد خطوات متاحة',
        'Step': 'الخطوة',
        'of': 'من',
        'Exercise image unavailable': 'صورة التمرين غير متاحة',
        'Follow the movement carefully and keep your body under control.':
        'اتبع الحركة بعناية وحافظ على التحكم في جسمك.',
        'No instructions available for this exercise.':
        'لا توجد تعليمات متاحة لهذا التمرين.',
        'Start Workout': 'ابدأ التمرين',
        'Next': 'التالي',
        'Previous': 'السابق',
      },
      'fr': {
        'No steps available': 'Aucune étape disponible',
        'Step': 'Étape',
        'of': 'sur',
        'Exercise image unavailable': 'Image de l’exercice indisponible',
        'Follow the movement carefully and keep your body under control.':
        'Suivez le mouvement attentivement et gardez le contrôle de votre corps.',
        'No instructions available for this exercise.':
        'Aucune instruction disponible pour cet exercice.',
        'Start Workout': 'Commencer',
        'Next': 'Suivant',
        'Previous': 'Précédent',
      },
      'pt': {
        'No steps available': 'Nenhuma etapa disponível',
        'Step': 'Etapa',
        'of': 'de',
        'Exercise image unavailable': 'Imagem do exercício indisponível',
        'Follow the movement carefully and keep your body under control.':
        'Siga o movimento com cuidado e mantenha o controlo do corpo.',
        'No instructions available for this exercise.':
        'Não há instruções disponíveis para este exercício.',
        'Start Workout': 'Começar treino',
        'Next': 'Seguinte',
        'Previous': 'Anterior',
      },
    };

    return translations[locale.languageCode]?[en] ?? en;
  }

  @override
  Widget build(BuildContext context) {
    final exercise = widget.exercise;
    final totalSteps = exercise.steps.length;
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';

    final stepTitle = totalSteps == 0
        ? tr('No steps available', locale)
        : '${tr('Step', locale)} ${currentStep + 1} '
        '${tr('of', locale)} $totalSteps';

    final instruction = currentStep < exercise.instructions.length
        ? ExerciseLocalizations.instruction(
      exercise.instructions[currentStep],
      locale,
    )
        : tr(
      'Follow the movement carefully and keep your body under control.',
      locale,
    );

    return Scaffold(
      backgroundColor: const Color(0xFF080A08),
      appBar: AppBar(
        backgroundColor: const Color(0xFF080A08),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          ExerciseLocalizations.name(exercise.name, locale),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stepTitle,
                textDirection:
                isArabic ? TextDirection.rtl : TextDirection.ltr,
                style: const TextStyle(
                  color: mutedText,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 12),

              // Progress bar
              if (totalSteps > 0)
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
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Exercise image
                        Expanded(
                          flex: 5,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFF101810),
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFF193D1B),
                                  Color(0xFF121612),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: neonGreen.withOpacity(0.25),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                exercise.imageAsset,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.contain,
                                errorBuilder:
                                    (context, error, stackTrace) {
                                  return Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.fitness_center,
                                          size: 75,
                                          color:
                                          neonGreen.withOpacity(0.9),
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          ExerciseLocalizations.name(
                                            exercise.name,
                                            locale,
                                          ).toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          tr(
                                            'Exercise image unavailable',
                                            locale,
                                          ),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: mutedText,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        if (totalSteps > 0) ...[
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
                            ExerciseLocalizations.step(
                              exercise.steps[currentStep],
                              locale,
                            ),
                            textDirection: isArabic
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                            textAlign: isArabic
                                ? TextAlign.right
                                : TextAlign.left,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Expanded(
                            flex: 2,
                            child: SingleChildScrollView(
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  instruction,
                                  textDirection: isArabic
                                      ? TextDirection.rtl
                                      : TextDirection.ltr,
                                  textAlign: isArabic
                                      ? TextAlign.right
                                      : TextAlign.left,
                                  style: const TextStyle(
                                    color: mutedText,
                                    height: 1.8,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ] else
                          Expanded(
                            child: Center(
                              child: Text(
                                tr(
                                  'No instructions available for this exercise.',
                                  locale,
                                ),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: mutedText,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Next / Start Workout button
              SizedBox(
                width: double.infinity,
                child: CaliButton(
                  title: totalSteps == 0 ||
                      currentStep == totalSteps - 1
                      ? tr('Start Workout', locale)
                      : tr('Next', locale),
                  icon: totalSteps == 0 ||
                      currentStep == totalSteps - 1
                      ? Icons.check
                      : Icons.arrow_forward,
                  onPressed: () {
                    if (totalSteps > 0 &&
                        currentStep < totalSteps - 1) {
                      setState(() {
                        currentStep++;
                      });
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
              ),

              // Previous button
              Center(
                child: TextButton.icon(
                  onPressed: currentStep > 0
                      ? () {
                    setState(() {
                      currentStep--;
                    });
                  }
                      : null,
                  icon: const Icon(Icons.arrow_back),
                  label: Text(tr('Previous', locale)),
                  style: TextButton.styleFrom(
                    foregroundColor: neonGreen,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}