import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_widgets.dart';

class ProfilePage extends StatefulWidget {
  final int completed;

  const ProfilePage({
    super.key,
    required this.completed,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _userName = 'CaliCore Athlete';
  String _userEmail = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // جلب البيانات المسجلة محلياً
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? 'CaliCore Athlete';
      _userEmail = prefs.getString('userEmail') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Profile',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 30),
        const Center(
          child: CircleAvatar(
            radius: 65,
            backgroundColor: appPanel,
            child: Icon(
              Icons.person,
              color: neonGreen,
              size: 85,
            ),
          ),
        ),
        const SizedBox(height: 18),
        // عرض اسم المستخدم المخزن
        Center(
          child: Text(
            _userName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 6),
        // عرض البريد الإلكتروني للمستخدم
        if (_userEmail.isNotEmpty)
          Center(
            child: Text(
              _userEmail,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ),
        const SizedBox(height: 8),
        const Center(
          child: Text(
            'TRAIN SMART • GET STRONG',
            style: TextStyle(
              color: mutedText,
              letterSpacing: 2,
              fontSize: 11,
            ),
          ),
        ),
        const SizedBox(height: 30),
        const CaliStat(
          title: 'Athlete Level',
          value: 'Beginner',
          icon: Icons.emoji_events,
        ),
        const SizedBox(height: 12),
        CaliStat(
          title: 'Completed Workouts',
          value: '${widget.completed}',
          icon: Icons.check_circle,
        ),
        const SizedBox(height: 12),
        const CaliStat(
          title: 'Training Program',
          value: 'Calisthenics',
          icon: Icons.fitness_center,
        ),
        const SizedBox(height: 12),
        const CaliStat(
          title: 'Main Goal',
          value: 'Get Stronger',
          icon: Icons.bolt,
        ),
        const SizedBox(height: 30),
        const Center(
          child: Text(
            'BETTER THAN YESTERDAY',
            style: TextStyle(
              color: neonGreen,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}