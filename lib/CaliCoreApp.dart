import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home_page.dart';
import 'screens/workouts_page.dart';
import 'screens/progress_page.dart';
import 'screens/profile_page.dart';
import 'widgets/custom_widgets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CaliCoreApp());
}

class CaliCoreApp extends StatelessWidget {
  const CaliCoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CaliCore',

      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: appBg,

        colorScheme: const ColorScheme.dark(
          primary: neonGreen,
          surface: appPanel,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: appBg,
          foregroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
      ),

      builder: (context, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: appBg,
            systemNavigationBarDividerColor: appBg,
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarContrastEnforced: false,
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },

      home: const MainScreen(),
    );

  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  int completedWorkouts = 0;
  int totalReps = 0;

  void completeWorkout(int reps) {
    setState(() {
      completedWorkouts++;
      totalReps += reps;
    });
  }

  void changePage(int index) {
    if (index == selectedIndex) return;

    setState(() {
      selectedIndex = index;
    });

  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        completed: completedWorkouts,
        onStart: () => changePage(1),
      ),
      WorkoutsPage(
        onWorkoutComplete: completeWorkout,
      ),
      ProgressPage(
        completed: completedWorkouts,
        totalReps: totalReps,
      ),
      ProfilePage(
        completed: completedWorkouts,
      ),
    ];

    final bottomInset = MediaQuery.of(context).viewPadding.bottom;

    return Scaffold(
      extendBody: true,
      backgroundColor: appBg,

      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: selectedIndex,
          children: pages,
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          18,
          0,
          18,
          bottomInset > 0 ? bottomInset + 6 : 14,
        ),

        child: Container(
          height: 72,

          decoration: BoxDecoration(
            color: const Color(0xFF191919),

            borderRadius: BorderRadius.circular(40),

            border: Border.all(
              color: Colors.white.withValues(alpha: 0.10),
              width: 1,
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.22),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),

          child: Row(
            children: [
              _navItem(
                index: 0,
                icon: Icons.home_outlined,
                selectedIcon: Icons.home_rounded,
              ),

              _navItem(
                index: 1,
                icon: Icons.fitness_center_outlined,
                selectedIcon: Icons.fitness_center_rounded,
              ),

              _navItem(
                index: 2,
                icon: Icons.bar_chart_outlined,
                selectedIcon: Icons.bar_chart_rounded,
              ),

              _navItem(
                index: 3,
                icon: Icons.person_outline_rounded,
                selectedIcon: Icons.person_rounded,
              ),
            ],
          ),
        ),
      ),
    );

  }

  Widget _navItem({
    required int index,
    required IconData icon,
    required IconData selectedIcon,
  }) {
    final isSelected = selectedIndex == index;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5),

        child: Material(
          color: Colors.transparent,

          child: InkWell(
            onTap: () => changePage(index),
            borderRadius: BorderRadius.circular(35),

            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOutCubic,

              decoration: BoxDecoration(
                color: isSelected
                    ? neonGreen.withValues(alpha: 0.13)
                    : Colors.transparent,

                borderRadius: BorderRadius.circular(35),

                border: isSelected
                    ? Border.all(
                  color: neonGreen.withValues(alpha: 0.12),
                )
                    : null,
              ),

              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),

                  transitionBuilder: (child, animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },

                  child: Icon(
                    isSelected ? selectedIcon : icon,
                    key: ValueKey('$index-$isSelected'),

                    color: isSelected
                        ? neonGreen
                        : Colors.white.withValues(alpha: 0.65),

                    size: isSelected ? 29 : 26,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }
}