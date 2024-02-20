import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService{
  static String? get settingsBannerUnitId{
    return "ca-app-pub-5219206073848664/6773598778";
  }
  static String? get historyBannerUnitId{
    return "ca-app-pub-5219206073848664/3500815595";
  }
  static final BannerAdListener settingsBannerAdListener = BannerAdListener(
    onAdFailedToLoad: ((ad, error) {
      ad.dispose();
    })
  );
  static final BannerAdListener historyBannerAdListener = BannerAdListener(
    onAdFailedToLoad: ((ad, error) {
      ad.dispose();
    })
  );

  static String? get interstitialAdUnitId{
    return "ca-app-pub-5219206073848664/1439976077";
  }
}