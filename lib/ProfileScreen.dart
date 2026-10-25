import 'package:flutter/material.dart';
import 'onboarding/onboarding_flow.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F0F14),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD4FF00), // نيون مضيء
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const Welcome(),
    );
  }
}

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final _formKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  String? gender;
  DateTime? birthDate;

  static const Color background = Color(0xFF0F0F14);
  static const Color fieldColor = Color(0xFF1C1F2A);
  static const Color neonGreen = Color(0xFFD4FF00); // اللون النيون الموحد

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  Future<void> _selectBirthDate() async {
    final now = DateTime.now();

    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(1950),
      lastDate: now,
      helpText: 'Choose your date of birth',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: neonGreen,
              onPrimary: Colors.black,
              surface: fieldColor,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selected != null) {
      setState(() => birthDate = selected);
    }
  }

  String get _formattedBirthDate {
    if (birthDate == null) return 'Date of Birth';

    final d = birthDate!;
    return '${d.day.toString().padLeft(2, '0')}/'
        '${d.month.toString().padLeft(2, '0')}/${d.year}';
  }

  void _continue() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    if (gender == null || birthDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please choose your gender and date of birth.'),
          backgroundColor: Color(0xFFB3261E),
        ),
      );
      return;
    }

    // الانتقال للشاشة الموالية مباشرة (OnboardingFlowScreen)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const OnboardingFlowScreen(),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white54),
      prefixIcon: Icon(icon, color: neonGreen),
      filled: true,
      fillColor: fieldColor,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 20,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.white10),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: neonGreen, width: 1.4),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _genderOption({
    required String value,
    required IconData icon,
  }) {
    final selected = gender == value;

    return Expanded(
      child: InkWell(
        onTap: () => setState(() => gender = value),
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: selected ? neonGreen.withOpacity(0.12) : fieldColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? neonGreen : Colors.white10,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 30,
                color: selected ? neonGreen : Colors.white70,
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  color: selected ? neonGreen : Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(22, 20, 22, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: neonGreen.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: const Icon(
                        Icons.fitness_center,
                        color: neonGreen,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CALI CORE',
                          style: TextStyle(
                            color: neonGreen,
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Text(
                          'CALISTHENICS TRAINER',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 9,
                            letterSpacing: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                Container(
                  width: 112,
                  height: 112,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: fieldColor,
                    border: Border.all(color: neonGreen, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: neonGreen.withOpacity(0.12),
                        blurRadius: 25,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/iamg2.png',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.person,
                        size: 64,
                        color: neonGreen,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                const Text(
                  'BUILD YOUR PROFILE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 9),

                const Text(
                  'Personalize your training experience\n'
                      'and start building your strength.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white54,
                    height: 1.5,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 30),

                _sectionTitle('GENDER'),

                Row(
                  children: [
                    _genderOption(
                      value: 'Male',
                      icon: Icons.male,
                    ),
                    const SizedBox(width: 14),
                    _genderOption(
                      value: 'Female',
                      icon: Icons.female,
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                _sectionTitle('DATE OF BIRTH'),

                InkWell(
                  onTap: _selectBirthDate,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: fieldColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          color: neonGreen,
                        ),
                        const SizedBox(width: 13),
                        Expanded(
                          child: Text(
                            _formattedBirthDate,
                            style: TextStyle(
                              color: birthDate == null
                                  ? Colors.white54
                                  : Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white54,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                _sectionTitle('BODY MEASUREMENTS'),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _weightController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration(
                          hint: 'Weight (kg)',
                          icon: Icons.monitor_weight_outlined,
                        ),
                        validator: (value) {
                          final number = double.tryParse(
                            (value ?? '').trim().replaceAll(',', '.'),
                          );

                          if (number == null || number < 20 || number > 350) {
                            return 'Enter valid kg';
                          }

                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _heightController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration(
                          hint: 'Height (cm)',
                          icon: Icons.height,
                        ),
                        validator: (value) {
                          final number = double.tryParse(
                            (value ?? '').trim().replaceAll(',', '.'),
                          );

                          if (number == null || number < 80 || number > 250) {
                            return 'Enter valid cm';
                          }

                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: _continue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: neonGreen,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'LET’S GET STARTED',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward, size: 20),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  'YOUR JOURNEY. YOUR STRENGTH.',
                  style: TextStyle(
                    color: Colors.white30,
                    fontSize: 10,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}