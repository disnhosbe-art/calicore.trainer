import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../localization/app_localizations.dart';
import '../localization/language_controller.dart';

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
  static const Color backgroundColor = Color(0xFF080B09);
  static const Color cardColor = Color(0xFF121713);
  static const Color greenColor = Color(0xFFB7FF32);

  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.calicore.trainer';

  // Add your published Privacy Policy URL here.
  static const String privacyPolicyUrl = '';

  String userName = 'Athlete';
  String userEmail = '';

  List<Map<String, dynamic>> favorites = [];

  int selectedRating = 0;
  int savedRating = 0;

  AppLocalizations get tr => AppLocalizations.of(context);

  @override
  void initState() {
    super.initState();
    _loadProfile();
    _loadRating();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final savedFavorites =
        prefs.getStringList('favorite_exercises') ?? [];

    final List<Map<String, dynamic>> loadedFavorites = [];

    for (final item in savedFavorites) {
      try {
        final decoded = jsonDecode(item);
        if (decoded is Map) {
          loadedFavorites.add(Map<String, dynamic>.from(decoded));
        }
      } catch (_) {
        // Ignore invalid saved entries.
      }
    }

    if (!mounted) return;

    setState(() {
      userName = prefs.getString('userName') ?? 'Athlete';
      userEmail = prefs.getString('userEmail') ?? '';
      favorites = loadedFavorites;
    });
  }

  Future<void> _loadRating() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;

    final rating = prefs.getInt('calicore_rating') ?? 0;

    setState(() {
      savedRating = rating;
      selectedRating = rating;
    });
  }

  Future<void> _saveRating() async {
    if (selectedRating < 1 || selectedRating > 4) {
      _showMessage(tr.text('select_rating'));
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('calicore_rating', selectedRating);

    if (!mounted) return;

    setState(() {
      savedRating = selectedRating;
    });

    _showMessage(tr.text('saved'));
  }

  Future<void> _chooseLanguage() async {
    final currentLanguage =
        LanguageController.instance.locale.languageCode;

    final selected = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: cardColor,
          title: Text(
            tr.text('choose_language'),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _languageOption(
                dialogContext, 'en', '🇬🇧',
                tr.text('english'), currentLanguage,
              ),
              _languageOption(
                dialogContext, 'ar', '🇲🇦',
                tr.text('arabic'), currentLanguage,
              ),
              _languageOption(
                dialogContext, 'fr', '🇫🇷',
                tr.text('french'), currentLanguage,
              ),
              _languageOption(
                dialogContext, 'pt', '🇧🇷',
                tr.text('portuguese'), currentLanguage,
              ),
            ],
          ),
        );
      },
    );

    if (selected != null) {
      await LanguageController.instance.setLanguage(selected);
      if (mounted) setState(() {});
    }
  }

  Widget _languageOption(
      BuildContext dialogContext,
      String code,
      String flag,
      String name,
      String currentLanguage,
      ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Text(flag, style: const TextStyle(fontSize: 23)),
      title: Text(name, style: const TextStyle(color: Colors.white)),
      trailing: currentLanguage == code
          ? const Icon(
        Icons.check_circle_rounded,
        color: greenColor,
      )
          : null,
      onTap: () => Navigator.pop(dialogContext, code),
    );
  }

  Future<void> _removeFavorite(int index) async {
    final removed = favorites[index];
    final prefs = await SharedPreferences.getInstance();

    final savedFavorites =
        prefs.getStringList('favorite_exercises') ?? [];

    savedFavorites.removeWhere((item) {
      try {
        final decoded = jsonDecode(item);
        return decoded is Map && decoded['name'] == removed['name'];
      } catch (_) {
        return false;
      }
    });

    await prefs.setStringList('favorite_exercises', savedFavorites);

    if (!mounted) return;

    setState(() {
      favorites.removeAt(index);
    });

    _showMessage(tr.text('exercise_removed'));
  }

  Future<void> _openLink(String url) async {
    final uri = Uri.tryParse(url);

    if (uri == null ||
        !uri.hasScheme ||
        (uri.scheme != 'https' && uri.scheme != 'http')) {
      _showMessage(tr.text('link_not_configured'));
      return;
    }

    try {
      final opened = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!opened && mounted) {
        _showMessage(tr.text('open_link_error'));
      }
    } catch (_) {
      if (mounted) {
        _showMessage(tr.text('open_link_error'));
      }
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: cardColor,
      ),
    );
  }

  Widget _sectionTitle(String title, {String? subtitle}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 5),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _statCard({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 8,
        ),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: greenColor.withValues(alpha: 0.12),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: greenColor, size: 23),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        leading: Container(
          width: 43,
          height: 43,
          decoration: BoxDecoration(
            color: greenColor.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(icon, color: greenColor, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 11,
            ),
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white38,
          size: 15,
        ),
      ),
    );
  }

  Widget _favoriteCard(Map<String, dynamic> exercise, int index) {
    final name = exercise['name']?.toString() ?? 'Exercise';
    final muscles = exercise['muscles']?.toString() ?? 'Workout';
    final duration = exercise['duration']?.toString() ?? '';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            width: 47,
            height: 47,
            decoration: BoxDecoration(
              color: greenColor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.fitness_center_rounded,
              color: greenColor,
              size: 23,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  muscles,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
                if (duration.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    duration,
                    style: const TextStyle(
                      color: greenColor,
                      fontSize: 11,
                    ),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            tooltip: tr.text('remove_favorite'),
            onPressed: () => _removeFavorite(index),
            icon: const Icon(
              Icons.favorite_rounded,
              color: Colors.redAccent,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget _ratingSection() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: greenColor.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr.text('rating'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            tr.text('rating_description'),
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(4, (index) {
              final starNumber = index + 1;

              return IconButton(
                tooltip: '$starNumber / 4',
                onPressed: () {
                  setState(() => selectedRating = starNumber);
                },
                icon: Icon(
                  starNumber <= selectedRating
                      ? Icons.star_rounded
                      : Icons.star_outline_rounded,
                  color: greenColor,
                  size: 32,
                ),
              );
            }),
          ),
          Text(
            '$selectedRating / 4',
            style: const TextStyle(
              color: greenColor,
              fontWeight: FontWeight.w800,
            ),
          ),
          if (savedRating > 0) ...[
            const SizedBox(height: 4),
            Text(
              '${tr.text('saved')} ($savedRating/4)',
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 11,
              ),
            ),
          ],
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveRating,
              style: ElevatedButton.styleFrom(
                backgroundColor: greenColor,
                foregroundColor: Colors.black,
              ),
              child: Text(tr.text('submit_rating')),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _openLink(playStoreUrl),
              icon: const Icon(Icons.shop_rounded),
              label: Text(tr.text('play_store')),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          color: greenColor,
          backgroundColor: cardColor,
          onRefresh: _loadProfile,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 125),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      tr.text('profile'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: greenColor.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.bolt_rounded,
                          color: greenColor,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'ARC MODE',
                          style: TextStyle(
                            color: greenColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF202A1B),
                      Color(0xFF121713),
                      Color(0xFF101210),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: greenColor.withValues(alpha: 0.25),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: greenColor,
                          width: 2,
                        ),
                      ),
                      child: const CircleAvatar(
                        radius: 48,
                        backgroundColor: Color(0xFF202820),
                        backgroundImage: AssetImage('assets/iamg1.png'),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      userName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    if (userEmail.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        userEmail,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        tr.text('athlete_title'),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              _settingsTile(
                icon: Icons.language_rounded,
                title: tr.text('language'),
                subtitle: tr.text('choose_language'),
                onTap: _chooseLanguage,
              ),

              const SizedBox(height: 8),
              _ratingSection(),
              const SizedBox(height: 26),

              _sectionTitle(
                tr.text('your_journey'),
                subtitle: tr.text('progress_subtitle'),
              ),

              Row(
                children: [
                  _statCard(
                    icon: Icons.check_circle_outline_rounded,
                    value: '${widget.completed}',
                    label: tr.text('completed'),
                  ),
                  const SizedBox(width: 10),
                  _statCard(
                    icon: Icons.favorite_rounded,
                    value: '${favorites.length}',
                    label: tr.text('favorites'),
                  ),
                  const SizedBox(width: 10),
                  _statCard(
                    icon: Icons.local_fire_department_rounded,
                    value: widget.completed > 0
                        ? tr.text('active')
                        : tr.text('ready'),
                    label: tr.text('status'),
                  ),
                ],
              ),

              const SizedBox(height: 27),

              _sectionTitle(
                tr.text('saved_exercises'),
                subtitle: tr.text('favorites_subtitle'),
              ),

              if (favorites.isEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 27,
                    horizontal: 18,
                  ),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.favorite_border_rounded,
                        color: greenColor,
                        size: 36,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        tr.text('no_favorites'),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        tr.text('no_favorites_subtitle'),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ...List.generate(
                  favorites.length,
                      (index) => _favoriteCard(favorites[index], index),
                ),

              const SizedBox(height: 25),

              _sectionTitle(
                tr.text('app_support'),
                subtitle: tr.text('app_support_subtitle'),
              ),

              _settingsTile(
                icon: Icons.privacy_tip_outlined,
                title: tr.text('privacy_policy'),
                subtitle: tr.text('privacy_subtitle'),
                onTap: () {
                  if (privacyPolicyUrl.isEmpty) {
                    _showMessage(tr.text('privacy_not_configured'));
                  } else {
                    _openLink(privacyPolicyUrl);
                  }
                },
              ),

              _settingsTile(
                icon: Icons.shop_rounded,
                title: tr.text('google_play_title'),
                subtitle: tr.text('google_play_subtitle'),
                onTap: () => _openLink(playStoreUrl),
              ),

              _settingsTile(
                icon: Icons.refresh_rounded,
                title: tr.text('refresh_profile'),
                subtitle: tr.text('refresh_subtitle'),
                onTap: _loadProfile,
              ),

              const SizedBox(height: 20),

              Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.bolt_rounded,
                      color: greenColor,
                      size: 28,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      tr.text('built_for_progress'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: greenColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'CaliCore Calisthenics • v22.0.0',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.4),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}