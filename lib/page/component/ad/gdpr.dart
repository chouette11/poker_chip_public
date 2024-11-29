import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:async_preferences/async_preferences.dart';

void gdpr() {
  final params = ConsentRequestParameters();
  ConsentInformation.instance.requestConsentInfoUpdate(
    params,
    () async {
      if (await ConsentInformation.instance.isConsentFormAvailable()) {
        ConsentForm.loadConsentForm(
          (ConsentForm consentForm) async {
            var status = await ConsentInformation.instance.getConsentStatus();
            if (status == ConsentStatus.required) {
              consentForm.show((formError) {
                _initializeAds();
              });
            } else {
              _initializeAds();
            }
          },
          (formError) {
          },
        );
      }
    },
    (FormError error) {
    },
  );
}

void changeGDPR() {
  ConsentInformation.instance
      .requestConsentInfoUpdate(ConsentRequestParameters(), () async {
    if (await ConsentInformation.instance.isConsentFormAvailable()) {
      ConsentForm.loadConsentForm((consentForm) {
        consentForm.show((formError) async {
          // 同意完了
        });
      }, (formError) {
      });
    }
  }, (error) {
    // error
  });
}

void _initializeAds() async {
  MobileAds.instance.initialize();
}

Future<bool> isUnderGdpr() async {
  // IABTCF_gdprAppliesが 1 であるかどうかをチェックし、それ以外の値であればGDPRの対象外であると解釈
  final preferences = AsyncPreferences();
  return await preferences.getInt('IABTCF_gdprApplies') == 1;
}