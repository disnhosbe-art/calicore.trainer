import 'package:flutter/material.dart';
import '../localization/app_localizations.dart';

class HomePage extends StatelessWidget {
  final int completed;
  final VoidCallback onStart;

  const HomePage({
    super.key,
    required this.completed,
    required this.onStart,
  });

  static const Color bg = Color(0xFF030706);
  static const Color green = Color(0xFF39FF14);

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);

    final workouts = [
      {
        'name': 'CHEST',
        'info': '6 exercises  •  25 min',
        'image': 'assets/01_chest.png',
        'icon': Icons.fitness_center,
      },
      {
        'name': 'BACK',
        'info': '6 exercises  •  30 min',
        'image': 'assets/02_back.png',
        'icon': Icons.accessibility_new,
      },
      {
        'name': 'LEGS',
        'info': '5 exercises  •  25 min',
        'image': 'assets/03_legs.png',
        'icon': Icons.directions_run,
      },
      {
        'name': 'SHOULDERS',
        'info': '5 exercises  •  25 min',
        'image': 'assets/04_shoulders.png',
        'icon': Icons.sports_gymnastics,
      },
      {
        'name': 'ARMS & ABS',
        'info': '6 exercises  •  25 min',
        'image': 'assets/05_arms_abs.png',
        'icon': Icons.fitness_center,
      },
    ];

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 25),
          children: [
            // HEADER
            Row(
              children: [
                const Icon(
                  Icons.bolt,
                  color: green,
                  size: 45,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Cali',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              height: 1,
                            ),
                          ),
                          Text(
                            'Core',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: green,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 7),
                      Text(
                        'TRAIN SMART  •  GET STRONG',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 9,
                          letterSpacing: 2.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // HERO BANNER
            Container(
              height: 200,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFF07100A),
                border: Border.all(
                  color: green.withValues(alpha: 0.20),
                ),
              ),
              child: Image.asset(
                'assets/saitama.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.fitness_center,
                      color: green,
                      size: 60,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // SECTION TITLE
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${tr.text('choose_workout')} ',
                  ),
                  TextSpan(
                    text: tr.text('workout'),
                    style: const TextStyle(color: green),
                  ),
                ],
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 27,
                fontWeight: FontWeight.w900,
              ),
            ),

            const SizedBox(height: 16),

            // WORKOUT CARDS
            ...workouts.map((workout) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Material(
                  color: const Color(0xFF07100D),
                  borderRadius: BorderRadius.circular(15),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: onStart,
                    child: Container(
                      height: 108,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: green.withValues(alpha: 0.75),
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        children: [
                          // IMAGE
                          SizedBox(
                            width: 125,
                            height: double.infinity,
                            child: Image.asset(
                              workout['image'] as String,
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                              errorBuilder: (
                                  context,
                                  error,
                                  stackTrace,
                                  ) {
                                return Container(
                                  color: const Color(0xFF102014),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    workout['icon'] as IconData,
                                    color: green,
                                    size: 42,
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(width: 12),

                          // WORKOUT DETAILS
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  workout['name'] as String,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  workout['info'] as String,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: Icon(
                              Icons.chevron_right,
                              color: green,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 8),

            // START BUTTON
            SizedBox(
              height: 55,
              child: ElevatedButton.icon(
                onPressed: onStart,
                icon: const Icon(
                  Icons.play_arrow,
                  color: Colors.black,
                ),
                label: Text(
                  tr.text('start_workout'),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 14),

            Center(
              child: Text(
                '${tr.text('workouts_completed')}: $completed',
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 11,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
