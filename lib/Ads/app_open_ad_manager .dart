import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppOpenAdManager with WidgetsBindingObserver {
  static AppOpenAd? _appOpenAd;

  static bool _isLoading = false;
  static bool _isShowing = false;
  static bool _hasShown = false;

  static DateTime? _lastPausedTime;

  static const String adUnitId =
      "ca-app-pub-5174809671951013/3545306953";

  /// 👇 تناديها فـ main()
  static void init() {
    WidgetsBinding.instance.addObserver(AppOpenAdManager());
  }

  /// 👇 تحميل الإعلان
  static void loadAd() {
    if (_isLoading || _appOpenAd != null) return;

    _isLoading = true;

    AppOpenAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          _isLoading = false;

          print("✅ App Open Loaded");

          // 👇 أول مرة فقط
          if (!_hasShown) {
            showAdIfAvailable();
          }
        },
        onAdFailedToLoad: (error) {
          _isLoading = false;
          _appOpenAd = null;

          print("❌ $error");
        },
      ),
    );
  }

  /// 👇 عرض الإعلان
  static void showAdIfAvailable() {
    if (_hasShown || _isShowing) return;
    if (_appOpenAd == null) return;

    _hasShown = true;
    _isShowing = true;

    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _appOpenAd = null;
        _isShowing = false;

        // 👇 نحضرو إعلان للمرة الجاية
        loadAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _appOpenAd = null;
        _isShowing = false;

        loadAd();
      },
    );

    _appOpenAd!.show();
    _appOpenAd = null;
  }

  /// 👇 التحكم فـ الخروج والدخول
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _lastPausedTime = DateTime.now();
    }

    if (state == AppLifecycleState.resumed) {
      if (_lastPausedTime == null) return;

      final diff = DateTime.now().difference(_lastPausedTime!);

      // 👇 إلا خرج فعلاً من الأب
      if (diff.inSeconds >= 3) {
        print("🚀 رجع من خارج التطبيق");

        _hasShown = false;

        loadAd(); // 👈 هنا غادي يطلع الإعلان
      } else {
        print("⚠️ غير تنقل داخل الأب");
      }
    }
  }
}