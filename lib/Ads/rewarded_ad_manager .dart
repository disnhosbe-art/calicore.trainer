import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardedAdManager {
  static RewardedAd? _rewardedAd;
  static bool _isLoading = false;

  static const String adUnitId =
      "ca-app-pub-5174809671951013/7162949969";

  static void loadAd() {
    if (_isLoading) return;

    _isLoading = true;

    RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isLoading = false;
        },
        onAdFailedToLoad: (error) {
          _rewardedAd = null;
          _isLoading = false;
        },
      ),
    );
  }

  static void showAd({
    required VoidCallback onFinished,
  }) {
    if (_rewardedAd == null) {
      loadAd();
      onFinished();
      return;
    }

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _rewardedAd = null;
        loadAd();
        onFinished();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _rewardedAd = null;
        loadAd();
        onFinished();
      },
    );

    _rewardedAd!.show(
      onUserEarnedReward: (ad, reward) {},
    );
  }
}