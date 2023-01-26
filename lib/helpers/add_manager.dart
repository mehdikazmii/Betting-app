// ignore_for_file: avoid_print

import 'dart:io';
import 'package:betting_app/helpers/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  RewardedAd? _rewardedAd;
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;

  void loadRewardedAd() {
    RewardedAd.load(
        adUnitId: Platform.isIOS
            ? "ca-app-pub-7778426148576726/5836150571"
            : "ca-app-pub-7778426148576726/7636586900",
        request: const AdRequest(),
        rewardedAdLoadCallback:
            RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
        }, onAdFailedToLoad: (LoadAdError error) {
          print('---------------add error-----------------');
          print(error.toString());
          _rewardedAd = null;
        }));
  }

  // void addAds(bool rewardedAd) {
  // if (rewardedAd) {
  //   loadRewardedAd();
  // }
  // }

  void showRewardedAd(context) {
    if (_rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdShowedFullScreenContent: (RewardedAd ad) {
        print("Ad onAdShowedFullScreenContent");
      }, onAdDismissedFullScreenContent: (RewardedAd ad) {
        ad.dispose();
        loadRewardedAd();
      }, onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        ad.dispose();
        loadRewardedAd();
      });

      _rewardedAd!.setImmersiveMode(true);
      _rewardedAd!.show(
          onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        earnReward(context);
        print("${reward.amount} ${reward.type}");
      });
    }
  }

  earnReward(context) {
    try {
      instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .get()
          .then((snapshot) {
        double wallet = snapshot['wallet'] + 10;
        instance
            .collection('users')
            .doc(auth.currentUser!.uid)
            .update({'wallet': wallet}).then((value) {
          print('reward added');
          showSnackBar('Reward added', context);
        });
      });
    } catch (e) {
      print(e.toString());
      showSnackBar(e.toString(), context);
    }
  }

  void loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: Platform.isIOS
          ? "ca-app-pub-7778426148576726/2192688533"
          : "ca-app-pub-7778426148576726/8267142295",
      size: AdSize.banner,
      request: const AdRequest(),
      listener: const BannerAdListener(),
    );

    _bannerAd?.load();
  }

  void loadInterstitialAd() {
    String interstitialAdId = Platform.isIOS
        ? "ca-app-pub-7778426148576726/9775395589"
        : "ca-app-pub-7778426148576726/5393566940";

    InterstitialAd.load(
        adUnitId: interstitialAdId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;

            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (InterstitialAd ad) {
                ad.dispose();
                loadInterstitialAd();
              },
              onAdFailedToShowFullScreenContent:
                  (InterstitialAd ad, AdError error) {
                ad.dispose();
                loadInterstitialAd();
              },
            );
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
  }

  void addAds(bool interstitial, bool bannerAd, bool rewardedAd) {
    if (rewardedAd) {
      loadRewardedAd();
    }
    if (interstitial) {
      loadInterstitialAd();
    }

    if (bannerAd) {
      loadBannerAd();
    }
  }

  void showInterstitial() {
    _interstitialAd?.show();
  }

  BannerAd? getBannerAd() {
    return _bannerAd;
  }

  void disposeAds() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
  }
}
