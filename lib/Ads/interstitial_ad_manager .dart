import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:ui';

class InterstitialAdManager {
  static InterstitialAd? _interstitialAd;
  static bool _isLoading = false;

  // Test Interstitial ID
  static const String adUnitId =
      "ca-app-pub-5174809671951013/4167389997";

  static void loadAd() {
    if (_isLoading || _interstitialAd != null) return;

    _isLoading = true;

    InterstitialAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isLoading = false;
          print("Interstitial Loaded");
        },
        onAdFailedToLoad: (error) {
          _interstitialAd = null;
          _isLoading = false;
          print("Failed: $error");
        },
      ),
    );
  }

  static void showAd({required VoidCallback onComplete}) {
    if (_interstitialAd == null) {
      loadAd();
      onComplete();
      return;
    }

    _interstitialAd!.fullScreenContentCallback =
        FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad) {
            ad.dispose();
            _interstitialAd = null;
            loadAd();
            onComplete();
          },
          onAdFailedToShowFullScreenContent: (ad, error) {
            ad.dispose();
            _interstitialAd = null;
            loadAd();
            onComplete();
          },
        );

    _interstitialAd!.show();
  }
}