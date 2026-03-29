import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobService {
  static String bannerAdUnitId = BannerAd.testAdUnitId;

  static String interstitialAdUnitId = InterstitialAd.testAdUnitId;

  /// banner oluştur
  static BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(),
    );
  }

  /// interstitial reklam
  static void loadInterstitial(Function(InterstitialAd) onLoaded) {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          onLoaded(ad);
        },
        onAdFailedToLoad: (error) {},
      ),
    );
  }
}