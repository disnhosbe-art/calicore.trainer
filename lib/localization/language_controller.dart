
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends ChangeNotifier {
  LanguageController._();

  static final LanguageController instance = LanguageController._();

  static const String _key = 'calicore_language';

  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguage = prefs.getString(_key);

    if (savedLanguage == 'ar') {
      _locale = const Locale('ar');
    } else if (savedLanguage == 'fr') {
      _locale = const Locale('fr');
    } else if (savedLanguage == 'pt') {
      _locale = const Locale('pt', 'BR');
    } else {
      _locale = const Locale('en');
    }

    notifyListeners();
  }

  Future<void> setLanguage(String languageCode) async {
    switch (languageCode) {
      case 'ar':
        _locale = const Locale('ar');
        break;
      case 'fr':
        _locale = const Locale('fr');
        break;
      case 'pt':
        _locale = const Locale('pt', 'BR');
        break;
      default:
        _locale = const Locale('en');
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, languageCode);

    notifyListeners();
  }
}
