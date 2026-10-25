import 'package:flutter/material.dart';
import '../CaliCoreApp.dart';

class OnboardingFlowScreen extends StatefulWidget {
  const OnboardingFlowScreen({super.key});

  @override
  State<OnboardingFlowScreen> createState() => _OnboardingFlowScreenState();
}

class _OnboardingFlowScreenState extends State<OnboardingFlowScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const Color neonGreen = Color(0xFFD4FF00);
  static const Color darkBg = Color(0xFF09090B);
  static const Color cardBg = Color(0xFF18181B);

  int _selectedGoal = 0;
  int _strictPullUpsCount = 10;
  bool _canDoStrictMuscleUp = true;
  final Set<String> _selectedEquipment = {'Pull-up bar', 'Parallel bars', 'Rings'};
  int _selectedDays = 3;

  void _nextPage() {
    if (_currentPage < 4) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // الانتقال مباشرة لصفحة CaliCoreApp الرئيسية
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const CaliCoreApp(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: _currentPage == index ? 24 : 12,
                  height: 4,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? neonGreen : Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                );
              }),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (page) => setState(() => _currentPage = page),
                children: [
                  _buildIntroStep(),
                  _buildGoalStep(),
                  _buildLevelStep(),
                  _buildEquipmentStep(),
                  _buildScheduleStep(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: neonGreen,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: 0,
                  ),
                  onPressed: _nextPage,
                  child: Text(
                    _currentPage == 0 ? "Let's go" : "Continue",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'CALICORE',
            style: TextStyle(
              color: Color(0xFFD4FF00), // اللون النيون المضيء
              fontSize: 32,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'CALISTHENICS TRAINER',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: 36),
          Text(
            'Pull-up #1 to\nmuscle-up #10.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.w900,
              height: 1.15,
            ),
          ),
          SizedBox(height: 28),
          Text(
            'Three programs. Twelve weeks each.\nReal progress.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white60,
              fontSize: 16,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildGoalStep() {
    final goals = [
      {
        'title': 'My First Pull-up / Push-up',
        'sub': 'Build foundational upper body pull & push strength'
      },
      {
        'title': 'Mastering Dips & Muscle-ups',
        'sub': 'Explosive strength & transitioning over the bar'
      },
      {
        'title': 'Front Lever & Back Lever',
        'sub': 'Core & straight-arm pulling static holds'
      },
      {
        'title': 'Full Planche & Straddle Planche',
        'sub': 'Elite shoulder pushing & body control'
      },
      {
        'title': 'Handstand Push-ups & Press',
        'sub': 'Vertical pressing power & balance'
      },
      {
        'title': 'Human Flag & Dragon Flag',
        'sub': 'Lateral core & severe full-body tension'
      },
      {
        'title': 'Advanced Skills (Hefesto, One-Arm Pull-up)',
        'sub': 'Extreme calisthenics skill mastery'
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Text(
            'What are you\nhere for?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w900,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: goals.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final isSelected = _selectedGoal == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedGoal = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? neonGreen : Colors.transparent,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                goals[index]['title']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                goals[index]['sub']!,
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: neonGreen,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildLevelStep() {
    // تحديد وصف المستوى بناءً على العداد
    String _getLevelTitle(int count) {
      if (count < 5) return 'Beginner · Foundation Level';
      if (count < 15) return 'Intermediate · Solid Strength';
      if (count < 30) return 'Advanced · High Endurance';
      return 'Elite · Calisthenics Beast';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          const Text(
            'How many strict reps\ncan you do right\nnow?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w900,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Be honest. The program adjusts to your power.',
            style: TextStyle(color: Colors.white54, fontSize: 15),
          ),
          const Spacer(),

          // شارات إظهار المستوى الديناميكية
          Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: neonGreen.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: neonGreen, width: 1.2),
              ),
              child: Text(
                _getLevelTitle(_strictPullUpsCount),
                style: const TextStyle(
                  color: neonGreen,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // عداد التكرارات المطور (+ / -)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 56,
                onPressed: () {
                  if (_strictPullUpsCount > 0) {
                    setState(() => _strictPullUpsCount--);
                  }
                },
                icon: Container(
                  decoration: const BoxDecoration(color: neonGreen, shape: BoxShape.circle),
                  child: const Icon(Icons.remove_rounded, color: Colors.black, size: 36),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Text(
                  '$_strictPullUpsCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 64,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              IconButton(
                iconSize: 56,
                onPressed: () {
                  if (_strictPullUpsCount < 100) {
                    setState(() => _strictPullUpsCount++);
                  }
                },
                icon: Container(
                  decoration: const BoxDecoration(color: neonGreen, shape: BoxShape.circle),
                  child: const Icon(Icons.add_rounded, color: Colors.black, size: 36),
                ),
              ),
            ],
          ),

          const Spacer(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildEquipmentStep() {
    final equipments = [
      {'title': 'Pull-up bar', 'icon': Icons.horizontal_rule_rounded},
      {'title': 'Parallel bars', 'icon': Icons.density_small_rounded},
      {'title': 'Rings', 'icon': Icons.circle_outlined},
      {'title': 'Resistance bands', 'icon': Icons.graphic_eq_rounded},
      {'title': 'Dip belt', 'icon': Icons.incomplete_circle_rounded},
      {'title': 'Dumbbells', 'icon': Icons.fitness_center_rounded},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          const Text('What do you have acc...', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900)),
          const SizedBox(height: 6),
          const Text('Tap all that apply.', style: TextStyle(color: Colors.white54, fontSize: 14)),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
              ),
              itemCount: equipments.length,
              itemBuilder: (context, index) {
                final item = equipments[index];
                final isSelected = _selectedEquipment.contains(item['title']);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selectedEquipment.remove(item['title']);
                      } else {
                        _selectedEquipment.add(item['title'] as String);
                      }
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: isSelected ? neonGreen : Colors.transparent, width: isSelected ? 2 : 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(item['icon'] as IconData, color: isSelected ? neonGreen : Colors.white70, size: 32),
                        const SizedBox(height: 10),
                        Text(item['title'] as String, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          const Text(
            'How many days a week\ncan you train?',
            style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900, height: 1.15),
          ),
          const SizedBox(height: 10),
          const Text("3 or 4. Don't lie to yourself.", style: TextStyle(color: Colors.white54, fontSize: 15)),
          const SizedBox(height: 36),
          _buildDayOption(3, '3 days'),
          const SizedBox(height: 14),
          _buildDayOption(4, '4 days'),
        ],
      ),
    );
  }

  Widget _buildDayOption(int days, String label) {
    final isSelected = _selectedDays == days;

    return GestureDetector(
      onTap: () => setState(() => _selectedDays = days),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: isSelected ? neonGreen : Colors.transparent, width: isSelected ? 2 : 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(color: isSelected ? neonGreen : Colors.white, fontSize: 26, fontWeight: FontWeight.w900)),
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(color: neonGreen, shape: BoxShape.circle),
                child: const Icon(Icons.check_rounded, color: Colors.black, size: 18),
              ),
          ],
        ),
      ),
    );
  }
}