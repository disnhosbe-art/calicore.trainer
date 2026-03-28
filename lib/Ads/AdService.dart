import 'package:unity_ads_plugin/unity_ads_plugin.dart';

class AdService {

  static bool isInterstitialLoaded = false;
  static bool isRewardedLoaded = false;


  static void initAds() {
    UnityAds.init(
      gameId: "6066169",
      testMode: false,

      onComplete: () {
        print("Ads Ready");

        loadInterstitial();
        loadRewarded();
      },

      onFailed: (error, message) {
        print("Init Failed: $error $message");
      },
    );
  }

  /// ================= INTERSTITIAL =================
  static void loadInterstitial() {
    UnityAds.load(
      placementId: "Interstitial_Android",

      onComplete: (placementId) {
        print("Interstitial Loaded");
        isInterstitialLoaded = true;
      },

      onFailed: (placementId, error, message) {
        print("Interstitial Load Failed");
      },
    );
  }

  static void showInterstitial(Function onFinish) {
    if (isInterstitialLoaded) {
      UnityAds.showVideoAd(
        placementId: "Interstitial_Android",

        onComplete: (placementId) {
          isInterstitialLoaded = false;
          loadInterstitial();
          onFinish();
        },

        onFailed: (placementId, error, message) {
          onFinish();
        },
      );
    } else {
      onFinish();
    }
  }

  /// ================= REWARDED =================
  static void loadRewarded() {
    UnityAds.load(
      placementId: "Rewarded_Android",

      onComplete: (placementId) {
        print("Rewarded Loaded");
        isRewardedLoaded = true;
      },

      onFailed: (placementId, error, message) {
        print("Rewarded Load Failed");
      },
    );
  }

  static void showRewarded(Function onReward) {
    if (isRewardedLoaded) {
      UnityAds.showVideoAd(
        placementId: "Rewarded_Android",

        onComplete: (placementId) {
          isRewardedLoaded = false;
          loadRewarded();

        },

        onFailed: (placementId, error, message) {
          print("Rewarded Failed");
          onReward();
        },
      );
    } else {
      print("Rewarded not loaded");
      onReward();
    }
  }

  /// ================= BANNER =================
  static UnityBannerAd banner() {
    return const UnityBannerAd(
      placementId: "Banner_Android",
    );
  }
}