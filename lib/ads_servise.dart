import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'Ads/app_open_ad_manager .dart';

class AdsService {
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) return;

    await MobileAds.instance.initialize();

    AppOpenAdManager.init();
    AppOpenAdManager.loadAd();

    _initialized = true;
  }
}